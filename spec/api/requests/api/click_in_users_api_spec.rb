require 'rails_helper'

RSpec.describe Resource::V1::ClickInUsersApi, type: :request do

  describe 'call follow API' do
    before { allow(CommandService).to receive(:follow_user).and_return(1) }

    it 'execute follow_user with params' do

      expect(CommandService).to receive(:follow_user).with(1, 2).once

      call_follow
    end

    describe 'check response' do
      before { call_follow }

      it 'responds connection id' do
        expect(JSON.parse(response.body)["connection_id"]).to eq 1
      end

      it_behaves_like 'return http_status_code', 201
    end

  end


  describe 'call unfollow API' do
    before { allow(CommandService).to receive(:unfollow_user).and_return(true) }

    it 'execute unfollow_user with params' do

      expect(CommandService).to receive(:unfollow_user).with(3).once

      call_unfollow
    end

    describe 'check response' do
      before { call_unfollow }

      it 'responds connection id' do
        expect(JSON.parse(response.body)).to eq true
      end

      it_behaves_like 'return http_status_code', 201
    end

  end


  def call_follow
    params = { user_id: 1, follow_user_id: 2 }
    post '/good_night/v1/click_in_user/follow', :params => params
  end

  def call_unfollow
    params = { connection_id: 3 }
    post '/good_night/v1/click_in_user/unfollow', :params => params
  end


end
