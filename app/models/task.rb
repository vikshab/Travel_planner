class Task < ActiveRecord::Base
  belongs_to :trip

  validates :title, presence: true
end
