class Listing < ActiveRecord::Base

  def self.parse_address(raw_address)
    raw_address.split("#").first.strip
  end

  def self.parse_unit(raw_address)
    raw_address.split("#").last unless raw_address.split("#").size < 2
  end

  def self.parse_url(raw_url)
    base_url = raw_url.split("?").first
    "https://www.streeteasy.com#{base_url}"
  end

  def self.parse_price(raw_price)
    raw_price.gsub("$", "").gsub(",","").to_i
  end

  # def attributes
  #   {
  #     'listing_class': self.listing_class,
  #     'address': self.address,
  #     'unit': self.unit,
  #     'url': self.url,
  #     'price': self.price
  #   }
  # end

  def safe_save
    unless Listing.find_by(address: self.address, unit: self.unit, listing_class: self.listing_class)
      self.save
    end
  end

  # def self.all
  #   @@all
  # end

  def self.sales
    self.all.select{|listing| listing.listing_class == "Sale"}
  end

  def self.rentals
    self.all.select{|listing| listing.listing_class == "Rental"}
  end

  def self.most_expensive_sales
    self.sales.sort_by{|listing|
      listing.price
    }.reverse[0...20]
  end

  def self.most_expensive_rentals
    self.rentals.sort_by{|listing|
      listing.price
    }.reverse[0...20]
  end

  def self.most_expensive_sales_attributes
    self.most_expensive_sales.map{|listing|
      listing.attributes
    }
  end

  def self.most_expensive_rentals_attributes
    self.most_expensive_rentals.map{|listing|
      listing.attributes
    }
  end
end
