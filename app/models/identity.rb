class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
  	Rails.logger.info auth
    find_or_create_by(uid: auth.uid, provider: auth.provider, token: auth.credentials.token, secret: auth.credentials.secret)
  end
end
