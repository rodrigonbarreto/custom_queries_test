require 'rails_helper'

RSpec.describe Role, type: :model do
   # pending "add some examples to (or delete) #{__FILE__}"

  it 'create a Customer' do
    role = create(:role)
    expect(role.name).to eq("Role_manager")
  end
end
