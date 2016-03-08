class Api::V1::SalesController < ApplicationController
  def index
    page1_sales_scraper = Scraper.new("http://streeteasy.com/for-sale/soho?page=1&sort_by=price_desc")
    page1_sales_scraper.get_addresses
    page2_sales_scraper = Scraper.new("http://streeteasy.com/for-sale/soho?page=2&sort_by=price_desc")
    page2_sales_scraper.get_addresses
    render json: Listing.most_expensive_sales
  end
end
