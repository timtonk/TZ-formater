require 'pstore'

module PstoreHelper
  FILENAME = File.expand_path('../test_data/test.pstore', File.dirname(__FILE__))
  STUB_FILE = File.expand_path('../test_data/pstore_stub.yml', File.dirname(__FILE__))

  def generate_test_file
    delete_test_file
    generate_file(FILENAME, stub_data)
    FILENAME
  end

  def delete_test_file
    File.delete(FILENAME) if File.exist? FILENAME
  end

  private
    def generate_file(filename, data)
      file = PStore.new(filename)
      file.transaction do
        data.each{|key, value| file[key.to_sym] = value } # A Hash object can't be just assigned to a PStore object
      end
    end

    def stub_data
      Psych.load_file(STUB_FILE)
    end
end