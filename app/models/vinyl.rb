class Vinyl < ApplicationRecord
  belongs_to :user
  belongs_to :slot
  has_one_attached :photo

  validates :title, presence: true
  validates :artist, presence: true
  validates :genre, presence: true
  validates :release_year, presence: true
  validates :slot, presence: true
  validates :slot_id, uniqueness: true

  before_validation :assign_slot, on: :create

private

def assign_slot
  return if self.slot.present?

  box = user.vinyl_box
  # Trouver les slots vides
  empty_slot = box.slots.left_joins(:vinyl).where(vinyls: { id: nil }).first

  # Si aucun slot vide, on en crée un nouveau
  self.slot = empty_slot || box.slots.create!
end
end
