FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_zipcode_zone/factories'

  factory :zipcode_range, :class => 'Spree::ZipcodeRange' do
    name "zipcode range test"
    start_zip "00000000"
    end_zip "22222222"
  end
end
