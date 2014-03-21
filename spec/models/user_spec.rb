require 'spec_helper'

describe User do
  before { @user = User.new(name: "hoang", email: "tienhoangna@gmail.com",
  							password: "foobar", password_confirmation: "foobar") }

  subject {@user}

  it {should respond_to(:name) }
  it {should respond_to(:email) }
  it {should respond_to(:password_digest) }
  it {should respond_to(:password) }
  it {should respond_to(:password_confirmation) }

  it {should be_valid }

  describe "when name is not present" do
  	before { @user.name= " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email= "    "}
  	it { should_not be_valid }
  end

  describe "when name is too long" do
  	before { @user.name = "a" * 51 }
  	it { should_not be_valid }
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com tienhoangna@gmail.@com kalel@abc.a@9]
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			expect(@user).not_to be_valid
  		end
  	end
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo.com tienhoangna@gmai.com kalel@abc.a]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			expect(@user).to be_valid
  		end
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.save
  	end

  	it { should_not be_valid}
  end

  describe "email andress with mixed case" do
  	let (:mixed_case_email) {"TienHoAngna@gmail.com"}
 
  	it "should be saved as all lower-case" do
  		@user.email = mixed_case_email
  		@user.save
  		expect(@user.reload.email).to eq mixed_case_email.downcase
  	end

  end

  describe "When password is not present" do
  	before do
  		@user = User.new(name: "hoang", email: "tienhoangna@gmail.com",
  						 password: " ", password_confirmation: " ")
  	end
  	it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }

  	it { should_not be_valid }
  end

  describe "return value of authentication method" do
    before do 
      @user = User.new(name: "hoang222", email: "tienhoangna2@gmail.com",
               password: "abcdef", password_confirmation: "abcdef")
      @user.save
    end
    let(:found_user) { User.find_by(email: @user.email) }

    describe "With correct password for user" do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "With incorrect password for user" do 
      let(:user_for_incorrect_password) {found_user.authenticate("wrongpass")}

      it {should_not eq user_for_incorrect_password}
      specify {expect(user_for_incorrect_password).to be_false}
    end

  end

end
