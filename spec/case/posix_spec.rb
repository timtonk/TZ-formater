require 'spec_helper'

describe TZFormater::PosixTZ do
  let(:tz)          { 'MST7' } # Arizona
  let(:posix_class) { TZFormater::PosixTZ }
  let(:posix_tz)    { posix_class.new(tz) }

  context 'class method' do
    subject { posix_class }

    context '.all' do
      let(:tz) { 'VLAT-11' }

      it 'contains one of timezone' do
        expect(subject.all.map(&:name)).to include(tz)
      end
    end

    context '.new' do
      context 'with incorrect tz' do
        let(:tz) { 'random stuff' }

        it 'raises an ArgumentError' do
          expect { posix_tz }.to raise_error(ArgumentError)
        end

        it 'raises with correct message' do
          expect { posix_tz }.to raise_error('Unknown posix timezone')
        end
      end

      context 'with correct tz' do
        it 'creates valid object' do
          expect(posix_tz).to be_an_instance_of(posix_class)
        end
      end
    end
  end

  context 'with one-to-one mapped timezone' do
    let(:tz) { 'VLAT-11' }
    subject { posix_tz }

    it 'returns olson-like string' do
      expect(subject.olson).to include('Asia/Vladivostok')
    end

    it 'returns the only olson-like string' do
      expect(subject.olson.size).to eql(1)
    end

    it 'returns win-like string' do
      expect(subject.win).to include('(UTC+11:00) Vladivostok')
    end

    it 'returns the only win-like string' do
      expect(subject.win.size).to eql(1)
    end

    it 'returns win registry string' do
      expect(subject.win_reg).to include('Vladivostok Standard Time')
    end

    it 'returns the only win registry string' do
      expect(subject.win_reg.size).to eql(1)
    end
  end

  context 'with many-to-many mapped timezone' do
    let(:tz) { 'CET-1CEST,M3.5.0,M10.5.0/3' }
    subject { posix_tz }

    it 'returns olson-like string' do
      expect(subject.olson).to include('Europe/Berlin')
    end

    it 'returns many olson-like string' do
      expect(subject.olson.size).to eql(4)
    end

    it 'returns win-like string' do
      expect(subject.win).to include('(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague')
    end

    it 'returns many win-like string' do
      expect(subject.win.size).to eql(4)
    end

    it 'returns win registry string' do
      expect(subject.win_reg).to include('Romance Standard Time')
    end

    it 'returns many win registry string' do
      expect(subject.win_reg.size).to eql(4)
    end
  end
end
