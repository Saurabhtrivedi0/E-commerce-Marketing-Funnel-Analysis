# E-commerce Marketing Funnel Analysis

## Project Overview

This project analyzes an e-commerce marketing funnel using SQL to identify customer drop-off points, evaluate traffic source performance, and measure revenue efficiency across acquisition channels.

The analysis focuses on understanding:
- Funnel conversion performance
- Customer behavior throughout the purchase journey
- Traffic source effectiveness
- Revenue contribution by channel
- Average order value and acquisition efficiency

The project workflow included:
1. Basic data cleaning and formatting in Excel
2. Exporting data into a SQL database using CMD
3. Performing funnel and revenue analysis using SQL
4. Creating supporting visuals in Power BI

---

# Executive Summary

- Overall funnel conversion rate was **16.6%**
- Checkout stages performed efficiently with **80%+ conversion rates**
- The largest drop-off occurred between **product views and cart additions**
- Email marketing generated the **highest conversion rate (34%)**
- Social media delivered high traffic volume but weak purchasing intent

---

# Key Business Insights

## 1. Checkout Process Performs Efficiently

The checkout-to-purchase stages maintained strong conversion rates above 80%, suggesting that users who reach the checkout stage experience minimal friction during the payment process.

This indicates that the current checkout flow is functioning effectively and does not require major redesigns at this stage.

---

## 2. Product View to Cart Conversion Is Relatively Low

The conversion rate from product views to cart additions was only 31%, representing the largest drop-off point in the funnel.

Potential contributing factors may include:
- Product pricing
- Weak product descriptions or visuals
- Friction in the add-to-cart experience
- Poor call-to-action placement
- Lack of trust signals

Further investigation through A/B testing or behavioral analysis could help identify the primary causes behind user drop-offs.

---

## 3. Social Media Traffic Converts Poorly

Social media contributed approximately 30% of total traffic but recorded the lowest conversion rate at only 7%.

Although social campaigns successfully generated traffic volume, the low conversion performance suggests weaker purchasing intent and lower-quality traffic compared to other acquisition channels.

Potential improvements include:
- Improving audience targeting
- Increasing retargeting efforts
- Optimizing landing pages
- Prioritizing lead generation campaigns

---

## 4. Email Marketing Generates the Highest Conversion Rate

Email traffic demonstrated the strongest performance among all acquisition channels, with a conversion rate of 34%.

This suggests that email audiences are more engaged and purchase-ready compared to users acquired through other traffic sources.

Scaling high-performing email campaigns may help improve overall revenue generation.

---

## 5. Average Order Value Supports CAC Benchmarking

The average order value (AOV) was approximately \$115.

This provides a useful benchmark for evaluating customer acquisition cost (CAC) efficiency across marketing channels.

Social media campaigns should be monitored carefully if CAC exceeds approximately \$30–40 while maintaining low conversion performance, as this may reduce overall profitability.

---

# SQL Concepts Used

- Common Table Expressions (CTEs)
- Aggregate Functions
- Conditional Aggregation
- Window Functions
- `LAG()` Function
- CASE Statements
- Conversion Funnel Analysis
- Revenue Analysis
- KPI Calculations
- Time-to-Conversion Analysis

---

# Tools Used

- Excel
- MySQL
- Power BI
- CMD

---

# Sample Analyses Performed

## Funnel Conversion Analysis
- View-to-cart conversion
- Cart-to-checkout conversion
- Checkout-to-purchase conversion

## Traffic Source Analysis
- Conversion rate by acquisition channel
- Revenue contribution by traffic source
- Revenue per visitor analysis

## Time-to-Conversion Analysis
- Average time between funnel stages
- Overall purchase completion time

## Revenue Analysis
- Average order value (AOV)
- Revenue per visitor
- Revenue per customer

---


# Conclusion

This project demonstrates how SQL can be used to perform business-oriented marketing funnel analysis by combining customer behavior, conversion performance, and revenue metrics.

The findings highlight:
- Strong checkout performance
- Significant drop-offs during early purchase stages
- High-performing email traffic
- Inefficient social media conversion performance

The analysis provides actionable business recommendations that could help improve conversion efficiency and overall marketing ROI.
