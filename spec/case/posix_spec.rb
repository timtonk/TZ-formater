require 'spec_helper'

describe TZFormater::PosixTZ do
  let(:tz) { 'VLAT-11' }

  context 'PosixTZ.all' do
    subject { TZFormater::PosixTZ }

    it 'contains one of timezone' do
      expect(subject.all).to include(tz)
    end
  end


  context 'with one-to-one mapped timezone' do
    subject { TZFormater::PosixTZ.new(tz) }

    it 'returns olson-like string' do
      expect(subject.to_olson).to include('Asia/Vladivostok')
    end

    it 'returns the only olson-like string' do
      expect(subject.to_olson.size).to eql(1)
    end

    it 'returns win-like string' do
      expect(subject.to_win).to include('(UTC+11:00) Vladivostok')
    end

    it 'returns the only win-like string' do
      expect(subject.to_win.size).to eql(1)
    end

    it 'returns win registry string' do
      expect(subject.to_win_reg).to include('Vladivostok Standard Time')
    end

    it 'returns the only win registry string' do
      expect(subject.to_win_reg.size).to eql(1)
    end
  end

end
