require "test/unit"

require "EmindsDataFile"

class TestLibraryFileName < Test::Unit::TestCase
  TEST_DATA_FILE = "volume-data-for-testing.tex"

  def setup
    @eminds_data_file = EmindsDataFile.new(TEST_DATA_FILE)
  end
  
  def test_find_value_with_proper_property_returns_right_value
    target_string = '\newcommand{\emindsISSNprinted}{1697-9613}'
    value = @eminds_data_file.find_value(target_string, 'emindsISSNprinted')
    
    assert_not_nil(value)
    assert_equal("1697-9613", value)
  end
  
  def test_find_value_with_missing_property_returns_nill
    target_string = '\newcommand{\emindsISSNprinted}{1697-9613}'
    value = @eminds_data_file.find_value(target_string, 'emindsISSNprintedNOTEXISTING')
    
    assert_nil(value)
  end
  
  def test_read_proper_value
    value = @eminds_data_file.read('emindsISSNprinted')
    assert_not_nil(value)
    assert_equal("1697-9613", value)
    assert_equal("I", @eminds_data_file.read("emindsVolumeCount"))
    assert_equal("5", @eminds_data_file.read("emindsVolumeNumber"))
  end

end

