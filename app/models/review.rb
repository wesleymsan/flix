class Review < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true

  validates :comment, length: { minimum: 5 }

  STARS = %w[1 2 3 4 5].freeze
  validates :stars, inclusion: {
    in: STARS, message: 'must be between 1 and 5'
  }
end
