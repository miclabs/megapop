class PaymentRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment_request, only: [:update]


  def create
    @payment_request = PaymentRequest.new payment_request_params

    respond_to do |format|
      format.html { }
      format.js {
        @payment_request.save
      }
    end
  end

  def update
    @result = @payment_request.update payment_request_params

    if @payment_request.megapop_offer.present?
      @payment_request.update(status: :submitted)
    end

    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  def new
    @payment_request = PaymentRequest.new
  end

  private ##

  def payment_request_params
    params
    params.require(:payment_request).permit(
      :sponsor_name, :social_platform, :project_amount, :debt_amount,
      :expected_payment_date, :job_complete, :sponsorship_type,
      :status, :default, :project_documents, :megapop_offer
      # created_by_attributes: [
      #   :id, :zip_code, :phone_number, :first_name, :dob,
      #   :last_name, :street_address_1, :street_address_2, :postcode,
      #   :city, :state, :email, :country
      # ]
    )
  end

  def set_payment_request
    @payment_request = PaymentRequest.find(params[:id])
  end
end