require 'spec_helper'

describe TZFormater::Common::PstoreAdapter, depends: :PstoreHelper do
  let(:pstore_adapter) { TZFormater::Common::PstoreAdapter.new(filename) }
  after(:all) { delete_test_file }

  context 'when incorrect file provided' do
    let!(:filename) { 'azaza' }

    it 'raises an PStore::Error' do
      expect { pstore_adapter }.to raise_error(PStore::Error)
    end

    it 'contains correct description for exception' do
      expect { pstore_adapter }.to raise_error("Cannot find such file -- " + filename)
    end
  end

  context 'when correct file provided' do
    let!(:filename) { generate_test_file }

    context '#get_all_keys' do
      subject { pstore_adapter.get_all_keys(type) }

      context 'with existed type' do
        let!(:type) { :posix }

        it 'returns all keys of type' do
          expect(subject).to eql(['VLAT-11', 'CET-1CEST,M3.5.0,M10.5.0/3']) # TODO: get assertion from stub_file
        end
      end

      context 'with non-existed type' do
        let!(:type) { :gavno }

        it 'returns empty object' do
          expect(subject.size).to eql(0)
        end

        it 'returns an Array object' do
          expect(subject).to be_an_instance_of(Array)
        end
      end
    end

    context '#get_all' do
      subject { pstore_adapter.get_all(type) }

      context 'with existed type' do
        let!(:type) { :posix }

        it 'returns a complete value of such root' do
          expect(subject).to eql({"VLAT-11" => "test_string", "CET-1CEST,M3.5.0,M10.5.0/3" => "test_string2"}) # TODO: get assertion from stub_file
        end
      end

      context 'with non-existed type' do
        let!(:type) { :gavno }

        it 'returns empty object' do
          expect(subject.size).to eql(0)
        end

        it 'returns a Hash object' do
          expect(subject).to be_an_instance_of(Hash)
        end
      end
    end

    context '#get_by' do
      let!(:key)  { 'VLAT-11' }
      subject { pstore_adapter.get_by(type, key) }

      context 'with non-existed type' do
        let!(:type) { :gavno }

        context 'and existed key' do # actualy it makes no sense because any key doesn't exist in nonexisted type
          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'and non-existed key' do
          let!(:key)  { 'VLAT-12' }

          it 'returns nil' do
            expect(subject).to be_nil
          end
        end
      end

      context 'with existed type' do
        let!(:type) { :posix }

        context 'and existed key' do
          it 'returns required values' do
            # TODO: get information from stub_file
            expect(subject).to eql('test_string')
          end
        end

        context 'and non-existed key' do
          let!(:key)  { 'VLAT-12' }

          it 'returns nil' do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end