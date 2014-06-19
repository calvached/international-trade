require 'currency_converter'

describe CurrencyConverter do
  let(:converter) { CurrencyConverter.new }

  it 'converts currency when direct conversion rate exists' do
    expect(converter.convert(60.10, 'CADUSD')).to eq(60.64)
    expect(converter.convert(50.00, 'AUDEUR')).to eq(37.2)
  end

  it "converts currency to CAD, then to destination country when direct converation rate doesn't exist" do
    expect(converter.convert(2.30, 'AUDUSD')).to eq(2.34)
  end

  it 'returns a converted amount' do
    expect(converter.get_converted_amount(60.00, 2.00)).to eq(120.00)
  end

  it 'returns a rounded amount using bankers round' do
    expect(converter.bankers_round(54.1754)).to eq(54.18)
    expect(converter.bankers_round(343.2050)).to eq(343.20)
    expect(converter.bankers_round(106.2038)).to eq(106.20)
    expect(converter.bankers_round(134.229245622)).to eq(134.22)
    expect(converter.bankers_round(59.574167038)).to eq(59.57)
    expect(converter.bankers_round(20.013991248)).to eq(20.01)
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
