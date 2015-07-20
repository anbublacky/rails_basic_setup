class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :check_user

  respond_to :html

  def index
    @profiles = Profile.all
    respond_with(@profiles)
  end

  def show
    respond_with(@profile)
  end

  def new
    @profile = Profile.new
    respond_with(@profile)
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)
    @profile.save
    respond_with(@profile)
  end

  def update
    @profile.update(profile_params)
    respond_with(@profile)
  end

  def destroy
    @profile.destroy
    respond_with(@profile)
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def check_user
      unless current_user.profile.id == params[:id].to_i
        redirect_to root_path
      end
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :image, :location, :phone, :user_id)
    end
end
