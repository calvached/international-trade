require_relative 'csv_parser'
require_relative 'currency_converter'

class Sales
  attr_accessor :converter
  def initialize(transaction_file = 'data/SAMPLE_TRANS.csv', rates_file = 'data/rates.xml')
    @sales = CsvParser.new.parse(transaction_file)
    @converter = CurrencyConverter.new(rates_file)
  end

  def total(sku)
    current_total = 0

    @sales.each do |sale|
      if sale['sku'] == sku
        current_total += @converter.convert(sale['amount'], sale['origin'] + 'USD')
      end
    end
    current_total
  end

end
