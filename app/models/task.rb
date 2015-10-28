class Task < ActiveRecord::Base
  belongs_to :trip

  validates :title, :date, presence: true
  # validates :due_date_cannot_be_less_than_current_date

  scope :lattest, -> { order('date') }

  def due_date_cannot_be_less_than_current_date
    if date <  Date.today.to_s
      errors.add(:date, "due date cannot be less than current date")
    end
  end

end
