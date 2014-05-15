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
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
  end

  describe "index" do
    before do
      signin_path FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Huy", email: "huy@gmail.com")
      FactoryGirl.create(:user, name: "Anh", email: "anh@gmail.com")
      visit user_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do

      before(:all) { 10.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

end
