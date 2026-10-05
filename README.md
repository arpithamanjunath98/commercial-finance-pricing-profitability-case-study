# Commercial Finance — Pricing, Margin & Customer Profitability

## Project overview

Independent Commercial Finance portfolio case study for **Lumina Baby & Family Care Ltd**, a fictional UK FMCG company.

The project uses **2,000 synthetic transaction lines**, **90 customers**, **48 SKUs**, six sales channels and six product categories across **Jan-2025 to Sep-2026**.

The goal is to move beyond revenue reporting and evaluate the commercial economics behind pricing, discounting, customer profitability, promotions and portfolio mix.

## What I built

- Star-schema dataset with Date, Customer and Product dimensions plus Fact Sales
- SQLite database and reusable SQL analysis queries
- Transaction-level gross-sales-to-contribution-profit economics
- Customer profitability and customer-quadrant analysis
- Discount leakage and pricing-governance diagnostics
- Pricing / margin waterfall
- Customer concentration and Pareto analysis
- Promotion-effectiveness ROI proxy
- SKU rationalisation framework
- Jan–Sep 2025 vs Jan–Sep 2026 Price–Volume–Mix bridge
- Conservative / Base / Stretch repricing scenarios
- Customer action register with owners, timing and status
- Automated Commercial Finance commentary
- Executive Commercial Finance management pack
- Power BI-ready star-schema, DAX measure library and report-page specification

## Selected findings

- Net revenue: **~£632.8k**
- Contribution profit: **~£231.1k**
- Contribution margin: **~36.5%**
- Gross modelled discount leakage: **~£5.5k**
- Original potential-recapture screen: **~£3.9k**
- Base risk-adjusted top-20 repricing scenario: **~£1.8k contribution uplift**
- Top-10 customer revenue share: **~36.2%**
- Jan–Sep revenue change: **~+£17.5k**
  - Volume: **~+£8.3k**
  - Mix: **~−£2.2k**
  - Price: **~+£11.4k**
- 4 of 6 categories show negative observational promotion ROI proxies
- 13 SKUs: **Reprice / Cost Action**
- 11 SKUs: **Rationalise / Review**

## Important modelling caveats

All entities and financial data are synthetic.

Promotion ROI is an **observational proxy**, not causal evidence. A real business would require a stronger counterfactual or experiment before claiming incremental promotional impact.

Pricing leakage and repricing outputs are **modelled scenarios**, not realised savings. The repricing model explicitly balances discount recovery against assumed volume retention.

## Tools

- **Microsoft Excel** — implemented
- **SQL / SQLite** — implemented
- **Power BI / DAX** — star schema, DAX measures and report specification prepared; **no PBIX file is claimed**
