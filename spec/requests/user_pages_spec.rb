require 'spec_helper'

describe "UserPages" do
  subject {page}

  describe "signup page" do
    before {visit signup_path}

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    describe "with invalid information" do
      it "should not create new user" do 
        expect{ click_button "Create my account" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      it "should create a new user" do
        fill_in "Name",     with: "Nguyen Tien Hoang"
        fill_in "Email",    with: "tienhoangna@gmail.com"
        fill_in "Password", with: "abcdef"
        fill_in "Confirmation", with: "abcdef"

        expect do 
          click_button "Create my account"
        end.to change(User, :count).by(1)

      end
    end

  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
    
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'https://www.facebook.com/') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end
end