class Scraper
  attr_reader :page

  def initialize(url)
    @page = Nokogiri::HTML(open(url))
  end

  def get_addresses
    self.page.css("div.item div.details-title a").each_with_index do |details, index|
      if index.even?
        listing = Listing.find_or_create_by(listing_params(details))
        listing.price = Listing.parse_price(details.parent.parent.css("div.price-info span.price").text)
        listing.save
      end
    end
  end

  def listing_params(details)
    {url: Listing.parse_url(details["href"]),
    listing_class: details["data-gtm-listing-type"].capitalize,
    address: Listing.parse_address(details.children.text),
    unit: Listing.parse_unit(details.children.text)}
  end
end
