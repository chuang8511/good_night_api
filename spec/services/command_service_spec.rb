require 'rails_helper'

RSpec.describe CommandService do

  describe '#save_click_time' do
    before { allow(Persistences::Repository).to receive(:save_click_time).and_return(true) }

    context "wake_up" do

      it 'save data as repository with received params' do

        expect(Persistences::Repository).to receive(:save_click_time).with(1,
                                                                           1,
                                                                           Time.zone.parse('2022-12-01 14:00:00'),
                                                                           60)


        save_click_time("wake_up", [{ click_type: "go_to_sleep", recorded_time: Time.zone.parse('2022-12-01 13:59:00') }])

      end

    end


    context 'sleep' do

      it 'save data as repository with received params' do

        expect(Persistences::Repository).to receive(:save_click_time).with(1,
                                                                           2,
                                                                           Time.zone.parse('2022-12-01 14:00:00'),
                                                                           nil)


        save_click_time("go_to_sleep", [])

      end

    end

  end


  def save_click_time(click_type, response)
    CommandService.save_click_time(1, click_type, Time.zone.parse('2022-12-01 14:00:00'), response)
  end

end
