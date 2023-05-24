DROP TABLE IF EXISTS ZSDBILLGDOCITM;

CREATE TABLE ZSDBILLGDOCITM (
  "BILLINGDOCUMENT" TEXT,
  "BILLINGDOCUMENTITEM" TEXT,
  "SALESORGANIZATION" TEXT,
  "SOLDTOPARTY" TEXT,
  "SOLDTOPARTYNAME" TEXT,
  "SALESEMPLOYEE" TEXT,
  "SALESEMPLOYEENAME" TEXT,
  "COUNTRY" TEXT,
  "REGION" TEXT,
  "DISTRIBUTIONCHANNEL" TEXT,
  "DIVISION" TEXT,
  "PRODUCT" TEXT,
  "PLANT" TEXT,
  "PLANTNAME" TEXT,
  "BILLINGQUANTITY" TEXT,
  "BILLINGQUANTITYUNIT" TEXT,
  "TRANSACTIONCURRENCY" TEXT,
  "ITEMNETAMOUNTOFBILLINGDOC" TEXT,
  "COMPANYCODE" TEXT,
  "COMPANYCODENAME" TEXT,
  "FISCALYEAR" TEXT,
  "ACCOUNTINGDOCUMENT" TEXT,
  "FISCALPERIOD" TEXT
);

WITH sales_orgs AS (
  SELECT 'US01' AS sales_org, 'USD' AS currency, 'US' AS country , 0.35 as org_weight
  UNION ALL
  SELECT 'US02' AS sales_org, 'USD' AS currency, 'US' AS country, 0.10 as org_weight
  UNION ALL
  SELECT 'UK01' AS sales_org, 'GBP' AS currency, 'UK' AS country, 0.25 as org_weight
  UNION ALL
  SELECT 'AU01' AS sales_org, 'AUD' AS currency, 'AU' AS country, 0.30 as org_weight
),
products AS (
  SELECT 'Apple' AS product
  UNION ALL
  SELECT 'Banana' AS product
  UNION ALL
  SELECT 'Orange' AS product
  UNION ALL
  SELECT 'Mango' AS product
  UNION ALL
  SELECT 'Grapes' AS product
),
employees AS (
  SELECT '00001' AS employee_id, 'Hamlet' AS employee_name
  UNION ALL
  SELECT '00002' AS employee_id, 'Romeo' AS employee_name
  UNION ALL
  SELECT '00003' AS employee_id, 'Juliet' AS employee_name
  UNION ALL
  SELECT '00004' AS employee_id, 'Othello' AS employee_name
  UNION ALL
  SELECT '00005' AS employee_id, 'Macbeth' AS employee_name
  UNION ALL
  SELECT '00006' AS employee_id, 'Desdemona' AS employee_name
  UNION ALL
  SELECT '00007' AS employee_id, 'Cordelia' AS employee_name
  UNION ALL
  SELECT '00008' AS employee_id, 'Prospero' AS employee_name
  UNION ALL
  SELECT '00009' AS employee_id, 'Viola' AS employee_name
  UNION ALL
  SELECT '00010' AS employee_id, 'Titania' AS employee_name
),
sold_to_parties AS (
  SELECT '8000' AS sold_to_party, 'Fruitopia Inc.' AS sold_to_party_name
  UNION ALL
  SELECT '8001' AS sold_to_party, 'Tropical Treats Ltd.' AS sold_to_party_name
  UNION ALL
  SELECT '8002' AS sold_to_party, 'Apple Haven Corp.' AS sold_to_party_name
  UNION ALL
  SELECT '8003' AS sold_to_party, 'Citrus Delights Co.' AS sold_to_party_name
  UNION ALL
  SELECT '8004' AS sold_to_party, 'Exotic Fruits Ltd.' AS sold_to_party_name
  UNION ALL
  SELECT '8005' AS sold_to_party, 'Juicy Orchard Company' AS sold_to_party_name
  UNION ALL
  SELECT '8006' AS sold_to_party, 'Berry Bliss Enterprises' AS sold_to_party_name
  UNION ALL
  SELECT '8007' AS sold_to_party, 'Mango Magic Corp.' AS sold_to_party_name
  UNION ALL
  SELECT '8008' AS sold_to_party, 'Tempting Fruit Co.' AS sold_to_party_name
  UNION ALL
  SELECT '8009' AS sold_to_party, 'Paradise Fruit Ltd.' AS sold_to_party_name
),
random_values AS (
SELECT
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) + 10000000 AS INTEGER))
    WHEN 10 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) + 10000000 AS INTEGER)
    ELSE SUBSTR('0000000000', 1, 10 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) + 10000000 AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) + 10000000 AS INTEGER)
  END AS billing_doc,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 10) + 1 AS INTEGER))
    WHEN 6 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 10) + 1 AS INTEGER)
    ELSE SUBSTR('000000', 1, 6 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 10) + 1 AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 10) + 1 AS INTEGER)
  END AS billing_doc_item,
  sales_org,
  country,
  sold_to_parties.sold_to_party AS sold_to_party,
  sold_to_parties.sold_to_party_name AS sold_to_party_name,
  employees.employee_id AS sales_employee,
  employees.employee_name AS sales_employee_name,
  CASE SUBSTR(sales_org, 1, 2)
    WHEN 'US' THEN 'NA'
    WHEN 'UK' THEN 'EU'
    WHEN 'AU' THEN 'AP'
    ELSE ''
  END AS region,
  sales_org AS sales_organization,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER))
    WHEN 2 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER)
    ELSE SUBSTR('00', 1, 2 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER)
  END AS distribution_channel,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER))
    WHEN 2 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER)
    ELSE SUBSTR('00', 1, 2 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER)
  END AS division,
  product AS product,
  'PL' || CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER))
    WHEN 2 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER)
    ELSE SUBSTR('00', 1, 2 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 100) AS INTEGER)
  END AS plant,
  'PlantName' || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) AS INTEGER) AS plant_name,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) / 1000 AS INTEGER))
    WHEN 13 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) / 1000 AS INTEGER)
    ELSE SUBSTR('0000000000000', 1, 13 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) / 1000 AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) / 1000 AS INTEGER)
  END AS billing_quantity,
  'KG' AS billing_quantity_unit,
  sales_orgs.currency AS transaction_currency,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1010000) / 100 AS INTEGER))
    WHEN 15 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1010000) / 100 AS INTEGER)
    ELSE SUBSTR('000000000000000', 1, 15 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1010000) / 100 AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1010000) / 100 AS INTEGER)
  END AS item_net_amount,
  sales_org AS company_code,
  'CompanyCodeName' || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 1000000) AS INTEGER) AS company_code_name,
  '2023' AS fiscal_year,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 101) + 20000000 AS INTEGER))
    WHEN 10 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 101) + 20000000 AS INTEGER)
    ELSE SUBSTR('0000000000', 1, 10 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 101) + 20000000 AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 101) + 20000000 AS INTEGER)
  END AS accounting_document,
  CASE LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 6) + 1 AS INTEGER))
    WHEN 3 THEN CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 6) + 1 AS INTEGER)
    ELSE SUBSTR('000', 1, 3 - LENGTH(CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 6) + 1 AS INTEGER))) || CAST(ROUND((ABS(RANDOM()) % 1000000 / 1000000.0) * 6) + 1 AS INTEGER)
  END AS fiscal_period,
  org_weight,
  RANDOM() as org_random
FROM sales_orgs, products, employees, sold_to_parties
)

INSERT INTO ZSDBILLGDOCITM (
  "BILLINGDOCUMENT",
  "BILLINGDOCUMENTITEM",
  "SALESORGANIZATION",
  "SOLDTOPARTY",
  "SOLDTOPARTYNAME",
  "SALESEMPLOYEE",
  "SALESEMPLOYEENAME",
  "COUNTRY",
  "REGION",
  "DISTRIBUTIONCHANNEL",
  "DIVISION",
  "PRODUCT",
  "PLANT",
  "PLANTNAME",
  "BILLINGQUANTITY",
  "BILLINGQUANTITYUNIT",
  "TRANSACTIONCURRENCY",
  "ITEMNETAMOUNTOFBILLINGDOC",
  "COMPANYCODE",
  "COMPANYCODENAME",
  "FISCALYEAR",
  "ACCOUNTINGDOCUMENT",
  "FISCALPERIOD"
)
SELECT
  billing_doc,
  billing_doc_item,
  sales_org,
  sold_to_party,
  sold_to_party_name,
  sales_employee,
  sales_employee_name,
  country,
  region,
  distribution_channel,
  division,
  product,
  plant,
  plant_name,
  billing_quantity,
  billing_quantity_unit,
  transaction_currency,
  item_net_amount,
  company_code,
  company_code_name,
  fiscal_year,
  accounting_document,
  fiscal_period
FROM random_values 
WHERE org_random <= org_weight;
