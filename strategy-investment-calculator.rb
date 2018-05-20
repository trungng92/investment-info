#!/usr/bin/env ruby
# Library for calculating investment gains
#
# Given data points from an investment spreadsheet (e.g. sp500-monthly.csv),
# Calculate how well a strategy does over the years
# (a strategy is an array size 12 where the )

MONTHS_PER_YEAR = 12

# Calculates a single gain from one data point to another
def calculate_gain(previous_data_point, current_data_point, previous_gains, new_investment)
  previous_close = previous_data_point[:close]
  current_close = current_data_point[:close]
  change_ratio = current_close / previous_close
  puts "Close: #{previous_close} -> #{current_close}; Ratio #{change_ratio}"

  return (previous_gains + new_investment) * change_ratio
end

# Calculates the gain of a strategy over the given data points
def calculate_gains_strategy(data_points, strategy)
  raise "strategy #{strategy} does not add up to 1" unless strategy.reduce(:+) == 1
  raise "strategy #{strategy} does not add have 12 elements" unless strategy.size == MONTHS_PER_YEAR

  # Make sure that strategies_copy is _at least_ as long as data_points and iterate through all items at the same time
  strategies_size_increase = (data_points.size.to_f / MONTHS_PER_YEAR).ceil
  strategy_copy = strategy * strategies_size_increase
  strategy_result = []

  data_points.each_index do |i|
    date = data_points[i][:date]
    puts "Date: #{date}"
    previous_data_point = i == 0 ? data_points[0] : data_points[i-1]
    current_data_point = data_points[i]

    previous_gains = i == 0 ? 0 : strategy_result[i-1]
    puts "Previous gains: #{previous_gains}"
    new_investment = strategy_copy[i]
    puts "New investment: #{new_investment}"

    strategy_result[i] = calculate_gain(previous_data_point, current_data_point, previous_gains, new_investment)
    puts "Current gains #{strategy_result[i]}\n\n"
  end

  return strategy_result
end

# Calculates the gain of each strategy provided over the given data points
# This is useful for when you want to calculate over multiple strategies simultaneously
def calculate_gains_strategies(data_points, strategies)
  strategies.each do |strat_name, strat_array|
    raise "strategy #{strat_name}:#{strat_array} does not add up to 1" unless strat_array.reduce(:+) == 1
    raise "strategy #{strat_name}:#{strat_array} does not add have 12 elements" unless strat_array.size == MONTHS_PER_YEAR
  end

  # Make sure that strategies_copy is _at least_ as long as data_points and iterate through all items at the same time
  strategies_size_increase = (data_points.size.to_f / MONTHS_PER_YEAR).ceil
  strategies_copy = strategies.clone
  strategies_copy.each { |k, v| strategies_copy[k] = v * strategies_size_increase }

  # results to keep track of how well each strategy is performing
  strategy_results = strategies.merge(strategies){|k,v| [] }

  data_points.each_index do |i|
    date = data_points[i][:date]
    puts "-" * 50
    puts "Date: #{date}"
    previous_data_point = i == 0 ? data_points[0] : data_points[i-1]
    current_data_point = data_points[i]

    strategies_copy.each do |strat_name, strat_array|
      previous_gains = i == 0 ? 0 : strategy_results[strat_name][i - 1]
      puts "#{strat_name} Previous gains: #{previous_gains}"

      new_investment = strat_array[i]
      puts "#{strat_name} New investment: #{new_investment}"
      strategy_results[strat_name][i] = calculate_gain(previous_data_point, current_data_point, previous_gains, new_investment)
      puts "#{strat_name} Current gains #{strategy_results[strat_name][i]}\n\n"
    end
  end

  return strategy_results
end
