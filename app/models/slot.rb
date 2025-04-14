class Slot < ApplicationRecord
  belongs_to :vinyl_box
  has_one :vinyl, dependent: :destroy
end
