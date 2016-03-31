require 'spec_helper'

RSpec.describe Normalizer::Entry do
  context "Error Classes" do
    it { expect(Normalizer::Entry::TypeNotProvidedError).to be < StandardError }
    it { expect(Normalizer::Entry::TypeNotValidError).to be < StandardError }
    it { expect(Normalizer::Entry::NameNotProvidedError).to be < StandardError }
    it { expect(Normalizer::Entry::NameNotValidError).to be < StandardError }
    it { expect(Normalizer::Entry::NameMustBeCapitalizedError).to be < StandardError }
    it { expect(Normalizer::Entry::AbbreviationNotValidError).to be < StandardError }
    it { expect(Normalizer::Entry::AbbreviationCannotExceed5CharactersError).to be < StandardError }
    it { expect(Normalizer::Entry::URLNotProvidedError).to be < StandardError }
    it { expect(Normalizer::Entry::URLNotValidError).to be < StandardError }
    it { expect(Normalizer::Entry::Normalization).to be_a_kind_of(Class) }
    it { expect(Normalizer::Entry::Normalization::AlternativesNotValidError).to be < StandardError }
    it { expect(Normalizer::Entry::Normalization::AlternativeNotValidError).to be < StandardError }
    it { expect(Normalizer::Entry::Normalization::AlternativeAlreadyUsedError).to be < StandardError }
  end
end