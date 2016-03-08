class ListingSerializer < ActiveModel::Serializer
  attributes :listing_class, :address, :unit, :url, :price
end
