class Budget < ActiveRecord::Base
  belongs_to :trip

  validates :total, :trip_id, presence: true

  scope :sort_by_day, -> { order('date') }
end
