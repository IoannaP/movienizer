require 'spec_helper'


describe "UserSignIns" do
  before do
    visit new_user_registration_path
    fill_in "Username", with: "FakeUser"
    fill_in "Email", with: "valid@example.com"
    find('#user_password').set("password")
    fill_in "Password confirmation", with: "password"
    
    click_button 'Sign up'  
    expect(current_path).to eq(root_path)
  end

  it 'verifies sign in with unconfirmed account' do
    visit new_user_session_path
    fill_in 'Username', :with => 'FakeUser'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    
    expect(current_path).to eq(new_user_session_path)
    expect(page.find('div.alert').text).to end_with('You have to confirm your account before continuing.')
  end

  it 'should not sign in if password does not match' do
    visit new_user_session_path
    fill_in 'Username', :with => 'FakeUser'
    fill_in 'Password', :with => 'wrongpassword'
    click_button 'Sign in'
    
    expect(current_path).to eq(new_user_session_path)
    expect(page.find('div.alert').text).to end_with('Invalid login or password.')
  end

  it 'should not sign in if username does not match' do
    visit new_user_session_path
    fill_in 'Username', :with => 'FakeUserWrong'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    
    expect(current_path).to eq(new_user_session_path)
    expect(page.find('div.alert').text).to end_with('Invalid login or password.')
  end

  it 'should not sign in if email does not match' do
    visit new_user_session_path
    fill_in 'Email', :with => 'validwrong@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    
    expect(current_path).to eq(new_user_session_path)
    expect(page.find('div.alert').text).to end_with('Invalid login or password.')
  end

end