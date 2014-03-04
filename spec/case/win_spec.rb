require 'spec_helper'

describe TZFormater::WinTZ do
  let(:tz)            { '(UTC+11:00) Vladivostok' } # Vladivostok
  let(:posix_class)   { TZFormater::PosixTZ }
  let(:olson_class)   { TZFormater::OlsonTZ }
  let(:win_class)     { TZFormater::WinTZ }
  let(:win_reg_class) { TZFormater::WinRegTZ }

  let(:win_tz)      { win_class.new(tz) }

  context 'class method' do
    subject { win_class }

    context '.all' do
      it 'contains one of timezone' do
        expect(subject.all.map(&:name)).to include(tz)
      end

      it 'contains instances of the same class' do
        expect(subject.all[0]).to be_an_instance_of subject
      end

      it 'returns an enumerable object' do
        expect(subject.all).to be_a_kind_of Enumerable
      end
    end

    context '.new' do
      context 'without tz' do
        it 'raises an ArgumentError' do
          expect { subject.new }.to raise_error ArgumentError
        end

        it 'raises with correct standard message' do
          expect { subject.new }.to raise_error 'wrong number of arguments (0 for 1..2)'
        end
      end

      context 'with incorrect tz' do
        let(:tz) { 'random stuff' }

        it 'raises an ArgumentError' do
          expect { win_tz }.to raise_error ArgumentError
        end

        it 'raises with correct custom message' do
          expect { win_tz }.to raise_error 'Unknown win timezone'
        end
      end

      context 'with correct tz' do
        it 'creates valid object' do
          expect(win_tz).to be_an_instance_of win_class
        end
      end
    end
  end

  context 'instance method' do
    subject(:wintz_instance) { win_tz }

    context '#name' do
      subject { wintz_instance.name }

      it 'returns a string' do
        expect(subject).to be_an_instance_of String
      end

      it 'returns its name' do
        expect(subject).to eql tz
      end
    end

    context '#win' do
      subject { wintz_instance.win }

      it 'returns a wintz instance' do
        expect(subject).to be_an_instance_of win_class
      end

      it 'doesn\'t create a new instance' do
        expect(subject).to be wintz_instance
      end
    end

    context '#posix' do
      subject { wintz_instance.posix }

      it 'returns a posixtz instance' do
        expect(subject).to be_an_instance_of posix_class
      end
    end

    context '#olson' do
      subject { wintz_instance.olson }

      it 'returns an olsontz instance' do
        expect(subject).to be_an_instance_of olson_class
      end
    end

    context '#win_reg' do
      subject { wintz_instance.win_reg }

      it 'returns a list' do
        expect(subject).to be_an_instance_of Array
      end

      it 'contains WinRegTZ objects' do
        expect(subject.first).to be_an_instance_of win_reg_class
      end
    end

    context '#offset' do
      subject { wintz_instance.offset }

      it 'returns an integer' do
        expect(subject).to be_a_kind_of Integer
      end
    end
  end
end
