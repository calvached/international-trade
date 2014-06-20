require 'xml_parser'

describe XmlParser do
  let(:parser) { XmlParser.new }

  it 'returns formatted data sets' do
    expect(parser.parse_xml('data/rates.xml')).to eq(
        { 'AUDCAD' => 1.0079, 'AUDEUR' => 0.7439,
          'CADAUD' => 0.9921, 'CADUSD' => 1.0090,
          'EURAUD' => 1.3442, 'USDCAD' => 0.9911 })
  end
end
