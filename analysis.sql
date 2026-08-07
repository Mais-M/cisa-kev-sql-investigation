-- CISA KEV SQL Investigation
-- Dataset: CISA Known Exploited Vulnerabilities (KEV)
-- Assumption: the dataset has already been loaded into a table named `kev`.

-- 1. Top 10 vendors by number of known exploited vulnerabilities
SELECT
    vendorProject,
    COUNT(*) AS vulnerability_count
FROM kev
GROUP BY vendorProject
ORDER BY vulnerability_count DESC
LIMIT 10;


-- 2. Top 10 products by number of known exploited vulnerabilities
SELECT
    product,
    COUNT(*) AS vulnerability_count
FROM kev
GROUP BY product
ORDER BY vulnerability_count DESC
LIMIT 10;


-- 3. Known vs. unknown ransomware campaign use
SELECT
    knownRansomwareCampaignUse,
    COUNT(*) AS vulnerability_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM kev),
        1
    ) AS percentage
FROM kev
GROUP BY knownRansomwareCampaignUse
ORDER BY vulnerability_count DESC;


-- 4. Top 10 vendors among vulnerabilities associated with known ransomware campaigns
SELECT
    vendorProject,
    COUNT(*) AS ransomware_related_vulnerabilities
FROM kev
WHERE knownRansomwareCampaignUse = 'Known'
GROUP BY vendorProject
ORDER BY ransomware_related_vulnerabilities DESC
LIMIT 10;


-- 5. Number of vulnerabilities added to the CISA KEV catalog by year
-- Note: dateAdded is the date CISA added the vulnerability to the KEV catalog,
-- not necessarily the date exploitation first occurred.
SELECT
    YEAR(CAST(dateAdded AS DATE)) AS year,
    COUNT(*) AS vulnerabilities_added
FROM kev
GROUP BY year
ORDER BY year;
