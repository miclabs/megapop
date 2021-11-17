module PaymentRequestsHelper
  def sponsorship_types_collection
    {
      brand: 'I worked direct with a Brand',
      agency: 'I worked with an Agency',
      influencer_platform: 'I worked with an Influencer Platform'
    }
  end

  def social_platforms_collection
    PaymentRequest.social_platforms.invert.values.map { |social_platform| [social_platform, social_platform]}
  end
end