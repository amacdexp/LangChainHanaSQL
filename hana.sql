DROP TABLE ZSDBILLGDOCITM;
CREATE TABLE ZSDBILLGDOCITM (  
  "BILLINGDOCUMENT" NVARCHAR(000010), 
  "BILLINGDOCUMENTITEM" NVARCHAR(000006), 
  "SOLDTOPARTY" NVARCHAR(000010), 
  "SOLDTOPARTYNAME" NVARCHAR(000080), 
  "SALESEMPLOYEE" NVARCHAR(000008), 
  "SALESEMPLOYEENAME" NVARCHAR(000080), 
  "COUNTRY" NVARCHAR(000003), 
  "REGION" NVARCHAR(000003), 
  "SALESORGANIZATION" NVARCHAR(000004), 
  "DISTRIBUTIONCHANNEL" NVARCHAR(000002), 
  "DIVISION" NVARCHAR(000002), 
  "PRODUCT" NVARCHAR(000040), 
  "PLANT" NVARCHAR(000004), 
  "PLANTNAME" NVARCHAR(000030), 
  "BILLINGQUANTITY" DECIMAL(000013,000003), 
  "BILLINGQUANTITYUNIT" NVARCHAR(000003), 
  "TRANSACTIONCURRENCY" NVARCHAR(000005), 
  "ITEMNETAMOUNTOFBILLINGDOC" DECIMAL(000015,000002), 
  "COMPANYCODE" NVARCHAR(000004), 
  "COMPANYCODENAME" NVARCHAR(000025), 
  "FISCALYEAR" NVARCHAR(000004), 
  "ACCOUNTINGDOCUMENT" NVARCHAR(000010), 
  "FISCALPERIOD" NVARCHAR(000003)
) ;




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
WITH sales_orgs AS (
  SELECT 'US01' AS sales_org, 'USD' AS currency, 'US' AS country , 0.35 as org_weight FROM DUMMY
  UNION ALL
  SELECT 'US02' AS sales_org, 'USD' AS currency, 'US' AS country, 0.10 as org_weight FROM DUMMY
  UNION ALL
  SELECT 'UK01' AS sales_org, 'GBP' AS currency, 'UK' AS country, 0.25 as org_weight FROM DUMMY
  UNION ALL
  SELECT 'AU01' AS sales_org, 'AUD' AS currency, 'AU' AS country, 0.30 as org_weight  FROM DUMMY
),
products AS (
  SELECT 'Apple' AS product FROM DUMMY UNION ALL
  SELECT 'Banana' AS product FROM DUMMY UNION ALL
  SELECT 'Orange' AS product FROM DUMMY UNION ALL
  SELECT 'Mango' AS product FROM DUMMY UNION ALL
  SELECT 'Grapes' AS product FROM DUMMY
),
employees AS (
  SELECT '00001' AS employee_id, 'Hamlet' AS employee_name FROM DUMMY UNION ALL
  SELECT '00002' AS employee_id, 'Romeo' AS employee_name FROM DUMMY UNION ALL
  SELECT '00003' AS employee_id, 'Juliet' AS employee_name FROM DUMMY UNION ALL
  SELECT '00004' AS employee_id, 'Othello' AS employee_name FROM DUMMY UNION ALL
  SELECT '00005' AS employee_id, 'Macbeth' AS employee_name FROM DUMMY UNION ALL
  SELECT '00006' AS employee_id, 'Desdemona' AS employee_name FROM DUMMY UNION ALL
  SELECT '00007' AS employee_id, 'Cordelia' AS employee_name FROM DUMMY UNION ALL
  SELECT '00008' AS employee_id, 'Prospero' AS employee_name FROM DUMMY UNION ALL
  SELECT '00009' AS employee_id, 'Viola' AS employee_name FROM DUMMY UNION ALL
  SELECT '00010' AS employee_id, 'Titania' AS employee_name FROM DUMMY
),
sold_to_parties AS (
    SELECT '8000' AS sold_to_party, 'Fruitopia Inc.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8001' AS sold_to_party, 'Tropical Treats Ltd.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8002' AS sold_to_party, 'Apple Haven Corp.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8003' AS sold_to_party, 'Citrus Delights Co.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8004' AS sold_to_party, 'Exotic Fruits Ltd.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8005' AS sold_to_party, 'Juicy Orchard Company' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8006' AS sold_to_party, 'Berry Bliss Enterprises' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8007' AS sold_to_party, 'Mango Magic Corp.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8008' AS sold_to_party, 'Tempting Fruit Co.' AS sold_to_party_name FROM DUMMY UNION ALL
    SELECT '8009' AS sold_to_party, 'Paradise Fruit Ltd.' AS sold_to_party_name FROM DUMMY
),
random_values AS (
  SELECT
    LPAD(CAST(FLOOR(RAND() * 1000000) + 10000000 AS VARCHAR(10)), 10, '0') AS billing_doc,
    LPAD(CAST(FLOOR(RAND() * 10) + 1 AS VARCHAR(6)), 6, '0') AS billing_doc_item,
    sales_org,
    country,
    sold_to_parties.sold_to_party AS sold_to_party,
    sold_to_parties.sold_to_party_name AS sold_to_party_name,
    employees.employee_id AS sales_employee,
    employees.employee_name AS sales_employee_name,
    CASE LEFT(sales_org, 2)
      WHEN 'US' THEN 'NA'
      WHEN 'UK' THEN 'EU'
      WHEN 'AU' THEN 'AP'
      ELSE ''
    END AS region,
    sales_org AS sales_organization,
    LPAD(CAST(FLOOR(RAND() * 100) AS VARCHAR(2)), 2, '0') AS distribution_channel,
    LPAD(CAST(FLOOR(RAND() * 100) AS VARCHAR(2)), 2, '0') AS division,
    product AS product,
    'PL' || LPAD(CAST(FLOOR(RAND() * 100) AS VARCHAR(2)), 2, '0') AS plant,
    'PlantName' || CAST(FLOOR(RAND() * 1000000) AS NVARCHAR(6)) AS plant_name,
    LPAD(CAST(FLOOR(RAND() * 1000000) / 1000 AS DECIMAL(13, 3)), 13, '0') AS billing_quantity,
    'KG' AS billing_quantity_unit,
    sales_orgs.currency AS transaction_currency,
    LPAD(CAST(FLOOR(RAND() * 1010000) / 100 AS DECIMAL(15, 2)), 15, '0') AS item_net_amount,
    sales_org AS company_code,
    'CompanyCodeName' || CAST(FLOOR(RAND() * 1000000) AS NVARCHAR(6)) AS company_code_name,
    '2023' AS fiscal_year,
    LPAD(CAST(FLOOR(RAND() * 101) + 20000000 AS VARCHAR(10)), 10, '0') AS accounting_document,
    LPAD(CAST(FLOOR(RAND() * 6) + 1 AS VARCHAR(3)), 3, '0') AS fiscal_period,
    sales_orgs.org_weight as org_weight,
    RAND() as org_random
  FROM sales_orgs, products, employees, sold_to_parties
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
