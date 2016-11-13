require 'rails_helper'

feature 'Manage Users' do
  background(:all) do
    admin = create(:admin)
    sign_in(admin)
  end

  scenario 'add a new user' do
    visit root_path
    click_link 'Users'
    click_link 'New User'

    expect{
      fill_in 'Email', with: 'foo@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Create User'
    }.to change(User, :count).by(1)

    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'

    within 'h1' do
      expect(page).to have_content 'Users'
    end

    expect(page).to have_content 'foo@gmail.com'
  end
end