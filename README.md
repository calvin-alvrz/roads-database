# Auckland Transport Road-Works Database Project

This repository contains the database implementation and Logical Entity Relationship Diagram (ERD) for the Auckland Transport (AT) Road-Works Case Study.

## Table of Contents
- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Database Implementation](#database-implementation)
- [SQL Queries](#sql-queries)
- [Contributing](#contributing)

## Project Overview

The Auckland Transport (AT) Road-Works Case Study is a database project conducted by the students Calvin Alvarez and Chloe Kua from Auckland University of Technology (AUT) for COMP508 - Database System Design core paper for the Bachelor of Computer and Information Science programme. This project aims to store information about roads, locations, projects, staff, and contracts managed by Auckland Transport. The project involves multiple tasks, including entity relationship modeling, logical database design, database implementation using Oracle SQL, and SQL queries.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local machine: 'git clone https://github.com/calvin-alvrz/roads-database'

2. Set up your Oracle SQL Developer environment for database implementation.

3. Execute the SQL scripts to create tables and populate them with sample data.

4. Run the provided SQL queries to retrieve data from the database.

## Entity Relationship Diagram

The Logical Entity Relationship Diagram (ERD) for this project can be found in the [Visual Paradigm](https://github.com/calvin-alvrz/roads-database/blob/main/AT_Roads.vpp) file provided. It illustrates the entities, relationships, and attributes of the database.

## Database Implementation

The database implementation includes the creation of tables with appropriate attributes, constraints, and sample data. You can find the SQL scripts for table creation and data insertion in the [SQL file](https://github.com/calvin-alvrz/roads-database/blob/main/Roads.sql).

To check the list of created tables, run the following SQL query:
```sql
SELECT table_name FROM user_tables;
```
## SQL Queries

The project requires the construction of SQL queries to retrieve specific data from the database. Five SQL queries have been developed to meet business requirements, including data retrieval, restriction and joins.

## Contributing

Contributions to this project are welcome. If you have any improvements or suggestions, please open an issue or create a pull request.