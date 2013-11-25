class Spree::ZipcodeRange < ActiveRecord::Base
  validates :name, :start_zip, :end_zip, presence: true

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end
