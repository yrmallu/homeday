require 'geocoder'
class PropertiesController < ApplicationController
  before_action :validate_params, only: [:get_properties]  
  RADIUS = 5000

  def get_properties
    properties = Property.where(property_type: params[:property_type], offer_type: params[:marketing_type]).within_radius(params[:lat], params[:lng], RADIUS)
    result = properties.map {|property| property_record(property)}
    if result.empty?
      render :json => { info: "No data for given location" }
    else
      render :json => result.to_json
    end
  end

 
  # Building property record
  def property_record(property)
   {
    house_number: property.house_number, 
    street:       property.street,
    city:         property.city,
    zip_code:     property.zip_code,
#    state:        state_name(property.lat, property.lng),
    lat:          property.lat,
    lng:          property.lng,
    price:        property.price
   }
  end
 
  #fetching state name from given lat, lng and currently commented due to over api query limit with geocoder gem
  def state_name(lat, lng)
    geo_localization = "#{lat},#{lng}"
    query = Geocoder.search(geo_localization).first
    state = query.nil? ?  "" : query.state
  end
  
  private

  def property_params
    params.permit(:lat, :lng, :property_type, :marketing_type)
  end

  #Validating params
  def validate_params
    property = Property.new(property_params)
    if !property.valid?
     render json: { error: property.errors } and return
    end
  end
end
