require 'spec_helper'

feature %q{
  As a user
  I want to be able to change my email
  So I can set a new address if I lose my old one
} do

  background do
    @user = FactoryGirl.create(:user, :name => "Stewie", :email => "bogus@example.com")
    venue = FactoryGirl.create(:venue)
    sign_in_manually(@user)
  end

  scenario "Edit my profile", :js => true do
    click_link "Stewie"
    click_link "Edit"
    within ".center-column" do
      fill_in "user[email]", :with => "stewie@example.com"
      fill_in "user[homepage]", :with => "example.com"
      uncheck "user[subscribe]"
      click_button "Save"
    end
    page.should have_content "User was successfully updated."
    @user.reload.email.should == "stewie@example.com"
    @user.homepage.should == "http://example.com"
    @user.subscribe.should == false
  end
end
