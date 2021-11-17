class PaymentRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @payment_request = PaymentRequest.new payment_request_params

    if @payment_request.save
      redirect_to payment_requests_path, notice: 'Created successfully'
    else
      flash[:error] = @payment_request.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
    @payment_request = PaymentRequest.new
  end

  private ##

  def payment_request_params
    params.require(:payment_request).permit(
      :sponsor_name, :social_platform, :project_amount, :debt_amount,
      :expected_payment_date, :job_complete, :sponsorship_type,
      :status, :default, :project_documents,
      created_by_attributes: [
        :id, :zip_code, :phone_number, :first_name, :dob,
        :last_name, :street_address_1, :street_address_2, :postcode,
        :city, :state, :email, :country
      ]
    )
  end
end