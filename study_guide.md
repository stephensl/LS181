# Study Guide

## Data and Databases Generally

Data is representative information pertaining to a particular entity, occurrence, or phenomenon. Data is used to model or describe something.

Data is useful, in that it provides information. This information may be utilized in any number of ways to achieve a more accurate understanding of the entity, occurrence, or phenomenon that the data pertains to.

The extent to which data is useful is tightly coupled with its reliability, which is whether or not the data can be trusted, and its structure, which is how the data is represented. Data that is unreliable is not useful, as any insight gained from the data may not provide an accurate representation. Additionally, data that is not structured in a way that can be accessed consistently and non-ambiguously is much less useful than data that is structured in a way that optimizes for querying, manipulation, and processing. 

Databases play an important role in ensuring that data is reliable, consistent, and structured in a way that supports utilization. Databases provide a container for storing structured data, allowing for clear and consistent access and manipulation. 

Relational databases are structured stores of data that model relationships between data held in multiple tables. Relational databases distribute data among multiple tables, and create connections between data through the use of primary and foreign keys. The Relational Model informs the rules and structures governing the relationships between data held in the database. 

Benefits of using relational databases include:
  - Reduction in data duplication: Normalization
    - data is distributed across multiple tables, and associations between data are established by reference.
    - reduces amount of data that needs to be stored
    - increases integrity of data as it is stored in one place
  - Data consistency
    - data stored in a relational database is structured in a way that reduces the likelihood of update anomalies as updates to data should occur in one place, rather than having to seek out all areas within a database that may reference the same data. 
  - Query flexibility
    - relational databases allow for data to be accessed in a flexible manner, as we can target specific data stored across multiple tables.
  - Organization and Modularity of data
    - relational databases allow for enhanced organization and modularity of data as we are able to avoid storing duplicate data and contributing to bloated tables. 
  - Scalability
    - organizing data in a relational database protects data integrity, consistency, and reliability as more data is added. 


How relational databases support data integrity:
  - Use of constraints surrounding what types of data can be stored, and how it should be formatted for storage. 
  - Use of primary keys to uniquely identify records.
  - Use of foreign keys to associate records with data stored in elsewhere in the database, and maintain referential integrity. 
  - Unique constraints that limit duplication of data and increase referential integrity by ensuring unique identifiers. 
  - Check constraints that ensure data meets particular standards for storage.
  - Cascading Actions that automatically perform some action based on a triggering event. For example, foreign keys may contain an `ON DELETE` clause which tells the database how to properly handle associated data if records in related tables are deleted. 


