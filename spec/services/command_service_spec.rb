require 'rails_helper'

RSpec.describe CommandService do

  shared_examples 'call services with received params' do |called_method: , received_params: , method_params: |
    it "save data as repository with received params" do
      expect(Persistences::Repository).to receive(called_method.to_sym).with(*received_params).once

      CommandService.send(called_method.to_sym, *method_params)
    end
  end

  describe '#save_click_time' do
    before { allow(Persistences::Repository).to receive(:save_click_time).and_return(true) }

    context "wake_up" do

      # to-be-discussed: readability vs. D.R.Y
      # it 'save data as repository with received params' do
      #
      #   expect(Persistences::Repository).to receive(:save_click_time).with(1,
      #                                                                      1,
      #                                                                      Time.zone.parse('2022-12-01 14:00:00'),
      #                                                                      60)
      #
      #
      #   save_click_time("wake_up", [{ click_type: "go_to_sleep", recorded_time: Time.zone.parse('2022-12-01 13:59:00') }])
      #
      # end

      it_behaves_like 'call services with received params',
                      called_method:   "save_click_time",
                      received_params: [1, 1, Time.zone.parse('2022-12-01 14:00:00'), 60],
                      method_params:   [1, "wake_up", Time.zone.parse('2022-12-01 14:00:00'), [{ click_type: "go_to_sleep", recorded_time: Time.zone.parse('2022-12-01 13:59:00') }]]

    end


    context 'sleep' do

      it_behaves_like 'call services with received params',
                      called_method:   "save_click_time",
                      received_params: [1, 2, Time.zone.parse('2022-12-01 14:00:00'), nil],
                      method_params:   [1, "go_to_sleep", Time.zone.parse('2022-12-01 14:00:00'), []]

    end

  end


  describe '#follow_user' do

    before do
      fake_connection = UserConnection.new(id: 1,  click_in_user_id: 1, followed_user_id: 2)
      allow(Persistences::Repository).to receive(:follow_user).and_return(fake_connection)
    end

    it_behaves_like 'call services with received params',
                    called_method:   "follow_user",
                    received_params: [1, 2],
                    method_params:   [1, 2]

    describe 'check response' do

      it { expect(CommandService.follow_user(1, 2)).to eq 1 }

    end

  end

  describe '#unfollow_user' do
    before { allow(Persistences::Repository).to receive(:unfollow_user).and_return(true) }

    it_behaves_like 'call services with received params',
                    called_method:   "unfollow_user",
                    received_params: [1],
                    method_params:   [1]

  end

end
