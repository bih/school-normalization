require 'spec_helper'

RSpec.describe Normalizer do
  context "Modules" do
    it { expect(Normalizer).to be_a(Module) }
  end
  
  context "Classes" do
    it { expect(Normalizer::Application).to be_a(Class) }
    it { expect(Normalizer::Entry).to be_a(Class) }
    it { expect(Normalizer::Parser).to be_a(Class) }
  end
end