require 'csv'

class CsvParser
  def parse(file)
    parsed_data = []

    CSV.foreach(file, :headers => true) do |transaction|
      parsed_data << format_data(transaction)
    end

   parsed_data
  end

  private
  def format_data(transaction)
    {
     'store'  => transaction['store'],
     'sku'    => transaction['sku'],
     'amount' => transaction['amount'].split[0].to_f,
     'origin' => transaction['amount'].split[1]
    }
  end
end
