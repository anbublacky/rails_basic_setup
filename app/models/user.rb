class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

	def self.from_omniauth(auth)
		Rails.logger.info auth.provider  
		Rails.logger.info auth.uid 
		Rails.logger.info auth.info.email
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
       return user
    else
      user = User.new(provider:auth.provider,
                      uid:auth.uid,
                      email:auth.info.email,
                      password:Devise.friendly_token[0,20])
      user.skip_confirmation!
      user.save
      return user
		end
	end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
