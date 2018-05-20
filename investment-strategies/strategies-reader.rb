#!/usr/bin/env ruby
# Reads in yearly investment strategies
# Where a strategy is an array of items that add up to 1
# A strategy can represent a month, a day, or any arbitrary amount
require 'csv'

# Returns a map of {strategy_name: strategy_array}
def read_strategies_data filename
  strategies = {}
  CSV.foreach(filename) do |row|
    name = row[0]
    values = row.drop(1).map {|v| v == '0' ? 0 : Rational(v)}
    values_sum = values.reduce(:+)
    raise "strategy '#{name}' should sum up to 1, but sums up to '#{values_sum}'" unless values_sum == 1

    puts "Found strategy '#{name}' with values '#{values}'"
    strategies[name] = values
  end

  return strategies
end

