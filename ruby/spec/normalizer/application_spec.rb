require 'spec_helper'

RSpec.describe Normalizer::Application do
  context "Constants" do
    it { expect(Normalizer::Application).to be_const_defined(:DIRECTORY) }
  end

  context "Inheritance" do
    it { expect(Normalizer::Application).to be < Sinatra::Application }
  end
end