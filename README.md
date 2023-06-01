# LangChainHanaSQL
Example using LangChain OpenAI and Hana to convert text to SQL

## Related blogs 

[Data Wizardry – Unleashing Live Insights with OpenAI, LangChain & SAP HANA](https://blogs.sap.com/2023/05/31/data-wizardry-unleashing-live-insights-with-openai-langchain-sap-hana/)

[Under the Hood – Text to SQL with LangChain, LLM's and Hana](https://blogs.sap.com/?p=1772464) 


## Setup 
The example requires a table to be created in a DB. e.g. Hana or Sqlite

I created a custom table mimicing a subset of the related S4 CDS View 
[I_BillingDocumentItemCube](https://help.sap.com/docs/SAP_S4HANA_CLOUD/0f69f8fb28ac4bf48d2b57b9637e81fa/ab6bdf55562d1d22e10000000a44147b.html) 

The following files contains the CREATE TABLE  and INSERT   to ppopulate some fictitious data.

For sqlite setup SQL see [sqlite.sql](sqlite.sql) 

For Hana setup SQL see [hana.sql](hana.sql) 
