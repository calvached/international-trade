require 'sales'

describe Sales do
  let(:sales) { Sales.new }

  it 'adds all the sales from a given sku' do
    rate = {'USDUSD' => 2}
    converter = instance_double("CurrencyConverter", :rates => rate)
    sales.converter = converter
    sales.sales = [{"store"=>"Yonkers", "sku"=>"DM1182", "amount"=>70.0, "origin"=>"USD"}]
    allow(converter).to receive(:convert).with(70.0, 'USDUSD').and_return(160.0)

    expect(sales.total('DM1182')).to eq(160.0)
  end
end
