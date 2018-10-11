require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
 
  it "renders the #get_properties" do
    get :get_properties, property_type: "apartment", marketing_type: "sell", lat: 52.5342963, lng: 13.4236807
    expect(response).to be_success
  end

  it "renders no data if locaton doesnt have properties" do
    get :get_properties, property_type: "apartment", marketing_type: "sell", lat: 82.5342963, lng: 13.4236807
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["info"]).to eq("No data for given location")
  end

  it "renders error if params doesnt have marketing_type" do
    get :get_properties, property_type: "apartment", lat: 82.5342963, lng: 13.4236807
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["marketing_type"]).to eq(["can't be blank","is not included in the list"])
  end

   it "renders error if marketing_type not included in the marketing_type list" do
    get :get_properties, property_type: "apartment", lat: 82.5342963, lng: 13.4236807, marketing_type: "buy"
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["marketing_type"]).to eq(["is not included in the list"])
  end

  it "renders error if params doesnt have property_type" do
    get :get_properties, marketing_type: "sell", lat: 82.5342963, lng: 13.4236807
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["property_type"]).to eq(["can't be blank","is not included in the list"])
  end

   it "renders error if marketing_type not included in the property_type list" do
    get :get_properties, property_type: "single_for_bachelor", lat: 82.5342963, lng: 13.4236807, marketing_type: "sell"
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["property_type"]).to eq(["is not included in the list"])
  end

  it "renders error if params doesnt have lat" do
    get :get_properties, property_type: "apartment", marketing_type: "sell", lng: 13.4236807
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["lat"]).to eq(["is not a number"])
  end

   it "renders error if lat greater than the range" do
    get :get_properties, property_type: "apartment", lat: 182.5342963, lng: 13.4236807, marketing_type: "sell"
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["lat"]).to eq(["must be less than or equal to 90"])
  end

  it "renders error if params doesnt have lng" do
    get :get_properties, property_type: "apartment", marketing_type: "sell", lat: 53.4236807
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["lng"]).to eq(["is not a number"])
  end

   it "renders error if lng greater than the range" do
    get :get_properties, property_type: "apartment", lat: 52.5342963, lng: 213.4236807, marketing_type: "sell"
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]["lng"]).to eq(["must be less than or equal to 180"])
  end

end
