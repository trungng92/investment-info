#!/usr/bin/env ruby
# CLI script that lets you run investment strategies on csv data


require 'optparse'

require_relative 'data-points-reader'
require_relative 'strategy-investment-calculator'
require_relative 'strategies-reader'

$OPTIONS = {}

def parse_options
  OptionParser.new do |opts|
    opts.banner = "Usage: runner.rb [options]"

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

def main
  parse_options

  $OPTIONS[:csv_file] ||= 'sp500-monthly.csv'
  raise "Could not find file '#{$OPTIONS[:csv_file]}'" unless File.file? $OPTIONS[:csv_file]
  data_points = read_finance_data $OPTIONS[:csv_file]

  $OPTIONS[:start_index] ||= 0
  raise "start index '#{$OPTIONS[:start_index]}' is out of bounds [0:#{data_points.size}]" unless $OPTIONS[:start_index].between?(0, data_points.size)

  $OPTIONS[:end_index] ||= data_points.size
  raise "end index '#{$OPTIONS[:end_index]}' is out of bounds [0:#{data_points.size}]" unless $OPTIONS[:end_index].between?(0, data_points.size)

  $OPTIONS[:strategy_file] ||= 'strategies-monthly.csv'
  raise "Could not find file '#{$OPTIONS[:strategy_file]}'" unless File.file? $OPTIONS[:strategy_file]
  strategies = read_strategies_data $OPTIONS[:strategy_file]

  data_points_slice = data_points[$OPTIONS[:start_index]..$OPTIONS[:end_index]]

  calculate_gains_strategies(data_points_slice, strategies)
end

if __FILE__ == $0
  # If for some reason someone wants to pipe the data and the pipe closes, then just exit
  Signal.trap("PIPE", "EXIT")

  main
end
