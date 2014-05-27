class InvitationsController < Devise::InvitationsController
  def index
     @invitees = current_user.invitees.page(params[:page]).per(5).order('created_at DESC')
  end 


  def after_invite_path_for(resource)
    user_invitations_path(resource)
  end

  def update_resource_params
    params.require(:user).permit(:password, :password_confirmation, :user, :email, :invitation_token, :username)
  end
end
