#!/usr/bin/env ruby
# Checks the difference between frontloading vs averaging

require_relative 'sp500-csv'

# TODO: Allow start date and end date to be read in from args
# For now just take the full range
$START_INDEX = 0;
$END_INDEX = $SP500_MONTHLY.size

$SP500_MONTHLY_SLICE=$SP500_MONTHLY[$START_INDEX..$END_INDEX]

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
    :strategy_frontload => [],
    :strategy_first_three_months => [],
    :strategy_first_six_months => [],
    :strategy_average => [],
}

# Validate strategies are good
strategies.each do |strategy_name, strategy_array|
  raise "strategy #{strategy_name} does not add up to 1" unless strategy_array.reduce(:+) == 1
  raise "strategy #{strategy_name} does not add have 12 elements" unless strategy_array.size == 12
end