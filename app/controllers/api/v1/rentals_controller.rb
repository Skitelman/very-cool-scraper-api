class Api::V1::RentalsController < ApplicationController
  def index
    page1_rental_scraper = Scraper.new("http://streeteasy.com/for-rent/soho?page=1&sort_by=price_desc")
    page1_rental_scraper.get_addresses
    page2_rental_scraper = Scraper.new("http://streeteasy.com/for-rent/soho?page=2&sort_by=price_desc")
    page2_rental_scraper.get_addresses
    render json: Listing.most_expensive_rentals
  end
end
