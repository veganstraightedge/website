require 'spec_helper'

describe YourLabel do
  require 'spec_helper'

  before do
    DatabaseCleaner.clean

    @user = User.create!(
      :name     => "Shane Becker",
      :username => "veganstraightedge",
      :email    => "veganstraightedge@gmail.com"
    )

    provider = Provider.create!(:name => "twitter", :uid => "641013", :user_id => @user.id)

    @label = Label.create!(:name => "straightedge")
  end

  it "should belong to a user and a label" do
    your_label = YourLabel.new
    your_label.user_id  = @user.id
    your_label.label_id = @label.id

    your_label.should be_valid
  end

  it "should be invalid without a user id" do
    your_label = YourLabel.new
    your_label.label_id = @label.id

    your_label.should be_invalid
  end

  it "should be invalid without a label id" do
    your_label = YourLabel.new
    your_label.user_id  = @user.id

    your_label.should be_invalid
  end

  it "should not allow duplicate labels for a user"
end
