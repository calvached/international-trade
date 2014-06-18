require 'xml_parser'

describe XmlParser do
  let(:parser) { XmlParser.new }

  it 'reads a file' do
   expect(parser.read('spec/rates.xml')).to be_a(String)
  end

  it 'returns each set of rates' do
    test_rates =  '<rate>
        <from>AUD</from>
            <to>CAD</to>
                <conversion>1.0079</conversion>
                  </rate>
                    <rate>
    <from>AUD</from>
    <to>EUR</to>
    <conversion>0.7439</conversion>
    </rate>'

    expect(parser.parse_rates(test_rates)).to eq([["\n        <from>AUD</from>\n            <to>CAD</to>\n                <conversion>1.0079</conversion>\n                  "], ["\n    <from>AUD</from>\n    <to>EUR</to>\n    <conversion>0.7439</conversion>\n    "]])
  end

  it 'extracts data labels with their cooresponding values' do
    test_row = ["\n\t\t<from>AUD</from>\n\t\t<to>CAD</to>\n\t\t<conversion>1.0079</conversion>\n\t"]

    expect(parser.extract_data_sets(test_row)).to eq([["from", "AUD"], ["to", "CAD"], ["conversion", "1.0079"]])
  end

  it 'formats a row of data' do
    test_row = [["from", "AUD"], ["to", "CAD"], ["conversion", "1.0079"]]

    expect(parser.format_rate(test_row)).to eq({"from"=>"AUD", "to"=>"CAD", "conversion"=>1.0079})
  end

  it 'returns formatted data sets' do
    expect(parser.parse_xml('spec/rates.xml')).to eq(
      [
        {'from' => 'AUD', 'to' => 'CAD', 'conversion' => 1.0079},
        {'from' => 'AUD', 'to' => 'EUR', 'conversion' => 0.7439},
        {'from' => 'CAD', 'to' => 'AUD', 'conversion' => 0.9921},
        {'from' => 'CAD', 'to' => 'USD', 'conversion' => 1.0090},
        {'from' => 'EUR', 'to' => 'AUD', 'conversion' => 1.3442},
        {'from' => 'USD', 'to' => 'CAD', 'conversion' => 0.9911},
      ])
  end
end
