require 'currency_converter'

describe CurrencyConverter do
  let(:converter) { CurrencyConverter.new('spec/rates.xml') }

  it 'converts currency' do
    sale = {'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => 60.10, 'origin' => 'CAD'}
    sale_2 = {'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => 50.00, 'origin' =>'AUD'}
    expect(converter.convert(sale, 'USD')).to eq({'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => 60.64, 'origin' => 'USD'})
    expect(converter.convert(sale_2, 'EUR')).to eq({'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => 37.2, 'origin' => 'EUR'})
  end

  it 'returns a converted amount' do
    rate = {"from"=>"AUD", "to"=>"CAD", "conversion" => 2.00}
    sale = {"store"=>"Nashua", "sku"=>"DM1182", "amount" => 60.00, 'origin' => 'AUD'}

    expect(converter.get_converted_amount(sale, rate)).to eq(120.00)
  end

  it 'returns a rounded amount using bankers round' do
    expect(converter.bankers_round(54.1754)).to eq(54.18)
    expect(converter.bankers_round(343.2050)).to eq(343.20)
    expect(converter.bankers_round(106.2038)).to eq(106.20)
  end

  it 'returns a standard rounded amount' do
    expect(converter.standard_round(60.990044574)).to eq(60.99)
    expect(converter.standard_round(60.999044574)).to eq(61.00)
    expect(converter.standard_round(60.239455550)).to eq(60.24)
  end

  it 'returns the digits after the decimal in the amount' do
    expect(converter.last_two_digits(54.18)).to eq(18)
    expect(converter.last_two_digits(343.20)).to eq(2)
  end
end
