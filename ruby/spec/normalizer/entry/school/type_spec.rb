require 'spec_helper'

RSpec.describe Normalizer::Entry do
  describe "@data.school.type" do
    it 'raises error if not provided' do
      expect {
        create_entry(school: { type: nil })
      }.to raise_error(Normalizer::Entry::TypeNotProvidedError)
    end

    it 'raises error if not university or high-school' do
      expect {
        create_entry(school: { type: 'random' })
      }.to raise_error(Normalizer::Entry::TypeNotValidError)
    end

    it 'raises error if not a string' do
      expect {
        create_entry(school: { type: 'random' })
      }.to raise_error(Normalizer::Entry::TypeNotValidError)
    end

    it 'is valid' do
      expect {
        create_entry(school: { type: 'university' })
        create_entry(school: { type: 'high-school' })
      }.not_to raise_error
    end
  end
end