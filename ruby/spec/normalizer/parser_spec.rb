require 'spec_helper'

RSpec.describe Normalizer::Parser do
  READ_DIRECTORY = "./spec/tmp/data/v1/schools/**/**.yml"
  WRITE_FILE = "./spec/dist/schools.json"

  before(:each) do
    create_example_entry
  end

  context "Validations" do
    context 'is valid' do
      it 'returns no errors' do
        expect {
          Normalizer::Parser.new(directory: READ_DIRECTORY)
        }.not_to raise_error
      end
    end

    describe '#to_json' do
      it 'returns valid JSON' do
        json = Normalizer::Parser.new(directory: READ_DIRECTORY).to_json

        expect { JSON.parse(json) }.not_to raise_error
      end
    end

    describe '#save_to!' do
      it 'saves to file successfully' do
        tempfile = Tempfile.new("testing_valid_json")
        tempfile.close

        parser = Normalizer::Parser.new(directory: READ_DIRECTORY)
        parser.save_to!(filename: tempfile.path)

        parsed_as_yaml = YAML.load_file(tempfile.path).to_json
        tempfile.unlink

        expect(parsed_as_yaml).to eq(parser.to_json)
      end
    end
  end

  private

  def create_example_entry
    filepath = "./spec/tmp/data/v1/schools/europe/united-kingdom/england/manchester-metropolitan-university.yml"

    @create_example_entry ||= File.open(filepath, "w+") do |file|
      file.write(Helpers::EntryHelper::DEFAULT_ENTRY_HASH.to_yaml)
    end
  end
end