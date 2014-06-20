require 'sales'

describe Sales do
  let(:sales) { Sales.new }

  it 'adds all the sales from a given sku' do
    expect(sales.total('DM1182')).to eq(134.22)
  end
end
