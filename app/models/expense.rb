class Expense < ApplicationRecord
  belongs_to :user, class_name: 'User'
  # has_many :joins, dependent: :destroy, foreign_key: 'expense_id'
  # has_many :categories, through: :joins
  has_and_belongs_to_many :categories, join_table: 'joins', foreign_key: 'expense_id'

  # validates :name, :amount, presence: true, length: { maximum: 50 }
  # validates :amount, numericality: { greater_than: 0 }
end
