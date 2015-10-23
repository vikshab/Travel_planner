class Task < ActiveRecord::Base
  belongs_to :trip

  validates :title, :date, presence: true

  scope :lattest, -> { order('date DESC') }

end
