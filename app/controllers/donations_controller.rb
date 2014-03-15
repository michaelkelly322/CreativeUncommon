class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  # GET /donations
  # GET /donations.json
  #def index
  #  @donations = Donation.all
  #end

  # GET /donations/1
  # GET /donations/1.json
  def show
  end

  # GET /donations/new
  def new
    @donation = Donation.new
    
    @donation.approved = false
    @donation.site_donation = false
    
    unless params[:type].nil?
      if params[:type].to_i == 0
        @donation.site_donation = true
      else
        @work = Work.find(params[:type])
        @donation.work_id = @work.id
        @donation.user_id = @work.user.id
      end
    end
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(donation_params)
    logger.debug 'donation_params' + donation_params.inspect
    logger.debug 'params' + params.inspect

    respond_to do |format|
      if @donation.save
        # TODO: Craft redirect-to-paypal url here
        PayPal::SDK.configure(
          :mode      => "sandbox",  # Set "live" for production
          :app_id    => "APP-80W284485P519543T",
          :username  => "michaelkelly322-facilitator_api1.gmail.com",
          :password  => "1394740509",
          :signature => "AJcd4zryQhQ2ZgcZLiVoqM93-q0wA2dcbJdAmqurm0ecK0o7QXYV-dxB" )
        
        @api = PayPal::SDK::AdaptivePayments.new
        
        # Build request object
        @pay = @api.build_pay({
          :actionType => "PAY",
          :cancelUrl => "http://localhost:3000/donations/cancel/#{@donation.id}",
          :currencyCode => "USD",
          :feesPayer => "SENDER",
          #:ipnNotificationUrl => "http://localhost:3000/samples/adaptive_payments/ipn_notify",
          :receiverList => {
            :receiver => [{
              :amount => @donation.amount,
              :email => "test-author@gmail.com" }] },
          :returnUrl => "http://localhost:3000/donations/approve/#{@donation.id}" })
        
        # Make API call & get response
        @response = @api.pay(@pay)
        if @response.success?
          format.html { redirect_to @api.payment_url(@response)}
        else
          format.html { render action: 'new', notice: 'Error communicating with Paypal' }
        end
        
        format.html { redirect_to @donation, notice: 'Donation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @donation }
      else
        format.html { render action: 'new' }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  def cancel
    unless params[:id].nil?
      don = Donation.find(params[:id])
      
      unless don.nil?
        don.delete
      end
    end
    
    redirect_to root_path
  end

  def approve
    unless params[:id].nil?
      don = Donation.find(params[:id])
      
      don.approved = true
      if don.save
        if signed_in?
          current_user.update_attribute(:donated, current_user.donated + don.amount)
        end
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:amount, :site_donation, :approved, :user_id, :work_id)
    end
end
