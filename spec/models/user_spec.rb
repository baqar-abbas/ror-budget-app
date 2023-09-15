require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be valid with valid attributes' do
    user = User.new(name: 'John Doe', email: 'johndoe@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'name should have a correct value' do
    user = User.new(name: 'John Doe', email: 'johndoe@example.com', password: 'password')
    expect(user.name).to eql 'John Doe'
  end

  it 'should not be valid without a name' do
    user = User.new(email: 'johndoe@example.com', password: 'password')
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include('can\'t be blank')
  end

  it 'should not be valid without an email' do
    user = User.new(name: 'John Doe', password: 'password')
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include('can\'t be blank')
  end

  it 'should not be valid with a duplicate email' do
    User.create(name: 'John Doe', email: 'johndoe@example.com', password: 'password')
    user2 = User.new(name: 'Jane Doe', email: 'johndoe@example.com', password: 'password')
    expect(user2).not_to be_valid
    expect(user2.errors[:email]).to include('has already been taken')
  end

  it 'should not be valid with a password less than 6 characters' do
    user = User.new(name: 'John Doe', email: 'johndoe@example.com', password: 'pass')
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  end
end
