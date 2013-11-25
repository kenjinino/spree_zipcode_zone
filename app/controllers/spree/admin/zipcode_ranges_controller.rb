module Spree
  module Admin
    class ZipcodeRangesController < ResourceController

      def collection
        super.order(:name)
      end

    end
  end
end
