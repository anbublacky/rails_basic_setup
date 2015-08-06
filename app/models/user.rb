class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_one :profile, inverse_of: :user
  has_many :identities, inverse_of: :user
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email = auth.info.email
      user = User.where(:email => email).first if email
      if user.nil?
        user = User.new(
          email: email ? email : "#{auth.uid}@#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        if auth.provider == "facebook"
          user.build_profile(first_name: auth.info.first_name, last_name: auth.info.last_name, image: auth.info.image + '?type=large')
        else
          user.build_profile(first_name: auth.info.name, image: auth.info.image, location: auth.info.location)
        end
        user.skip_confirmation!
        user.save!
      end
    end
    if identity.user == user
      identity.user = user
      identity.save!
    end
    user
  end

end
