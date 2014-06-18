class XmlParser
  def parse_xml(file)
    xml_string = read(file)
    parsed_data = []

    parse_rates(xml_string).each do |row|
      data_set = extract_data_sets(row)
      parsed_data << format_rate(data_set)
    end

    parsed_data
  end

  def format_rate(data_set)
    rate = Hash[*data_set.flatten]
    rate['conversion'] = rate['conversion'].to_f
    rate
  end

  def extract_data_sets(row)
    row[0].scan(/<(\w+)>(\w+\.?\d*)/)
  end

  def parse_rates(string)
    string.scan(/<rate>(.*?)<\/rate>/m)
  end

  def read(file)
    File.read(file)
  end
end
