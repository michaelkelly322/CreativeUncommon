require 'mailchimp'
class EmailProvider
  def initialize
    setup_mcapi
  end

  def subscribe_user(email)
    unless email.blank?
      Rails.logger.info "subscribing #{email}..."
      begin
        @mc.lists.subscribe(@list_id, {'email' => email})
        return {result: true, message: "A confirmation email has been sent to #{email}!"}
      rescue Mailchimp::Error => error
        handle_error(error)
      end
    end
  end

  def unsubscribe_user(email)
    Rails.logger.info "unsubscribing #{email}..."
    unless email.blank?
      begin
        @mc.lists.unsubscribe(@list_id, {'email' => email})
        return {result: true, message: "#{email} unsubscribed successfully!"}
      rescue Mailchimp::Error => error
        handle_error(error)
      end
    end
  end

  protected
    def setup_mcapi
      @mc = Mailchimp::API.new('ef995113892a96240048070ed4e381e8-us8')
      @list_id = '2f2fbd64d6'
      Rails.logger.info "Mailchimp provider established for list #{@list_id}"
    end

    def handle_error(error)
      Rails.logger.error "Error with email provider service: #{error}"
      res = {result: false}
      res[:message] = case error.class.to_s
                      when "Mailchimp::ListAlreadySubscribedError"
                        "That email address is already subscribed to the list."
                      when "Mailchimp::ListDoesNotExistError"
                        "The list could not be found."
                      when "Mailchimp::Error"
                        "An unknown error ocurred."
                      end
      binding.pry
      return res
    end

end
