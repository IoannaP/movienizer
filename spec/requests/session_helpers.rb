 module SessionHelpers
    def sign_up_with(username, email, password, password_confirmation)
      visit new_user_registration_path
      fill_in "Username", with: username
      fill_in "Email", with: email
      find('#user_password').set(password)
      fill_in "Password confirmation", with: password_confirmation
    
      click_button 'Sign up'  
    end
  end
