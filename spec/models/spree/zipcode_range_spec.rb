require 'spec_helper'

describe Spree::ZipcodeRange do

  let(:zipcode_range) { FactoryGirl.create(:zipcode_range) }

  describe "#to_s" do
    it { zipcode_range.to_s.should eql(zipcode_range.name) } 
  end

  describe "validation" do
    it "should have name" do
      zipcode_range.name = ""
      zipcode_range.should_not be_valid
    end

    it "should have start_zip" do
      zipcode_range.start_zip = ""
      zipcode_range.should_not be_valid
    end

    it "should have end_zip" do
      zipcode_range.end_zip = ""
      zipcode_range.should_not be_valid
    end
  end
end
