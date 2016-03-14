require 'rails_helper'

describe RoomMemberStatusService do
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:options) { {user_id: user, room_id: room} }

  it 'marks user as online' do
    RoomMemberStatusService.new(options).mark_as_online

    expect(current_room_member_list).not_to be_empty
  end

  specify 'user goes offline' do
    RoomMemberStatusService.new(options).mark_as_online
    RoomMemberStatusService.new(options).go_offline

    expect(current_room_member_list).to be_empty
  end

  it 'activates user' do
    RoomMemberStatusService.new(options).activate_user

    expect(current_room_member_list).not_to be_empty
  end

  it 'gets members list' do
    RoomMemberStatusService.new(options).mark_as_online
    member_list = RoomMemberStatusService.new(options).member_list

    expect(current_room_member_list).to eq(member_list)
  end

  def current_room_member_list
    $redis_room_users.lrange("room:#{room}", 0, -1)
  end
end

