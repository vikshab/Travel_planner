class Wardrobe < ActiveRecord::Base

  validates :name, presence: true
  has_and_belongs_to_many :trips

  def unassociate_trip
    self.trip_id = nil
    self.save
  end
end
