require 'rails_helper'

describe RoomMemberStatusService do
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:all_members) { "room:#{room.id}:members" }
  let(:online_members) { "room:#{room.id}:online" }
  let(:options) { {user_id: user.id, room_id: room.id} }
  let(:status_service) { RoomMemberStatusService.new(options) }

  it 'marks user as online' do
    10.times do
      member = create(:member, room: room)
      $redis.sadd(all_members, member.id)
    end

    status_service.mark_as_online

    expect($redis.smembers(online_members)).not_to be_empty
  end

  specify 'user goes offline' do
    status_service.mark_as_online
    status_service.go_offline

    expect($redis.smembers(online_members)).to be_empty
  end

  it 'returns collections of room users' do
    collection = status_service.user_collection(all_members)

    expect(collection.size).to eq(1)
  end

  it 'creates job' do
    expect(status_service.create_room_member_status_job.class).to eq(RoomMemberStatusJob)
  end
end
