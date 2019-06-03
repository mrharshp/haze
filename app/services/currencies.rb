require 'open-uri'
require 'json'

class Currencies
  def self.find_currencies
    url = 'https://openexchangerates.org/api/currencies.json?app_id='
    currency = JSON.parse(open(url).read)
    @final_currency = []
    currency.map do |cu, country|
      @final_currency << { country: country, symbol: cu }
    end
  end
end
