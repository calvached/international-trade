class CurrencyConverter
  def initialize(file)
    @rates = XmlParser.new.parse_xml(file)
  end

  def convert(sale, destination_country)
    @rates.each do |rate|
      if origin_country_of(sale) == rate['from'] && destination_country == rate['to']
        converted_amount = get_converted_amount(sale, rate)

        sale['amount'] = "#{bankers_round(converted_amount)} #{destination_country}"
      end
    end

    sale
  end

  def get_converted_amount(sale, rate)
    rate['conversion'].to_f * sale['amount'][0..-5].to_f
  end

  def origin_country_of(sale)
    sale['amount'].split[1]
  end

  def bankers_round(amount)
    rounded_amount = standard_round(amount)

    if last_two_digits(rounded_amount).even?
      rounded_amount
    else
      rounded_amount - 0.01
    end
  end

  def last_two_digits(amount)
    amount.to_s.split('.')[1].to_i
  end

  def standard_round(amount)
    (amount * 100).round / 100.0
  end
end
