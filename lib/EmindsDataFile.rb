class EmindsDataFile
  attr_accessor :file
  
  def initialize(file)
    @file = file
  end
  
  def find_value(target_string, property_name)
    if (target_string.index("\{\\#{property_name}\}"))
      tokens = target_string.split(/[\{, \}]/)
      tokens.last if tokens.size==4
    else
      nil
    end
  end
  
  def read(property_name)
    found_value = nil
    File.open(file).each do |line|
      value = find_value(line.chomp, property_name)
      found_value = value if not value.nil?
    end
    found_value
  end
  
end