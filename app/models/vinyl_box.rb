class VinylBox < ApplicationRecord
  belongs_to :user
  has_many :slots, dependent: :destroy
  has_many :vinyls, through: :slots

  def slots_in_rows
    slots.includes(:vinyl).order(:id).each_slice(10).to_a
  end
end
