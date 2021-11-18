class PaymentRequest < ApplicationRecord
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id, required: false
  accepts_nested_attributes_for :created_by

  has_many_attached :project_documents

  # validate unless: :draft?

  enum social_platform: ['Instagram', 'YouTube', 'TikTok', 'Twitter', 'Facebook']
  enum sponsorship_type: [:brand, :agency, :influencer_platform]
  enum status: [:draft, :submitted]
end
