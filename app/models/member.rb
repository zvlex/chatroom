class Member < ApplicationRecord
  enum role: [:admin, :member]

  attr_accessor :from_ui

  after_commit :update_member_list, on: :create, if: :from_ui

  belongs_to :room
  belongs_to :user

  validates :user, :room, presence: true

  private
    def update_member_list
      options = { room_id: self.room_id }
      RoomMemberStatusService.new(options).create_room_member_status_job
    end
end
