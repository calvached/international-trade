require 'csv'

class CsvParser
  def parse_file(file)
    parsed_data = []

    CSV.foreach(file, :headers => true) do |transaction|
      parsed_data << format_data(transaction)
    end

   parsed_data
  end

  def format_data(transaction)
    {
     'store'  => transaction['store'],
     'sku'    => transaction['sku'],
     'amount' => transaction['amount']
    }
  end
end
