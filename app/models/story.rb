class Story < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :lower_limit, numericality: { only_integer: true, less_than_or_equal_to: :upper_limit}, allow_nil: true
  validates :upper_limit, numericality: { only_integer: true }, allow_nil: true
end
