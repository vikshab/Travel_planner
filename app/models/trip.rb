require 'date'

class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates :destination, :start_date, :end_date, presence: true
  validate :start_date_cannot_be_greater_than_end_date, :start_date_cannot_be_in_the_past


  scope :lattest, -> { order('end_date DESC') }


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

  def unassociate_user
    self.user_id = nil
    self.save
  end
end
