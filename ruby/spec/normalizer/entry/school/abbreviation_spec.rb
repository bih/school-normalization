require 'spec_helper'

RSpec.describe Normalizer::Entry do
  describe "@data.school.abbreviation" do
    it 'raises error if not a string' do
      expect {
        create_entry(school: { abbreviation: 5 })
      }.to raise_error(Normalizer::Entry::AbbreviationNotValidError)
    end

    it 'raises error if exceeds 5 characters' do
      expect {
        create_entry(school: { abbreviation: 'abcdef' })
      }.to raise_error(Normalizer::Entry::AbbreviationCannotExceed5CharactersError)
    end

    it 'is valid' do
      expect {
        create_entry(school: { abbreviation: nil })
        create_entry(school: { abbreviation: 'MMU' })
        create_entry(school: { abbreviation: 'UOM' })
      }.not_to raise_error
    end
  end
end