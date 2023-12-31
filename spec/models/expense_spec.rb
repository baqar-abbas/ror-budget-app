require 'rails_helper'

RSpec.describe Expense, type: :model do
  subject do
    @user = User.create!(name: 'someone', email: 'userexpense@user.com', password: 'password', id: 100)
    @expense = Expense.create(name: 'stationary', amount: 10.1, user: @user, user_id: 100, id: 100)
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid if any empty attribute' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should not be empty' do
    subject.name = ' '
    expect(subject).to_not be_valid
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'amount should be present' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'amount should not be less than 0' do
    subject.amount = -1.1
    expect(subject).to_not be_valid
  end

  it 'amount should be a decimal' do
    expect(subject.amount).to be_within(0.0001).of(10.1)
  end

  it 'amount should have a decimal point' do
    expect(subject.amount.to_s).to include('.')
  end

  it 'user should be present' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'user_id should be present' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end
end
