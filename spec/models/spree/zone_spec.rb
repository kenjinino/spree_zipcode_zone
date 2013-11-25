require 'spec_helper'

describe Spree::Zone do

  context "#include?" do
    let(:zipcode_range) { FactoryGirl.create(:zipcode_range) }
    let(:address) { FactoryGirl.create(:address) }

    context "when zone is zipcode_range type" do
      let(:zipcode_range_zone) { FactoryGirl.create(:zone, name: 'ZipcodeRangeZone') }
      before { zipcode_range_zone.members.create(zoneable: zipcode_range) }

      context "and it is in range" do
        it do
          address.zipcode = "11111111"
          zipcode_range_zone.include?(address).should be_true
        end
      end

      context "and it is not in range" do
        it do
          address.zipcode = "33333333"
          zipcode_range_zone.include?(address).should_not be_true
        end
      end
    end
  end

  context "#save" do
    context "when a zone member country is added to an existing zone consisting of state members" do
      let(:zone) { FactoryGirl.create(:zone, name: 'foo', zone_members: []) }
      let(:state) { FactoryGirl.create(:state) }
      let(:zipcode_range) { FactoryGirl.create(:zipcode_range) }

      before do
        zone.members.create(zoneable: state)
        @zipcode_range_member = zone.members.create(zoneable: zipcode_range)
        zone.save
      end

      it "should remove existing state members" do
        zone.reload.members.should == [@zipcode_range_member]
      end
    end
  end

  context "#kind" do
    context "when the zone consists of zipcode_range zone members" do
      before do
        @zone = FactoryGirl.create(:zone, name: 'zipcode_range', zone_members: [])
        @zone.members.create(zoneable: FactoryGirl.create(:zipcode_range))
      end

      it "should return the kind of zone member" do
        @zone.kind.should == "zipcode_range"
      end
    end
  end

  context "#match" do
    let(:zipcode_range_zone) { FactoryGirl.create(:zone, name: 'ZipcodeRangeZone') }
    let(:zipcode_range) { FactoryGirl.create(:zipcode_range) }

    before { zipcode_range_zone.members.create(zoneable: zipcode_range) }

    context "when there is only ZipcodeRange zone" do
      let(:address) { FactoryGirl.create(:address, zipcode: "11111111") }
      
      it "should return the qualifying zone" do
        Spree::Zone.match(address).should == zipcode_range_zone
      end
    end

    context "when there are three qualified zones with different member types" do
      let(:state_zone) { create(:zone, name: 'StateZone') }
      let(:country_zone) { create(:zone, name: 'CountryZone') }
      let(:country) do
        country = FactoryGirl.create(:country)
        # Create at least one state for this country
        state = FactoryGirl.create(:state, country: country)
        country
      end
      let(:address) { create(:address, country: country, state: country.states.first, zipcode: "11111111") }

      before do
        state_zone.members.create(zoneable: country.states.first)
        country_zone.members.create(zoneable: country)
      end

      it "should return the zone with the more specific member type" do
        Spree::Zone.match(address).should == zipcode_range_zone
      end
    end
  end
end

