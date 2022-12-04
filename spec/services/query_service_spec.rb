require 'rails_helper'

RSpec.describe QueryService do

  describe '#get_user_click_histories' do
    before do
      mock_persistence_get_user_click_histories(1)
    end


    context 'type is 1' do
      before do
        mock_persistence_get_user_click_histories(1)
      end

      it 'responds order dtos_array' do
        response = get_user_click_histories
        expect(response[0].type_integer).to eq 1
        expect(response[0].recorded_datetime).to eq Time.zone.parse('2022-12-01 14:00:00')
        expect(response[0].click_type_string).to eq "wake_up"

      end

    end

    context 'type is 2' do
      before do
        mock_persistence_get_user_click_histories(2)
      end

      it 'responds order dtos_array' do
        response = get_user_click_histories
        expect(response[0].type_integer).to eq 2
        expect(response[0].recorded_datetime).to eq Time.zone.parse('2022-12-01 14:00:00')
        expect(response[0].click_type_string).to eq "go_to_sleep"

      end

    end

    it 'execute query service' do

      expect(Persistences::QueryService).to receive(:get_user_click_histories).with(1).once

      get_user_click_histories

    end


  end

  describe '#get_friends' do
    before { allow(Persistences::QueryService).to receive(:get_friends).and_return([{ "id" => 1, "name" => "fake_name" }]) }

    it 'responds order dtos_array' do
      response = get_friends
      expect(response[0].id).to eq 1
      expect(response[0].name).to eq 'fake_name'
    end

    it 'execute query service' do

      expect(Persistences::QueryService).to receive(:get_friends).with(1).once

      get_friends

    end

  end


  describe '#get_friend_sleep_records' do

    before { allow(Persistences::QueryService).to receive(:get_friend_sleep_records).and_return([{ "record_date" => Date.parse("2022-12-03"), "sleep_seconds" => 10000 }]) }

    it 'responds order dtos_array' do
      response = get_friend_sleep_records
      expect(response[0].record_date).to eq Date.parse("2022-12-03")
      expect(response[0].sleep_seconds).to eq 10000
    end

    it 'execute query service' do

      expect(Persistences::QueryService).to receive(:get_friend_sleep_records).with(3).once

      get_friend_sleep_records

    end

  end

  def get_user_click_histories
    QueryService.get_user_click_histories(1)
  end

  def mock_persistence_get_user_click_histories(click_type)
    allow(Persistences::QueryService).to receive(:get_user_click_histories).and_return([{
                                                                                          "click_type" => click_type,
                                                                                          "record_datetime" => Time.zone.parse('2022-12-01 14:00:00')
                                                                                        }
                                                                                       ])
  end

  def get_friends
    QueryService.get_friends(1)
  end

  def get_friend_sleep_records
    QueryService.get_friend_sleep_records(3)
  end
end
