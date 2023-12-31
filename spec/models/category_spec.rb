require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    @user = User.create!(name: 'someone', email: 'usercategory@user.com', password: 'password', id: 10)
    @category = Category.create(name: 'stationary', icon: 'fa-utensils', user_id: @user.id)
  end

  before { subject.save }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid if any empty attribute' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without an icon' do
    subject.icon = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:icon]).to include('can\'t be blank')
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'stationary'
  end

  it 'name should not be empty' do
    subject.name = ' '
    expect(subject).to_not be_valid
  end

  it 'user should be present' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'user_id not be empty' do
    subject.user_id = ' '
    expect(subject).to_not be_valid
  end
end
