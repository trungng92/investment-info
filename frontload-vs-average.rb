#!/usr/bin/env ruby
# Checks the difference between frontloading vs averaging

require_relative 'sp500-csv'

# TODO: Allow start date and end date to be read in from args
# For now just take the full range
$START_INDEX = 0
$END_INDEX = $SP500_MONTHLY.size

$SP500_MONTHLY_SLICE=$SP500_MONTHLY[$START_INDEX..$END_INDEX]
$MONTHS_PER_YEAR = 12

# frontloading strategy
# Determines how you allocate your annual investments
# Each array must add up to 1, and must have 12 elements
strategies = {
  :strategy_frontload => [Rational(1)] + [0] * 11,
  :strategy_first_three_months => [Rational(1, 3)] * 3 + [0] * 9,
  :strategy_first_six_months => [Rational(1, 6)] * 6 + [0] * 6,
  :strategy_average => [Rational(1, 12)] * 12,
}

# Validate strategies
strategies.each do |strategy_name, strategy_array|
  raise "strategy #{strategy_name} does not add up to 1" unless strategy_array.reduce(:+) == 1
  raise "strategy #{strategy_name} does not add have 12 elements" unless strategy_array.size == $MONTHS_PER_YEAR
end

# Calculates the gain of each strategy over the given data points
def calculate_strategy(data_points, strategies)
  # Make sure that strategies_copy is _at least_ as long as data_points and iterate through all items at the same time
  strategies_size_increase = (data_points.size.to_f / $MONTHS_PER_YEAR).ceil
  strategies_copy = strategies.clone
  strategies_copy.each { |k, v| strategies_copy[k] = v * strategies_size_increase }

  # Keeps track of how well each strategy is performing each month
  strategy_results = {
      :strategy_frontload => [0],
      :strategy_first_three_months => [0],
      :strategy_first_six_months => [0],
      :strategy_average => [0],
  }

  data_points.each_index do |i|
    date = data_points[i][:date]
    puts "Date: #{date}"
    old_close = i == 0 ? data_points[0][:close] : data_points[i-1][:close]
    close = data_points[i][:close]
    change_ratio = close / old_close
    puts "Close: #{old_close} -> #{close}; Ratio #{change_ratio}\n\n"

    strategies_copy.each do |strat_name, strat_array|
      previous_gains = i == 0 ? 0 : strategy_results[strat_name][i - 1]
      puts "#{strat_name} Previous gains: #{previous_gains}"
      puts "#{strat_name} New gains: #{strat_array[i]}"
      strategy_results[strat_name][i] = (previous_gains + strat_array[i]) * change_ratio
      puts "#{strat_name} Current gains #{strategy_results[strat_name][i]}\n\n"
    end

    puts "\n\n"
  end

  return strategy_results
end

calculate_strategy($SP500_MONTHLY_SLICE, strategies)
