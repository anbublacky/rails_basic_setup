class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  has_one :profile, inverse_of: :user

	def self.from_omniauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
       return user
    else
      registered_user = User.where(:email => auth.info.email.present? ? auth.info.email : auth.uid + "@twitter.com").first
      if registered_user
              return registered_user
      else
	    	auth.provider == "facebook" ? build_facebook_user(auth) : (auth.provider == "twitter" ? build_twitter_user(auth) : build_google_user(auth))
		    user.skip_confirmation!
		    user.save
		    return user
		  end
		end
	end

	def self.build_facebook_user(auth)
    user = User.new(provider:auth.provider,
                      uid:auth.uid,
                    email:auth.info.email,
                    password:Devise.friendly_token[0,20])
    user.build_profile(first_name: auth.info.first_name, last_name: auth.info.last_name, image: auth.info.image + '?type=large')
	end

	def self.build_twitter_user(auth)
    user = User.new(provider:auth.provider,
                      uid:auth.uid,
                    email:auth.uid + "@twitter.com",
                    password:Devise.friendly_token[0,20])
    user.build_profile(first_name: auth.info.name, image: auth.info.image, location: auth.info.location)
	end

  def self.build_google_user(auth)
    user = User.new(provider:auth.provider,
                      uid:auth.uid,
                    email:auth.info.email,
                    password:Devise.friendly_token[0,20])
    user.build_profile(first_name: auth.info.name, image: auth.info.image, location: auth.info.location)
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
