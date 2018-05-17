#!/usr/bin/env ruby
# Checks the difference between frontloading vs averaging

require_relative 'sp500-csv'

# TODO: Allow start date and end date to be read in from args
# For now just take the full range
$START_INDEX = 0;
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

# Keeps track of how well each strategy is performing each month
strategy_results = {
    :strategy_frontload => [0],
    :strategy_first_three_months => [0],
    :strategy_first_six_months => [0],
    :strategy_average => [0],
}

# Validate strategies are good
strategies.each do |strategy_name, strategy_array|
  raise "strategy #{strategy_name} does not add up to 1" unless strategy_array.reduce(:+) == 1
  raise "strategy #{strategy_name} does not add have 12 elements" unless strategy_array.size == $MONTHS_PER_YEAR
end

current_price = $SP500_MONTHLY_SLICE[0][:close]
current_month = 0
$SP500_MONTHLY_SLICE.each do |data_point|
  puts "\n\nNew Month: #{data_point[:date]}"
  puts "data point is #{data_point}"
  new_price = data_point[:close]
  puts "new price is #{new_price}"
  percent_change = new_price / current_price
  puts "percent change is #{percent_change}"

  strategies.each do |strategy_name, strategy_array|
    current_gains = strategy_results[strategy_name].last
    puts "#{strategy_name} current gains is #{current_gains}"
    strategy_current_month_gains = strategy_array[current_month]
    puts "#{strategy_name} current month gains is #{strategy_current_month_gains}"
    strategy_results[strategy_name].push((current_gains + strategy_current_month_gains) * percent_change)
    puts "#{strategy_name} current results are #{strategy_results[strategy_name]}"
  end

  current_price = new_price
  current_month = (current_month + 1) % $MONTHS_PER_YEAR
end

strategy_results.each do |strategy_name, strategy_results|
  puts "#{strategy_name} final gains: #{strategy_results.last}"
end
