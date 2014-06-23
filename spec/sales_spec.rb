require 'sales'

describe Sales do
  let(:sales) { Sales.new }

  it 'adds all the sales from a given sku' do
    CurrencyConverter.any_instance.stub(:convert).and_return(2)

    expect(sales.total('DM1182')).to eq(6)
  end
end
