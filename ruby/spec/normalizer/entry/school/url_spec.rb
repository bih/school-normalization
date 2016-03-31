require 'spec_helper'

RSpec.describe Normalizer::Entry do
  describe "@data.school.url" do
    it 'raises error if not provided' do
      expect {
        create_entry(school: { url: nil })
      }.to raise_error(Normalizer::Entry::URLNotProvidedError)
    end

    it 'raises error if not a string' do
      expect {
        create_entry(school: { url: 5 })
      }.to raise_error(Normalizer::Entry::URLNotValidError)
    end

    it 'raises error if not a valid URL' do
      expect {
        create_entry(school: { url: 'http:/google.com' })
      }.to raise_error(Normalizer::Entry::URLNotValidError)

      expect {
        create_entry(school: { url: 'google.com' })
      }.to raise_error(Normalizer::Entry::URLNotValidError)

      expect {
        create_entry(school: { url: 'http:google.com' })
      }.to raise_error(Normalizer::Entry::URLNotValidError)
    end

    it 'is valid' do
      expect {
        create_entry(school: { url: 'http://www.mmu.ac.uk' })
        create_entry(school: { url: 'http://mmu.ac.uk' })
        create_entry(school: { url: 'http://www.mmu.ac.uk/Pages/Home.aspx' })
        create_entry(school: { url: '//www.mmu.ac.uk/Pages/Home.aspx' })
      }.not_to raise_error
    end
  end
end