require 'rails_helper'

RSpec.describe Resource::V1::FriendRecordsApi, type: :request do

  describe 'Call get friends' do
    before do
      fake_dto = FriendInfoDto.new(3, "fake_name")
      allow(QueryService).to receive(:get_friends).and_return([fake_dto])
    end

    it 'check service execution & received params' do

      expect(QueryService).to receive(:get_friends).with(5).once

      call_get_friends

    end

    describe 'check response' do

      before { call_get_friends }

      it 'responds click-in histories' do
        body = JSON.parse(response.body)
        expect(body[0]["id"]).to eq(3)
        expect(body[0]["name"]).to eq("fake_name")
      end

      it_behaves_like 'return http_status_code', 200
    end

  end



  describe 'Call get friend_records' do

    before do
      fake_dto = SleepRecordDto.new(Date.parse("2022-12-03"), 30024)
      allow(QueryService).to receive(:get_friend_sleep_records).and_return([fake_dto])
    end

    it 'check service execution & received params' do

      expect(QueryService).to receive(:get_friend_sleep_records).with(3).once

      call_get_sleep_records

    end

    describe 'check response' do

      before { call_get_sleep_records }

      it 'responds click-in histories' do
        body = JSON.parse(response.body)
        expect(body[0]["record_date"]).to eq("2022-12-03")
        expect(body[0]["sleep_length"]).to eq("8:20:24")
      end

      it_behaves_like 'return http_status_code', 200
    end

  end

  def call_get_friends
    params = { user_id: 5 }
    get '/good_night/v1/click_in_user_friend/friends', :params => params
  end

  def call_get_sleep_records
    params = { friend_user_id: 3 }
    get '/good_night/v1/click_in_user_friend/records', :params => params
  end

end
