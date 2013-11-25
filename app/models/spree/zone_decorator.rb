module Spree
  Zone.class_eval do
    def include?(address)
      return false unless address
  
      members.any? do |zone_member|
        case zone_member.zoneable_type
        when 'Spree::Country'
          zone_member.zoneable_id == address.country_id
        when 'Spree::State'
          zone_member.zoneable_id == address.state_id
        when 'Spree::ZipcodeRange'
          address.zipcode and address.zipcode.between?(
            zone_member.zoneable.start_zip,
            zone_member.zoneable.end_zip)
        else
          false
        end
      end
    end
  
    def zipcode_range_ids
      if kind == 'zipcode_range'
        members.collect(&:zoneable_id)
      else
        []
      end
    end
  
    def zipcode_range_ids=(ids)
      zone_members.destroy_all
      ids.reject{ |id| id.blank? }.map do |id|
        member = ZoneMember.new
        member.zoneable_type = 'Spree::ZipcodeRange'
        member.zoneable_id = id
        members << member
      end
    end
  
    def self.match(address)
      return unless matches = self.includes(:zone_members).
        order('zone_members_count', 'created_at').
        select { |zone| zone.include? address }
  
      ['zipcode_range', 'state', 'country'].each do |zone_kind|
        if match = matches.detect { |zone| zone_kind == zone.kind }
          return match
        end
      end
      matches.first
    end

    def remove_defunct_members
      if zone_members.any?
        zone_members.where('zoneable_id IS NULL OR zoneable_type != ?', "Spree::#{kind.camelize}").destroy_all
      end
    end
  end
end
