module Spree
  module Admin
    ZonesController.class_eval do
      def load_data
        @countries = Country.order(:name)
        @states = State.order(:name)
        @zipcode_ranges = ZipcodeRange.order(:name)
        @zones = Zone.order(:name)
      end
    end
  end
end
