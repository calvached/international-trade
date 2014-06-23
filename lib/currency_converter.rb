require_relative 'xml_parser'

class CurrencyConverter
  attr_accessor :rates
  def initialize(file = 'data/rates.xml')
    @rates = XmlParser.new.parse_xml(file)
  end

  def convert(amount, conversion)
    if @rates[conversion]
      converted_amount = get_converted_amount(amount, @rates[conversion])
      bankers_round(converted_amount)
    else
      converted_cad = get_converted_amount(amount, @rates[conversion[0..-4] + 'CAD'])
      converted_amount = get_converted_amount(converted_cad, @rates['CADUSD'])
      bankers_round(converted_amount)
    end
  end

  def bankers_round(amount)
    three_decimal_amount = round_to_three_decimals(amount)
    rounded_amount = standard_round(three_decimal_amount)

    if last_digits(rounded_amount).even? || last_digits(three_decimal_amount).to_s[-1,1].to_i < 5
      rounded_amount
    else
      rounded_amount - 0.01
    end
  end

  private
  def get_converted_amount(amount, rate)
    amount * rate
  end

  def last_digits(amount)
    amount.to_s.split('.')[1].to_i
  end

  def round_to_three_decimals(amount)
    (amount * 1000).round / 1000.0
  end

  def standard_round(amount)
    (amount * 100).round / 100.0
  end
end
