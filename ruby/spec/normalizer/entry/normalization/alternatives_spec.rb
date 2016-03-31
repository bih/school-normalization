require 'spec_helper'

RSpec.describe Normalizer::Entry do
  describe "@data.normalization.alternatives" do
    it 'raises error if empty' do
      expect {
        create_entry(normalization: { alternatives: nil })
      }.to raise_error(Normalizer::Entry::Normalization::AlternativesNotValidError)
    end

    it 'raises error if a string' do
      expect {
        create_entry(normalization: { alternatives: "hi world" })
      }.to raise_error(Normalizer::Entry::Normalization::AlternativesNotValidError)
    end

    it 'raises error if an array but contains at least one non-string' do
      expect {
        create_entry(normalization: { alternatives: ["name a", "name b", "name c", nil] })
      }.to raise_error(Normalizer::Entry::Normalization::AlternativeNotValidError)

      expect {
        create_entry(normalization: { alternatives: ["name a", 1234, "name b", "name c"] })
      }.to raise_error(Normalizer::Entry::Normalization::AlternativeNotValidError)
    end

    it 'raises error if an array and contains duplicates' do
      expect {
        create_entry(normalization: { alternatives: ["name a", "name b", "name a"] })
      }.to raise_error(Normalizer::Entry::Normalization::AlternativeAlreadyUsedError)

      expect {
        create_entry(normalization: { alternatives: ["name a", "name b", "Name A"] })
      }.to raise_error(Normalizer::Entry::Normalization::AlternativeAlreadyUsedError)
    end

    it 'is valid' do
      expect {
        create_entry(normalization: { alternatives: ["School Name A", "School Name B", "School Name C"] })
        create_entry(normalization: { alternatives: [] })
        create_entry(normalization: { alternatives: ["Random School"] })
      }.not_to raise_error
    end
  end
end