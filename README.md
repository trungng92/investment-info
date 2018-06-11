# Summary

This repository contains information about investments that I think is interesting.

For example:

- the effects of compounding interest (in finances)
- the benefits of investing in a 401k vs a Roth IRA vs a brokerage account
- investment agencies vs index funds
- the benefits of frontloading vs monthly contributions

## How do (progressive) tax calculations work?

Many people get confused by our tax system, and think that you pay a flat percentage of your current amount. This is _not_ how our tax system works.

Instead, we have something known as a "Progressive Tax System". In a Progressive Tax "[the tax rate increases as the taxable amount increases](https://en.wikipedia.org/wiki/Progressive_tax)"

So what does this mean? It means that your income is split up into different brackets, and each bracket is taxed at a different rate. This means that _no matter what_, by making more money, you _never_ pay more taxes. For example, if you made $50,000, and the tax brackets were set up as:

```
Tax % | Tax Bracket
0%    | $10,000
10%   | $20,000
20%   | $40,000
30%   | $70,000
```

You pay:
- 0% taxes on the first $10,000 for a total of $0 ($10,000 * 0%)
- 10% taxes on your income between the second bracket ($20,000 - $10000) for a total of $2,000 ($10,000 * 10%)
- 20% taxes on your income between the third bracket ($40,000 - $20000) for a total of $4,000 ($20,000 * 20%)
- 30% taxes on your income between the fourth bracket, making a note that your total income this year was $50,000, ($50,000 - $40,000) for a total of $3,000 ($10,000 * 30%)

So your total taxes would be $9,000 ($0 + $2,000 + $4,000 + $3,000). And your effective tax rate would be 18% ($9,000 / $50,000).

Some interesting notes: Our taxes are the lowest they've been for a very long time. In fact, till 1981, the top bracket actually used to pay 69.125% income tax, whereas the current top bracket is taxed at 37%. And the highest income tax percentage was [94%](https://en.wikipedia.org/wiki/Income_tax_in_the_United_States#Income_tax_rates_in_history) in 1944, during World War II.

## How much money does a 401k build up?

When calculating 401k returns, the important thing to consider is that the market grows 9% a year (which is 7% after taking inflation into account), so any money you invest now doubles in 10 years:

```
Growth rate: 1.07 ^ 10 == 1.96715135729
```

So if you put in $100 now, you will have $200 in 10 years, $400 in 20 years, etc. This may not seem like much, but as you constantly invest more money, your investment fund will snowball.

This is a spreadsheet that shows how much money a 401k account (and match contributions) + Roth IRA account accumulates over the course of 20 years.

https://docs.google.com/spreadsheets/d/1mKfSLlTqdjMJtUsIQ0nfiX3GbsWDKvJzDI9x6NPgUvM/edit#gid=0

A few noteworthy items:

- By maxing out your 401k and Roth IRA, you will have $1,000,000 in 17 years.
- Assuming you max your contributions, at 20 years, your investment returns will gain almost $100,000 a year on its own.

## What is the best way to invest your money?

I believe in the words of [Jack Bogle](https://en.wikipedia.org/wiki/John_C._Bogle).

Basically, don't invest in individual stocks/markets, invest in the market as a whole, and time in the market is more important than timing the market.

## Is it better to frontload your investments or average it out?

When investing in the market, the two generally suggested strategies are:

- averaging (which means if you're going to invest $12,000 a year, then you invest $1,000 a month and spread out your investment over the whole year)
- frontloading (which means if you're going to invest $12,000 a year, then you put all $12,000 in at the beginning of the year)

The [`investment-strategies`](investment-strategies/README.md) is a tool to test various investment strategies and see their theoretical gain.
