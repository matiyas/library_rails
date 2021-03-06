class Post < ApplicationRecord
  belongs_to :user
  # default_scope -> { order(created_at: :desc) }
  validates :title, presence: true, length: { minimum: 3, maximum: 140 }
  validates :content, presence: true, length: { minimum: 1, maximum: 10_000 }
end
