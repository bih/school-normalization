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
    def initialize(filename:)
      @hash = YAML.load_file(filename)
      @hash = @hash.with_indifferent_access
    end

    attr_reader :hash
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