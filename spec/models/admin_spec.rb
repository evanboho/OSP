require 'rails_helper'

describe Admin, type: :model do

  it "validates uniqueness of email" do
    admin = Fabricate(:admin)
    expect {
      admin2 = Fabricate(:admin, email: admin.email)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

end
