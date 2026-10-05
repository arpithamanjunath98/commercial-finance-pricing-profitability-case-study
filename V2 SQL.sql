-- Project 2 V2 — Commercial Finance Decision Layer
-- SQLite | all data synthetic

-- 1) Customer discount leakage base metrics
WITH customer_base AS (
    SELECT
        c.Customer_ID,c.Customer_Name,c.Channel,c.Tier,
        SUM(f.Gross_Sales) AS Gross_Sales,
        SUM(f.Discount_Value) AS Discount_Value,
        SUM(f.Discount_Value)/SUM(f.Gross_Sales) AS Discount_Rate,
        SUM(f.Net_Revenue) AS Net_Revenue,
        SUM(f.Contribution_Profit) AS Contribution_Profit,
        SUM(f.Contribution_Profit)/SUM(f.Net_Revenue) AS Contribution_Margin,
        SUM(CASE WHEN f.Promo_Flag='Promo' THEN f.Gross_Sales ELSE 0 END)/SUM(f.Gross_Sales) AS Promo_Gross_Share
    FROM fact_sales f
    JOIN dim_customer c ON f.Customer_ID=c.Customer_ID
    GROUP BY c.Customer_ID,c.Customer_Name,c.Channel,c.Tier
)
SELECT * FROM customer_base
ORDER BY Discount_Rate DESC;

-- 2) Customer profitability matrix
SELECT
    c.Customer_ID,c.Customer_Name,c.Channel,c.Tier,
    ROUND(SUM(f.Net_Revenue),2) AS Net_Revenue,
    ROUND(SUM(f.Contribution_Profit),2) AS Contribution_Profit,
    ROUND(SUM(f.Contribution_Profit)/SUM(f.Net_Revenue),4) AS Contribution_Margin,
    ROUND(SUM(f.Discount_Value)/SUM(f.Gross_Sales),4) AS Discount_Rate
FROM fact_sales f
JOIN dim_customer c ON f.Customer_ID=c.Customer_ID
GROUP BY c.Customer_ID,c.Customer_Name,c.Channel,c.Tier
ORDER BY Net_Revenue DESC;

-- 3) Pricing waterfall
SELECT
    SUM(Gross_Sales) AS Gross_Sales,
    SUM(Discount_Value) AS Discount_Value,
    SUM(Net_Revenue) AS Net_Revenue,
    SUM(COGS) AS COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Freight) AS Freight,
    SUM(Promo_Spend) AS Promo_Spend,
    SUM(Contribution_Profit) AS Contribution_Profit
FROM fact_sales;

-- 4) Promo effectiveness input by category / promo flag
SELECT
    p.Category,f.Promo_Flag,
    COUNT(*) AS Transactions,
    SUM(f.Units) AS Units,
    SUM(f.Net_Revenue) AS Net_Revenue,
    SUM(f.Promo_Spend) AS Promo_Spend,
    SUM(f.Contribution_Profit) AS Contribution_Profit
FROM fact_sales f
JOIN dim_product p ON f.Product_ID=p.Product_ID
GROUP BY p.Category,f.Promo_Flag
ORDER BY p.Category,f.Promo_Flag;

-- 5) Customer concentration / Pareto
WITH customer_revenue AS (
    SELECT
        c.Customer_ID,c.Customer_Name,c.Channel,
        SUM(f.Net_Revenue) AS Net_Revenue,
        SUM(f.Contribution_Profit) AS Contribution_Profit
    FROM fact_sales f
    JOIN dim_customer c ON f.Customer_ID=c.Customer_ID
    GROUP BY c.Customer_ID,c.Customer_Name,c.Channel
)
SELECT *
FROM customer_revenue
ORDER BY Net_Revenue DESC;

-- 6) SKU rationalisation source
SELECT
    p.Product_ID,p.SKU_Name,p.Brand,p.Category,
    SUM(f.Net_Revenue) AS Net_Revenue,
    SUM(f.Units) AS Units,
    SUM(f.Net_Revenue)/SUM(f.Units) AS ASP,
    SUM(f.Gross_Profit) AS Gross_Profit,
    SUM(f.Gross_Profit)/SUM(f.Net_Revenue) AS GP_Margin,
    SUM(f.Promo_Spend) AS Promo_Spend,
    SUM(f.Contribution_Profit) AS Contribution_Profit,
    SUM(f.Contribution_Profit)/SUM(f.Net_Revenue) AS Contribution_Margin
FROM fact_sales f
JOIN dim_product p ON f.Product_ID=p.Product_ID
GROUP BY p.Product_ID,p.SKU_Name,p.Brand,p.Category
ORDER BY Net_Revenue DESC;

-- 7) Jan–Sep PVM source: like-for-like 2025 vs 2026
SELECT
    CAST(strftime('%Y',f.Date) AS INTEGER) AS Year,
    p.Category,
    SUM(f.Units) AS Units,
    SUM(f.Net_Revenue) AS Revenue,
    SUM(f.Net_Revenue)/SUM(f.Units) AS ASP
FROM fact_sales f
JOIN dim_product p ON f.Product_ID=p.Product_ID
WHERE CAST(strftime('%m',f.Date) AS INTEGER) <= 9
GROUP BY Year,p.Category
ORDER BY p.Category,Year;
