require 'sales'

describe Sales do
  let(:sales) { Sales.new }

  it 'adds all the sales from a given sku' do
    sales.converter = instance_double("CurrencyConverter", :rates => {'USDUSD' => 2})
    sales.sales = [{"store"=>"Yonkers", "sku"=>"DM1182", "amount"=>70.0, "origin"=>"USD"}]
    allow(sales.converter).to receive(:convert).with(70.0, 'USDUSD').and_return(140.0)

    expect(sales.total('DM1182')).to eq(140.0)
  end
end
