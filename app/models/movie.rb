# frozen_string_literal: true

# Movie
class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :critics, through: :reviews, source: :user

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image
  validate :acceptable_image

  validates :title, presence: true, uniqueness: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  RATINGS = %w[G PG PG-13 R NC-17].freeze
  validates :rating, inclusion: { in: RATINGS }

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end

  scope :released, -> { where('released_on < ?', Time.now).order('released_on desc') }
  scope :upcoming, -> { where('released_on > ?', Time.now).order('released_on asc') }
  scope :recent,   ->(max = 5) { released.limit(max) }

  def flop?
    total_gross.blank? || total_gross < 250_000_000
  end

  def to_param
    slug
  end

  private

  def acceptable_image
    return unless main_image.attached?

    errors.add(:main_image, 'is too big') unless main_image.blob.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    errors.add(:main_image, 'must be a JPEG or PNG') unless acceptable_types.include?(main_image.content_type)
  end

  def set_slug
    self.slug = title.parameterize
  end
end
