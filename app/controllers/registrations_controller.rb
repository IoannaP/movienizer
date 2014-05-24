class RegistrationsController < Devise::RegistrationsController
  def edit
  render :edit
   if current_user.provider =='facebook' and !current_user.reset_password_token 
      current_user.send_reset_password_instructions
    end
  end
end