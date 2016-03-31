require 'spec_helper'

RSpec.describe Normalizer::Entry do
  describe "@data.school.name" do
    it 'raises error if not provided' do
      expect {
        create_entry(school: { name: nil })
      }.to raise_error(Normalizer::Entry::NameNotProvidedError)
    end

    it 'raises error if not a string' do
      expect {
        create_entry(school: { name: 5 })
      }.to raise_error(Normalizer::Entry::NameNotValidError)
    end

    it 'raises error if not capitalized' do
      expect {
        create_entry(school: { name: 'random university' })
      }.to raise_error(Normalizer::Entry::NameMustBeCapitalizedError)
    end

    it 'is valid' do
      expect {
        create_entry(school: { name: 'Random University' })
        create_entry(school: { name: 'Other University' })
      }.not_to raise_error
    end
  end
end