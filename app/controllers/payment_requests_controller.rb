class PaymentRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment_request, only: [:update]
  skip_before_action :verify_authenticity_token, only: [:upload]

  def create
    @payment_request = PaymentRequest.new payment_request_params.merge(created_by_id: current_user.id)
   
    respond_to do |format|
      format.html { }
      format.js {
        @payment_request.save
      }
    end
  end

  def update
    @result = @payment_request.update payment_request_params

    if @payment_request.submitted?
      @payment_request.payment_debits.where(active: false).destroy_all
    else
      @payment_request.payment_debits.destroy_all 
    end

    respond_to do |format|
      format.html { }
      format.js { }
    end
  end

  def new
    @payment_request = PaymentRequest.new created_by_id: current_user.id
    @payment_request.init_payment_debits
  end

  def upload
    file = params[:files].first
    blob = ActiveStorage::Blob.create_after_upload!(
      io: file,
      filename: file.original_filename,
      content_type: file.content_type
    )
    render json: { uploadURL: url_for(blob), signedId: blob.signed_id }
  end

  private ##

  def payment_request_params
    params
    params.require(:payment_request).permit(
      :sponsor_name, :social_platform, :project_amount, :debt_amount,
      :expected_payment_date, :job_complete, :sponsorship_type, :status,
      :status, :default, :project_documents, :megapop_offer, project_documents: [],
      payment_debits_attributes: [
        :id, :active, :rate_id, :rate_risk_adjustment_id, :collection_amount, :collection_date, :credit_score
      ]
    )
  end

  def set_payment_request
    @payment_request = PaymentRequest.find(params[:id])
  end
end