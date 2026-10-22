
-- =====================================================
-- Project: Marketing Campaign ROI Analysis
-- Database: MySQL
-- Dataset: Simulated marketing campaign data
-- =====================================================

-- 1. Select the project database
USE marketing_roi;

-- 2. View all campaign records
SELECT *
FROM marketing_campaign_roi;

-- 3. Count total campaign records
SELECT COUNT(*) AS Total_Rows
FROM marketing_campaign_roi;

-- 4. Calculate ROI and net return by marketing channel
SELECT
    Channel,
    SUM(Spend_INR) AS Total_Spend,
    SUM(Revenue_INR) AS Total_Revenue,
    SUM(Revenue_INR) - SUM(Spend_INR) AS Net_Return,
    ROUND(
        (SUM(Revenue_INR) - SUM(Spend_INR))
        / NULLIF(SUM(Spend_INR), 0) * 100,
        2
    ) AS ROI_Percent
FROM marketing_campaign_roi
GROUP BY Channel
ORDER BY ROI_Percent DESC;

-- 5. Calculate conversion rate by channel
SELECT
    Channel,
    SUM(Clicks) AS Total_Clicks,
    SUM(Conversions) AS Total_Conversions,
    ROUND(
        SUM(Conversions) / NULLIF(SUM(Clicks), 0) * 100,
        2
    ) AS Conversion_Rate_Percent
FROM marketing_campaign_roi
GROUP BY Channel
ORDER BY Conversion_Rate_Percent DESC;

-- 6. Calculate cost per conversion by channel
SELECT
    Channel,
    SUM(Spend_INR) AS Total_Spend,
    SUM(Conversions) AS Total_Conversions,
    ROUND(
        SUM(Spend_INR) / NULLIF(SUM(Conversions), 0),
        2
    ) AS Cost_Per_Conversion_INR
FROM marketing_campaign_roi
GROUP BY Channel
ORDER BY Cost_Per_Conversion_INR ASC;

-- 7. Rank campaigns by ROI
SELECT
    Campaign,
    Channel,
    Spend_INR,
    Revenue_INR,
    Revenue_INR - Spend_INR AS Net_Return,
    ROUND(
        (Revenue_INR - Spend_INR)
        / NULLIF(Spend_INR, 0) * 100,
        2
    ) AS ROI_Percent
FROM marketing_campaign_roi
ORDER BY ROI_Percent DESC;

-- 8. Identify the highest-revenue campaign
SELECT
    Campaign,
    Channel,
    Revenue_INR
FROM marketing_campaign_roi
ORDER BY Revenue_INR DESC
LIMIT 1;
