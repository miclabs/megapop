class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  enum role: { creator: 0, admin: 1, credit_manager: 2}

  has_many :rate_cards

  validates_presence_of :ssn, :zip_code,
  	:phone_number, :first_name, :last_name,
  	:street_address_1, :street_address_2, :postcode, :city, :state, on: :create

  has_one_attached :avatar  do |attachable|
    attachable.variant :thumb, resize: "120x120"
  end

  def full_name
    first_name.to_s + " " + last_name.to_s
  end

  def update_without_password(params, *options)
    result = update(params, *options)
    clean_up_passwords
    result
  end
end
