class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :vinyl_box, dependent: :destroy
  has_many :slots, through: :vinyl_box
  has_many :vinyls, through: :slots
  has_one_attached :photo

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_vinyl_box

  private

  def create_vinyl_box
    VinylBox.create!(user: self)
  end
end
