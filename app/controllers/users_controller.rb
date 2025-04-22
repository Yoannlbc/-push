class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès."
    else
      render :edit
    end
  end

  def update_photo
    @user = current_user
    if params[:photo].present?
      @user.photo.attach(params[:photo])
      redirect_to profile_path, notice: "Photo de profil mise à jour avec succès."
    else
      redirect_to profile_path, alert: "Aucune photo sélectionnée."
    end
  end

  def remove_photo
    @user = current_user
    if @user.photo.attached?
      @user.photo.purge
      redirect_to profile_path, notice: "Photo de profil supprimée avec succès."
    else
      redirect_to profile_path, alert: "Aucune photo à supprimer."
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :photo)
  end
end
