class Listing < ActiveRecord::Base

  def self.parse_address(raw_address)
    address_words = raw_address.split(" ")
    if address_words.last.include?("#") || address_words.last.downcase.include?("floor")
      address_words[0...-1].join(" ")
    else
      raw_address.strip
    end
  end


  def self.parse_unit(raw_address)
    address_words = raw_address.split(" ")
    if address_words.last.include?("#") || address_words.last.downcase.include?("floor")
      address_words[-1].gsub("#","")
    else
      nil
    end
  end

  def self.parse_url(raw_url)
    base_url = raw_url.split("?").first
    "https://www.streeteasy.com#{base_url}"
  end

  def self.parse_price(raw_price)
    raw_price.gsub("$", "").gsub(",","").to_i
  end

  def self.clear_old
    Listing.all.each do |listing|
      if listing.created_at < (DateTime.now - 1)
        listing.destroy
      end
    end
  end

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
end
