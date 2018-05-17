#!/usr/bin/env ruby
# Loads the sp500 monthly data into $SP500_MONTHLY

require 'csv'

DataPoint = Struct.new(:date, :open, :high, :low, :close, :adj_close, :volume)
$CSV_FILENAME = 'sp500-monthly.csv'

$SP500_MONTHLY = []

# First row is the header, so we ignore that
CSV.foreach($CSV_FILENAME, {:headers=>:first_row}) do |row|
  $SP500_MONTHLY.push DataPoint.new(*row)
end
