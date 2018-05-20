#!/usr/bin/env ruby
# Checks the difference between frontloading vs averaging

require_relative 'sp500-csv'

require 'optparse'

require_relative 'sp500-csv'
require_relative 'strategy-investment-calculator'

$OPTIONS = {}

def parse_options
  OptionParser.new do |opts|
    opts.banner = "Usage: frontload-vs-average.rb [options]"

    opts.on("-s", "--start [INDEX]", Integer, "start index of csv file") do |v|
      $OPTIONS[:start_index] = v
    end

    opts.on("-e", "--end [INDEX]", Integer, "end index") do |v|
      $OPTIONS[:end_index] = v
    end

    opts.on("-c", "--csv-file [FILE]", String, "csv file to read data points from") do |v|
      $OPTIONS[:csv_file] = v
    end

    opts.on("-t", "--strategy-file [FILE]", String, "file to read strategies from") do |v|
      $OPTIONS[:strategy_file] = v
    end

    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end

  end.parse!
end

def evaluate_options
  $OPTIONS[:csv_file] ||= 'sp500-monthly.csv'
  raise "Could not find file #{$OPTIONS[:csv_file]}" unless File.file? $OPTIONS[:csv_file]
  data_points_csv = read_csv $OPTIONS[:csv_file]

  $OPTIONS[:start_index] ||= 0
  raise "start index #{$OPTIONS[:start_index]} is out of bounds [0:#{data_points_csv.size}]" unless $OPTIONS[:start_index].between?(0, data_points_csv.size)

  $OPTIONS[:end_index] ||= data_points_csv.size
  raise "end index #{$OPTIONS[:end_index]} is out of bounds [0:#{data_points_csv.size}]" unless $OPTIONS[:start_index].between?(0, data_points_csv.size)

  data_points_csv_slice = data_points_csv[$OPTIONS[:start_index]..$OPTIONS[:end_index]]

  # Determines how you allocate your annual investments
  # Each array must add up to 1, and must have 12 elements
  strategies = {
      :strategy_frontload => [Rational(1)] + [0] * 11,
      :strategy_first_three_months => [Rational(1, 3)] * 3 + [0] * 9,
      :strategy_first_six_months => [Rational(1, 6)] * 6 + [0] * 6,
      :strategy_average => [Rational(1, 12)] * 12,
  }

  calculate_gains_strategies(data_points_csv_slice, strategies)
end

parse_options
evaluate_options