#!/usr/bin/env ruby
# Loads the sp500 monthly data into $SP500_MONTHLY

require 'csv'

DataPoint = Struct.new(:date, :open, :high, :low, :close, :adj_close, :volume)

def read_csv filename
  data = []
  CSV.foreach(filename) do |row|
    data.push DataPoint.new(row[0], row[1].to_f, row[2].to_f, row[3].to_f, row[4].to_f, row[5].to_f, row[6].to_f)
  end

  # Remove the first element, which was the headers row
  data.shift

  return data
end

