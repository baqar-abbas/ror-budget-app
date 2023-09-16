class Category < ApplicationRecord
  belongs_to :user
  # has_many :joins, dependent: :destroy
  # has_many :expenses, through: :joins
  has_and_belongs_to_many :expenses, join_table: 'joins', foreign_key: 'category_id'

  validates :name, :icon, presence: true, length: { maximum: 100 }

  def total_expenses(user)
    expenses.where(user_id: user.id).sum(:amount)
  end
end
