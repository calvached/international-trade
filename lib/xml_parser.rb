class XmlParser
  def parse_xml(file)
    xml_string = read(file)
    parsed_data = []

    parse_rates(xml_string).each do |row|
      parsed_data << extract_data_sets(row)
    end

    format_rate(parsed_data)
  end

  private
  def format_rate(data_set)
    Hash[*data_set.flatten]
  end

  def extract_data_sets(row)
    data_sets = []
    matches = row[0].scan(/<\w+>(\w+\.?\d*)/).flatten
    data_sets << matches[0] + matches[1]
    data_sets << matches[2].to_f
    data_sets
  end

  def parse_rates(string)
    string.scan(/<rate>(.*?)<\/rate>/m)
  end

  def read(file)
    File.read(file)
  end
end

