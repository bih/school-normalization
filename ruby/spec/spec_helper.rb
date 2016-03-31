require './normalizer'
require 'tempfile'

module Helpers
  module EntryHelper
    DEFAULT_ENTRY_HASH = {
      school: {
        type: "university",
        name: "Manchester Metropolitan University",
        abbreviation: "MMU",
        url: "http://www.mmu.ac.uk"
      },
      normalization: {
        alternatives: [
          "Man Met",
          "Man Met Uni",
          "Manchester Met",
          "Manchester Metropolitan",
          "Manchester Polytechnic",
          "Manchester Polytechnic University"
        ]
      }
    }

    def create_entry(override_hash = {})
      hash = DEFAULT_ENTRY_HASH.deep_merge(override_hash)
      hash = hash.with_indifferent_access

      tempfile = Tempfile.new("entry")
      tempfile.write(hash.to_yaml)
      tempfile.close

      Normalizer::Entry.new(filename: tempfile.path)
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include(Helpers::EntryHelper)
end