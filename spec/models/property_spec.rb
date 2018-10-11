require 'rails_helper'

RSpec.describe Property, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  subject { described_class.new }
  it "is valid with valid attributes" do
    subject.offer_type = "sell"
    subject.property_type = "apartment"
    subject.lat = 52.5342963
    subject.lng = 13.4236807
    expect(subject).to be_valid
  end

 it "is not valid without a offer_type" do
   subject.property_type = "apartment"
   subject.lat = 52.5342963
   subject.lng = 13.4236807
   expect(subject).to_not be_valid
 end

 it "is not valid without a property_type" do
   subject.offer_type = "sell"
   subject.lat = 52.5342963
   subject.lng = 13.4236807
   expect(subject).to_not be_valid
 end

 it "is not valid without a lat" do
   subject.offer_type = "sell" 
   subject.property_type = "apartment"
   subject.lng = 13.4236807
   expect(subject).to_not be_valid
 end

 it "is not valid without a lng" do
   subject.offer_type = "sell"
   subject.property_type = "apartment"
   subject.lat = 52.5342963  
   expect(subject).to_not be_valid
 end

end
