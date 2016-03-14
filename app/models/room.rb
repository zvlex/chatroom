class Room < ApplicationRecord
  has_many :messages

  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 1 }
  validates :description, length: { minimum: 5 }

  def name=(value)
    super value.downcase
  end
end
