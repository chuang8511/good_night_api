require 'rails_helper'

RSpec.describe Resource::V1::ClickInOperationApi, type: :request do

  describe 'click_in API' do
    before do
      allow(CommandService).to receive(:save_click_time).and_return(true)
      allow(Time).to receive(:now).and_return(Time.zone.parse('2022-12-01 14:00:00'))
      allow(ValidationService).to receive(:error_messages).and_return("")
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

      describe 'check response' do

        before { call_api }

        it 'responds click-in histories' do
          body = JSON.parse(response.body)
          expect(body[0]["click_type"]).to eq("wake_up")
          expect(body[0]["recorded_time"].to_time.strftime("%Y-%m-%d %H:%M:%S")).to eq("2022-12-01 14:00:00")
          expect(body[1]).to eq(nil)
        end

        it_behaves_like 'return http_status_code', 201
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

      describe 'check response' do
        before { call_api }

        it 'responds click-in histories' do
          body = JSON.parse(response.body)
          expect(body[0]["click_type"]).to eq("wake_up")
          expect(body[0]["recorded_time"].to_time.strftime("%Y-%m-%d %H:%M:%S")).to eq("2022-12-01 14:00:00")
          expect(body[1]["click_type"]).to eq("go_to_sleep")
          expect(body[1]["recorded_time"].to_time.strftime("%Y-%m-%d %H:%M:%S")).to eq("2022-12-01 14:00:00")
        end

        it_behaves_like 'return http_status_code', 201
      end

    end
  end

  describe 'check abnormal pattern' do

    context 'failure response with wrong user_id' do

      before { post '/good_night/v1/click_in/', :params => { user_id: "wrong_type", click_type: "wake_up" } }

      it_behaves_like 'return http_status_code', 400
      it_behaves_like 'return error_message', "user_id is invalid"
    end

    context 'failure response with wrong click_type' do

      before { post '/good_night/v1/click_in/', :params => { user_id: 1, click_type: 1 } }

      it_behaves_like 'return http_status_code', 400
      it_behaves_like 'return error_message', "click_type does not have a valid value"
    end

    context 'error_messages present' do
      before do
        allow(ValidationService).to receive(:error_messages).and_return("fake_error_message")
        post '/good_night/v1/click_in/', :params => { user_id: 1, click_type: "wake_up" }
      end
      it_behaves_like 'return http_status_code', 400
      it_behaves_like 'return error_message', "fake_error_message"
    end

  end

  def call_api
    params = { user_id: 1, click_type: "wake_up" }
    post '/good_night/v1/click_in/', :params => params
  end

end
