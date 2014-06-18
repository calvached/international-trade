require 'csv_parser'

describe CsvParser do
  it 'formats data' do
    parser = CsvParser.new
    expect(parser.parse('spec/SAMPLE_TRANS.csv')).to eq(
      [
        {'store' => 'Yonkers', 'sku' => 'DM1210', 'amount' => '70.00 USD'},
        {'store' => 'Yonkers', 'sku' => 'DM1182', 'amount' => '19.68 AUD'},
        {'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => '58.58 AUD'},
        {'store' => 'Scranton', 'sku' => 'DM1210', 'amount' => '68.76 USD'},
        {'store' => 'Camden', 'sku' => 'DM1182', 'amount' => '54.64 USD'},
      ])
  end
end
