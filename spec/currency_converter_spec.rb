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

  it 'returns a rounded amount using bankers round' do
    expect(converter.bankers_round(54.1754)).to eq(54.18)
    expect(converter.bankers_round(343.2050)).to eq(343.20)
    expect(converter.bankers_round(106.2038)).to eq(106.20)
    expect(converter.bankers_round(134.229245622)).to eq(134.22)
    expect(converter.bankers_round(59.574167038)).to eq(59.57)
    expect(converter.bankers_round(20.013991248)).to eq(20.01)
  end
end
