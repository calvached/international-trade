require 'sales'

describe Sales do
  let(:sales) { Sales.new('data/SAMPLE_TRANS.csv') }

  it 'filters a list by the given sku' do
    expect(sales.filter_by('DM1182')).to eq(
      [{'store' => 'Yonkers', 'sku' => 'DM1182', 'amount' => 19.68, 'origin' => 'AUD'},
      {'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => 58.58, 'origin' => 'AUD'},
      {'store' => 'Camden', 'sku' => 'DM1182', 'amount' => 54.64, 'origin' => 'USD'}])
  end

  it 'adds all the amounts' do
    amounts = [19.68, 58.58, 54.64]
    expect(sales.total(amounts)).to eq(132.89999999999998)
  end

  it 'converts all sales into USD' do
    filtered_sales = [
      {'store' => 'Yonkers', 'sku' => 'DM1182', 'amount' => 2, 'origin' => 'AUD'},
      {'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => 3, 'origin' => 'CAD'},
      {'store' => 'Camden', 'sku' => 'DM1182', 'amount' => 3, 'origin' => 'USD'},
    ]

    expect(sales.to_usd(filtered_sales)).to eq([2.03, 3.02, 3.0])
  end

  it 'adds all the sales from a given sku' do
    expect(sales.run('DM1182')).to eq(134.22)
  end
end
