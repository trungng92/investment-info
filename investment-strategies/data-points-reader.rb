#!/usr/bin/env ruby
# Reads yahoo finance csv data

require 'csv'

DataPoint = Struct.new(:date, :open, :high, :low, :close, :adj_close, :volume)

# Returns an array of all the datapoints
def read_finance_data filename
  data = []
  CSV.foreach(filename) do |row|
    data.push DataPoint.new(row[0], row[1].to_f, row[2].to_f, row[3].to_f, row[4].to_f, row[5].to_f, row[6].to_f)
  end

  # Remove the first element, which was the headers row
  data.shift

  return data
end

