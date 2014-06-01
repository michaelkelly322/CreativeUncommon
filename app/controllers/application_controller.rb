require 'mailchimp'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :setup_mcapi

  def setup_mcapi
    @mc = Mailchimp::API.new('ef995113892a96240048070ed4e381e8-us8')
    @list_id = '2f2fbd64d6'
  end

  include SessionsHelper
end
