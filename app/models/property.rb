class Property < ActiveRecord::Base

 PROPERTY_TYPES = %w( apartment single_family_house ).freeze
 MARKETING_TYPES = %w( rent sell ).freeze

 alias_attribute :marketing_type, :offer_type
 validates :property_type, :presence => true, :inclusion=> { :in => PROPERTY_TYPES }
 validates :marketing_type, :presence => true, :inclusion=> { :in => MARKETING_TYPES }
 validates :lat, numericality: { greater_than_or_equal_to: -90,  \
  less_than_or_equal_to: 90 }
 validates :lng, numericality: { greater_than_or_equal_to: -180,  \
  less_than_or_equal_to: 180 } 

 scope :within_radius, lambda {|lat, lng, metres| where("earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(lat, lng)", lat, lng, metres) }
end
