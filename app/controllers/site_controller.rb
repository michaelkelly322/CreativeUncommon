class SiteController < ApplicationController
  def home
    @message_wel = "Welcome to the Tree-House."
    @message_sorry = "We're working very hard to get up and running."
  end
end
