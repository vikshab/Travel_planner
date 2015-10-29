require 'date'

class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_and_belongs_to_many :wardrobes
  has_many :budgets

  validates :destination, :start_date, :end_date, presence: true
  # validate :start_date_cannot_be_greater_than_end_date, :start_date_cannot_be_in_the_past

  scope :lattest, -> { order('created_at DESC') }

  def start_date_cannot_be_greater_than_end_date
    if start_date > end_date
      errors.add(:start_date, "can't be greater than returning date")
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date < Date.today.to_s
      errors.add(:star_date, "can't be in the past")
    end
  end
end
