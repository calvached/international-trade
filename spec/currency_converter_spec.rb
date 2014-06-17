require 'currency_converter'

describe CurrencyConverter do
  let(:converter) { CurrencyConverter.new('spec/rates.xml') }

  it 'converts a non-USD amount to USD' do
    amount = {'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => '60.10 CAD'}
    expect(converter.convert_to(amount, 'USD')).to eq({'store' => 'Nashua', 'sku' => 'DM1182', 'amount' => '60.64 USD'})
  end

  it 'returns the origin country' do
    sale = {"store"=>"Nashua", "sku"=>"DM1182", "amount"=>"60.10 CAD"}
    expect(converter.origin_country_of(sale)).to eq('CAD')
  end

  it 'returns a converted amount' do
    rate = {"from"=>"AUD", "to"=>"CAD", "conversion"=>"2.00"}
    sale = {"store"=>"Nashua", "sku"=>"DM1182", "amount"=>"60.00 AUD"}

    expect(converter.converting(sale, rate)).to eq(120.00)
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
