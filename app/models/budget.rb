class Budget < ActiveRecord::Base
  belongs_to :trip

  validates :total, :trip_id, presence: true

end
