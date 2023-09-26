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


Normalization
    The reason for normalization is to reduce data redundancy and improve data integrity
    The mechanism for carrying out normalization is arranging data in multiple tables and defining relationships between them

Keys 
  - special type of constraint used to establish relationships and uniqueness. 

Referential Integrity
  - if a particular column is a foreign key, referential integrity would stipulate that the data being referenced exists as unique key in the referenced table. 


  Database normalization assists in reducing duplication, and maintaining integrity of data. The mechanism used to achieve normalization in a relational database includes distributing data among multiple tables and defining relationships between these tables. Normalization reduces the need to store the same data in more than one place, thus minimizing the risk of inconsistencies and update anomalies. 
  
  The relationships between tables are established through the use of primary and foreign keys. Primary keys are unique identifiers for a row of data in a table, while foreign keys typically reference a primary key of another table in order to form an association. Primary and foreign keys work together to support referential integrity between normalized data by ensuring that the data being referenced exists, and that the relationship remains consistent.  


  natural keys: 

  These are keys which uniquely identify a row of data in a relation by default, that is, by being unique identifiers *by nature* of the data they represent. 

  Consider a table `homes`: 
```sql
CREATE TABLE homes (
  address text UNIQUE NOT NULL CHECK --- (address = format(address))

)


```
  The table is the house.

  Mailbox: 
    address_id: (address)

    the id here is by *nature*, unique. It uniquely identifies a particular house within a larger geographic area. and most notably it is naturally associated with the house. Addresses lend themselves naturally to identify real estate. The address marks an area where the collection of attributes which comprise the house, exists. And even if all of the other attributes besides its address were the exact same as hundreds of other entries, we still can find our house by its address.  


    - The row represents record of the house, and may identify its attributes in columns. 

      - The address is the PRIMARY KEY in this case by the *nature* 

      - These keys are naturals at uniquely identifying a row of data. 

  
  Natural keys are unique identifiers by nature of the data they represent. They are attributes of the entity itself, that happen to represent information uniquely qualified to identify a particular entity. 
    - A social security number
    - Student ID number
    - Driver's License Number








  Opposed to surrogate keys:

  The term precludes a transfer of responsibility. We are shifting responsibility away from the entity, to the system, in uniquely identifying a record. These keys have no 'business connection' with the entity, and are therefore generated within set parameters by the SQL engine to create a non-natural identifier. 





Assigning Foreign Keys

# During table creation

## Inline

## Explicit





# When adding a column as foreign key to existing table

## ALTER TABLE table_name 
ADD COLUMN col_name REFERENCES other_table (other_col);


# Targeted column already exists in table.

## ALTER TABLE









<!-- 
  #### Visualizing for Memory
- My house in Georgia. It's becoming fall and getting cooler. 
- I'm standing by the mailbox, looking down the driveway. 
- I notice the painted mailbox on my near left, the gravel parking space on my right.
- I notice the grass creeping into on the broken concrete of the driveway
- The house looks good. The bushes in front are growing. The spider looking grass is full. The windows are clean. There's a pumpkin on the porch. It smells like fire, faintly, the way fall smells when its a few weeks away. The sensation of cool air on the edges of my nostrils as I look from the street and I look left.  -->