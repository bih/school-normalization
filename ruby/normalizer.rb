require 'active_support'
require 'active_support/core_ext'
require 'bundler'
require 'yaml'

Bundler.require

module Normalizer
  class Application < Sinatra::Application
    DIRECTORY = "../data/v1/schools/**/**.yml"

    get '/' do
      Normalizer::Parser.new(directory: DIRECTORY).to_json
    end
  end

  class Entry < Hash
    class TypeNotProvidedError < StandardError; end
    class TypeNotValidError < StandardError; end
    class NameNotProvidedError < StandardError; end
    class NameNotValidError < StandardError; end
    class NameMustBeCapitalizedError < StandardError; end
    class AbbreviationMustBeAStringError < StandardError; end
    class AbbreviationCannotExceed5CharactersError < StandardError; end
    class URLNotProvidedError < StandardError; end
    class URLNotValidError < StandardError; end
    class Normalization; end
    class Normalization::AlternativesNotValidError < StandardError; end
    class Normalization::AlternativeNotValidError < StandardError; end
    class Normalization::AlternativeAlreadyUsedError < StandardError; end

    def initialize(filename:)
      @hash = YAML.load_file(@filename = filename)
      @hash = @hash.with_indifferent_access

      validate_type
      validate_name
      validate_abbreviation
      validate_url
      validate_normalization_alternatives
    end

    attr_reader :filename, :hash

    private

    def validate_type
      type = @hash[:school][:type]

      raise_error TypeNotProvidedError unless type.present?
      raise_error TypeNotValidError unless type.is_a?(String)
      raise_error TypeNotValidError unless type.eql?('university') || type.eql?('high-school')
    end

    def validate_name
      name = @hash[:school][:name]

      raise_error NameNotProvidedError unless name.present?
      raise_error NameNotValidError unless name.is_a?(String)
      raise_error NameMustBeCapitalizedError unless name != name.downcase
    end

    def validate_abbreviation
      abbreviation = @hash[:school][:abbreviation]

      if abbreviation
        raise_error AbbreviationMustBeAStringError unless abbreviation.is_a?(String)
        raise_error AbbreviationCannotExceed5CharactersError unless abbreviation.length < 5
      end
    end

    def validate_url
      url = @hash[:school][:url]

      raise_error URLNotProvidedError unless url.present?
      raise_error URLNotValidError unless url.is_a?(String)
      raise_error URLNotValidError unless URL.new(url).host.present?
    end

    def validate_normalization_alternatives
      alternatives = @hash[:normalization][:alternatives]

      raise_error Normalization::AlternativesNotValidError unless alternatives.is_a?(Array)
      raise_error Normalization::AlternativeNotValidError unless alternatives.all? { |alternative| alternative.is_a?(String) }

      alternatives_downcased = alternatives.map(&:downcase)

      raise_error Normalization::AlternativeAlreadyUsedError unless alternatives_downcased.uniq == alternatives_downcased
      raise_error Normalization::AlternativeAlreadyUsedError if alternatives_downcased.include?(@hash[:school][:name].downcase)
    end

    def raise_error(error)
      raise error.new(@filename)
    end
  end

  class Parser
    def initialize(directory:)
      @filenames = Dir[directory]
    end

    def to_json
      read_files_as_yaml.map(&:hash).to_json
    end

    def save_to!(filename:)
      file = File.open(filename, "w+")
      file.write(to_json)
      file.close
    end

    private

    def read_files_as_yaml
      @filenames.map do |filename|
        Entry.new(filename: filename)
      end
    end

    attr_reader :filenames
  end
end