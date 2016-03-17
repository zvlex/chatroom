class Room < ApplicationRecord
  after_create :join_room_as_admin

  belongs_to :user

  has_many :messages
  has_many :members

  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 1 }
  validates :description, length: { minimum: 5 }

  def name=(value)
    super value.downcase
  end


  private
    def join_room_as_admin
      member = self.members.build(user: self.user, role: 0)
      member.save!
    end
end
