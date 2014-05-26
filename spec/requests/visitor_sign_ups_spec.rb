require 'spec_helper'

describe "VisitorSignUps" do
  it 'verifies sign up with valid data' do
    visit new_user_registration_path
    fill_in "Username", with: "FakeUser"
    fill_in "Email", with: "valid@example.com"
    find('#user_password').set("password")
    fill_in "Password confirmation", with: "password"
    
    click_button 'Sign up'  
    expect(current_path).to eq(root_path)
  end
end
