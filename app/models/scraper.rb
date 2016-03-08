class Scraper
  attr_reader :page

  def initialize(url)
    @page = Nokogiri::HTML(open(url))
  end

  def get_addresses
    self.page.css("div.item div.details-title a").each_with_index do |details, index|
      if index.even?
        listing = Listing.new
        listing.parse_url(details["href"])
        listing.listing_class = details["data-gtm-listing-type"].capitalize
        listing.parse_address(details.children.text)
        listing.parse_price(details.parent.parent.css("div.price-info span.price").text)
        listing.save
      end
    end
  end
end
