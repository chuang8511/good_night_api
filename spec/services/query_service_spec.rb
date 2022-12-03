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

      it 'responds order array_hashes' do
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

      it 'responds order array_hashes' do
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

end
