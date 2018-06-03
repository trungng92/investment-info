# Summary

`investment-strategies` is a tool that calculate the differences between different investment strategies (e.g. `frontloading` vs `averaging`) over periods of time.

The general thought is that `averaging` is good because it provides more "stability" in terms of market gains and losses.

On the other hand, `frontloading` is good because "time in the market" beats all.

# Using the `runner`

You can use the runner by simply calling:

```bash
./runner.rb

# for help
./runner.rb --help
```

By default, the runner will calculate the different investment strategies (from `strategies-monthly.csv`) over all the data points (from `sp500-monthly.csv`).

There are also flags that let you specify the file to read the strategies and data points from and the starting and ending index of the data points file.

```
Usage: runner.rb [options]
    -s, --start [INDEX]              start index of csv file
    -e, --end [INDEX]                end index
    -c, --csv-file [FILE]            csv file to read data points from
    -t, --strategy-file [FILE]       file to read strategies from
    -h, --help                       Prints this help
```

# Example runs

By default we have 5 strategies:

- `frontload`: invest everything at the beginning of every year
- `first-three-months`: invest everything over the course of the first three months
- `first-six-months`: invest everything over the course of the first six months
- `last-six-months`: invest everything over the course of the last six months
    - (this is mostly to show that investing in the first half of the year is not a fluke)
- `average`: invest everything over the course of the whole year

```
Found strategy 'frontload' with values '[(1/1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]'
Found strategy 'first-three-months' with values '[(1/3), (1/3), (1/3), 0, 0, 0, 0, 0, 0, 0, 0, 0]'
Found strategy 'first-six-months' with values '[(1/6), (1/6), (1/6), (1/6), (1/6), (1/6), 0, 0, 0, 0, 0, 0]'
Found strategy 'last-six-months' with values '[0, 0, 0, 0, 0, 0, (1/6), (1/6), (1/6), (1/6), (1/6), (1/6)]'
Found strategy 'average' with values '[(1/12), (1/12), (1/12), (1/12), (1/12), (1/12), (1/12), (1/12), (1/12), (1/12), (1/12), (1/12)]'
--------------------------------------------------
Date: 1/1/50
Close: 17.049999 -> 17.049999; Ratio 1.0

'frontload' previous gains: 0
'frontload' new investment: 1/1
'frontload' current gains 1.0

'first-three-months' previous gains: 0
'first-three-months' new investment: 1/3
'first-three-months' current gains 0.3333333333333333

'first-six-months' previous gains: 0
'first-six-months' new investment: 1/6
'first-six-months' current gains 0.16666666666666666

'last-six-months' previous gains: 0
'last-six-months' new investment: 0
'last-six-months' current gains 0.0

'average' previous gains: 0
'average' new investment: 1/12
'average' current gains 0.08333333333333333


--------------------------------------------------
Date: 2/1/50
Close: 17.049999 -> 17.219999; Ratio 1.009970675071594

'frontload' previous gains: 1.0
'frontload' new investment: 0
'frontload' current gains 1.009970675071594

'first-three-months' previous gains: 0.3333333333333333
'first-three-months' new investment: 1/3
'first-three-months' current gains 0.6733137833810626

'first-six-months' previous gains: 0.16666666666666666
'first-six-months' new investment: 1/6
'first-six-months' current gains 0.3366568916905313

'last-six-months' previous gains: 0.0
'last-six-months' new investment: 0
'last-six-months' current gains 0.0

'average' previous gains: 0.08333333333333333
'average' new investment: 1/12
'average' current gains 0.16832844584526566

...

--------------------------------------------------
Date: 12/1/17
Close: 2647.580078 -> 2673.610107; Ratio 1.009831630482604

'frontload' previous gains: 1784.4601644256866
'frontload' new investment: 0
'frontload' current gains 1802.0043173732467

'first-three-months' previous gains: 1770.269986432938
'first-three-months' new investment: 0
'first-three-months' current gains 1787.6746267939911

'first-six-months' previous gains: 1750.655668969058
'first-six-months' new investment: 0
'first-six-months' current gains 1767.8674686086379

'last-six-months' previous gains: 1696.2319037822083
'last-six-months' new investment: 1/6
'last-six-months' current gains 1713.0769343447462

'average' previous gains: 1723.443786375657
'average' new investment: 1/12
'average' current gains 1740.472201476716
```

From these results, we can see over the course of ~68 years, frontloading (and other frontloading algorithms) have a clear (but small) gain, and backloading had a clear loss.

We can calculate the percent gain of each strategy over the `average` strategy with  `(strategy1 - strategy2) / strategy2`

`frontload`: 3.53536907% (`(1802.0043173732467 - 1740.472201476716) / 1740.472201476716`)

`first-three-months`: 2.712047068% (`(1787.6746267939911 - 1740.472201476716) / 1740.472201476716`)

`first-six-months`: 1.574013483% (`(1767.8674686086379 - 1740.472201476716) / 1740.472201476716`)

`last-six-months`: -1.574013483% (`(1713.0769343447462 - 1740.472201476716) / 1740.472201476716`)

Frontloading gives us a 3.53% increase over the course of 68 years. This may not seem useful and it may not seem like a lot, but there are a few things to consider.

1. Although it may appear that people don't invest for long periods of time, many people actually do (in the form of `401k`s). Many people will have money in their `401k`s for upwards of 20-40 years.
1. If you have $1,000,000 saved up (which will happen just by maxing out your 401k for 23 years (and this does _not_ include any matching)), 3.53% is $35,300, which is _not_ insignificant.
1. People rarely ever take out their whole investment at one time, so this extra 3.53% growth will continue growing.

# Conclusion

From a purely numbers point of view, frontloading (and similar frontloading algorithms) is better overall than averaging your investments. If you can afford it, then it's better to frontload.

One thing to keep in mind is that by frontloading, your income will be irregular. You're take home income will be lower at the beginning of the year, but higher at the end (which can be annoying when trying to budget).