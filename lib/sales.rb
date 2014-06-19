require_relative 'csv_parser'
require_relative 'currency_converter'

class Sales
  attr_accessor :converter
  def initialize(transaction_file = 'data/SAMPLE_TRANS.csv', rates_file = 'data/rates.xml')
    @sales = CsvParser.new.parse(transaction_file)
    @converter = CurrencyConverter.new(rates_file)
  end

  def run(sku)
    filtered_sales = filter_by(sku)
    converted_usd_sales = to_usd(filtered_sales)
    total(converted_usd_sales)
  end

  def to_usd(sales)
    amounts = []

    sales.each do |sale|
     amounts <<  @converter.convert(sale['amount'], sale['origin'] + 'USD')
    end

    amounts
  end

  def filter_by(sku)
    filtered_sales = []

    @sales.each do |sale|
      filtered_sales << sale if sale['sku'] == sku
    end

    filtered_sales
  end

  def total(amounts)
   amounts.reduce(:+)
  end
end
