require 'rails_helper'

RSpec.describe ValidationService do

  describe '#error_messages' do

    context 'click_time_dtos is blank' do

      context 'click_type is go_to_sleep' do
        it { expect(error_messages("go_to_sleep", [])).to eq "" }
      end

      context 'click_type is NOT go_to_sleep' do
        it { expect(error_messages("fake_type", [])).to eq "first click_type should be go_to_sleep" }
      end

    end

    context 'click_time_dtos is present click is not latest' do

      before { @fake_dto = ClickTimeRecordDto.new(1, Time.zone.now + 1.hour) }
      it { expect(error_messages("fake_type", [@fake_dto])).to eq "click in should be the latest" }

    end

    context 'click_time_dtos is present & click is latest' do
      before do
        @fake_dto = ClickTimeRecordDto.new(1, Time.zone.now - 1.hour)
        allow_any_instance_of(ClickTimeRecordDto).to receive(:click_type_string).and_return("fake_type")
      end

      context 'click type is different from last time' do
        it { expect(error_messages("different_fake_type", [@fake_dto])).to eq "" }
      end

      context 'click type is same from last time' do
        it { expect(error_messages("fake_type", [@fake_dto])).to eq "click_type should different from last time" }
      end

    end

  end

  def error_messages(click_type, dtos)
    ValidationService.error_messages(click_type, Time.zone.now, dtos)
  end

end
