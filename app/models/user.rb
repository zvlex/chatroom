class User < ApplicationRecord
  has_many :messages
  has_many :rooms
  has_many :members

  authenticates_with_sorcery!

  validates :username, :email, :password, :password_confirmation, presence: true, if: :new_record
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :new_record
  validates :password, length: { minimum: 6 }, if: :new_record
  validates :password, confirmation: true, if: :new_record

  def room_member?(room)
    self.members.where(room_id: room.id).any?
  end

  private

    def new_record
      new_record?
    end
end
