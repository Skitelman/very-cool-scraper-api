class WelcomeController < ApplicationController
  def index
    render file: "app/views/welcome/index"
  end
end
