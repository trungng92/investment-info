#!/usr/bin/env ruby
# Checks the difference between frontloading vs averaging

require_relative 'sp500-csv'

# TODO: Allow start date and end date to be read in from args
# For now just take the full range
$START_INDEX = 0
$END_INDEX = $SP500_MONTHLY.size

$SP500_MONTHLY_SLICE=$SP500_MONTHLY[$START_INDEX..$END_INDEX]

# Determines how you allocate your annual investments
# Each array must add up to 1, and must have 12 elements
strategies = {
  :strategy_frontload => [Rational(1)] + [0] * 11,
  :strategy_first_three_months => [Rational(1, 3)] * 3 + [0] * 9,
  :strategy_first_six_months => [Rational(1, 6)] * 6 + [0] * 6,
  :strategy_average => [Rational(1, 12)] * 12,
}

# calculate_gains_strategy($SP500_MONTHLY_SLICE, strategies[:strategy_frontload])
calculate_gains_strategies($SP500_MONTHLY_SLICE, strategies)
