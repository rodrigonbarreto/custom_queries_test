require 'rails_helper'

RSpec.describe Location, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #
  describe ".in_region" do
    it "returns locations in the named region" do
      # pending "Fix this spec first"

      region = create(:region, name: "expected")
      other_region = create(:region, name: "other")
      create(:location, region: region, name: "in-expected-region-one")
      create(:location, region: region, name: "in-expected-region-two")
      create(:location, region: other_region, name: "in-other-region")

      result = Location.in_region("expected")

      expect(result.map(&:name)).
          to match_array(%w(in-expected-region-one in-expected-region-two))
    end
  end
end
