require 'rails_helper'

RSpec.describe Resource::V1::ClickInOperationApi, type: :request do

  # todo: write the expectation for invalid request (4XX, 5XX)
  describe 'click_in API' do
    before do
      allow(CommandService).to receive(:save_click_time).and_return(true)
      allow(Time).to receive(:now).and_return(Time.zone.parse('2022-12-01 14:00:00'))
    end

    context 'no history data' do

      before do
        allow(QueryService).to receive(:get_user_click_histories).and_return([])
      end

      it 'check service execution & received params' do

        expect(QueryService).to receive(:get_user_click_histories).with(1).once

        expect(CommandService).to receive(:save_click_time).with(1,
                                                                 "wake_up",
                                                                 Time.zone.parse('2022-12-01 14:00:00'),
                                                                 [{ click_type: "wake_up", recorded_time: Time.zone.parse('2022-12-01 14:00:00') }])

        call_api

      end

      it 'responds click-in histories' do
        call_api
        body = JSON.parse(response.body)
        expect(body[0]["click_type"]).to eq("wake_up")
        expect(body[0]["recorded_time"].to_time.strftime("%Y-%m-%d %H:%M:%S")).to eq("2022-12-01 14:00:00")
        expect(body[1]).to eq(nil)
      end

      it 'respond 201' do
        call_api
        expect(response.status).to eq 201

      end


    end

    context 'There is one piece of history data' do

      before do
        fake_dto = ClickTimeRecordDto.new(2, Time.now)
        allow(QueryService).to receive(:get_user_click_histories).and_return([fake_dto])
      end


      it 'check service execution & received params' do

        expect(QueryService).to receive(:get_user_click_histories).with(1).once

        expect(CommandService).to receive(:save_click_time).with(1,
                                                                 "wake_up",
                                                                 Time.zone.parse('2022-12-01 14:00:00'),
                                                                 [
                                                                   { click_type: "wake_up", recorded_time: Time.zone.parse('2022-12-01 14:00:00') },
                                                                   { click_type: "go_to_sleep", recorded_time: Time.zone.parse('2022-12-01 14:00:00') }
                                                                 ])

        call_api

      end

      it 'responds click-in histories' do
        call_api
        body = JSON.parse(response.body)
        expect(body[0]["click_type"]).to eq("wake_up")
        expect(body[0]["recorded_time"].to_time.strftime("%Y-%m-%d %H:%M:%S")).to eq("2022-12-01 14:00:00")
        expect(body[1]["click_type"]).to eq("go_to_sleep")
        expect(body[1]["recorded_time"].to_time.strftime("%Y-%m-%d %H:%M:%S")).to eq("2022-12-01 14:00:00")
      end

      it 'respond 201' do
        call_api
        expect(response.status).to eq 201

      end

    end


  end

  def call_api
    params = { user_id: 1, click_type: "wake_up" }
    post '/good_night/v1/click_in/', :params => params
  end

end
