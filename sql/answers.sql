USE `treehouse_sample`;

SELECT associations.name AS "Assocation Name",
       companies.name    AS "Company Name",
       domains.domain    AS "Domain"
FROM   domains
       INNER JOIN sites
               ON domains.site = sites.id
       INNER JOIN companies
               ON sites.company = companies.id
       INNER JOIN associations
               ON sites.association = associations.id
WHERE  associations.name = 'Basement Systems, Inc.'
       AND domains.is_primary = 1
       AND sites.is_supercharged = 1
       AND domains.is_deleted = 0
       AND companies.is_on_hold = 0
       AND companies.is_deleted = 0
       AND sites.is_deleted = 0; 

-- +------------------------+--------------------------------------+------------+
-- | Assocation Name        | Company Name                         | Domain     |
-- +------------------------+--------------------------------------+------------+
-- | Basement Systems, Inc. | Scelerisque Lorem Ipsum Incorporated | aliquam.ca |
-- +------------------------+--------------------------------------+------------+
-- 1 row in set (0.00 sec)

SELECT associations.name AS 'Association Name',
       companies.name    AS 'Company Name',
       sites.name        AS 'Site'
FROM   sites
       INNER JOIN associations
               ON sites.association = associations.id
       INNER JOIN companies
               ON sites.company = companies.id
WHERE  sites.is_deleted = 0
       AND companies.is_deleted = 0
       AND companies.is_on_hold = 0
       AND (SELECT Count(*)
            FROM   domains
            WHERE  domains.site = sites.id) = 0; 

-- +--------------------------------+---------------------------------------+------------+
-- | Assocation Name                | Company Name                          | Site       |
-- +--------------------------------+---------------------------------------+------------+
-- | Total Basement Finishing, Inc. | Odio Phasellus Ltd                    | Oregon     |
-- | Basement Systems, Inc.         | Vel Company                           | Washington |
-- | Dr. Energy Saver, LLC          | Semper Nam Ltd                        | Washington |
-- | CleanSpace                     | Purus Nullam Scelerisque Incorporated | Alabama    |
-- | Total Basement Finishing, Inc. | Cras Interdum Inc.                    | Missouri   |
-- | Total Basement Finishing, Inc. | Accumsan Ltd                          | Wisconsin  |
-- | Foundation Supportworks, Inc.  | Accumsan Ltd                          | Minnesota  |
-- | Basement Systems, Inc.         | Pede Nonummy Associates               | Montana    |
-- | Foundation Supportworks, Inc.  | Odio LLC                              | Tennessee  |
-- | CleanSpace                     | Odio LLC                              | Kentucky   |
-- | Foundation Supportworks, Inc.  | Dolor Sit Foundation                  | Vermont    |
-- | Basement Systems, Inc.         | Diam Inc.                             | Nebraska   |
-- +--------------------------------+---------------------------------------+------------+
-- 12 rows in set (0.00 sec)

SELECT DISTINCT sites.id   AS "ID",
                sites.name AS "Name"
FROM   sites
       INNER JOIN companies
               ON sites.company = companies.id
       INNER JOIN domains
               ON sites.id = domains.site
WHERE  domains.is_deleted = 1
       AND companies.is_deleted = 0
       AND companies.is_on_hold = 0
       AND sites.is_deleted = 0
       AND (SELECT Count(*)
            FROM   domains
            WHERE  domains.site = sites.id) > 0; 

-- +----+------------+
-- | ID | Name       |
-- +----+------------+
-- | 62 | Wyoming    |
-- | 83 | Nevada     |
-- | 52 | Kentucky   |
-- | 53 | Washington |
-- | 31 | Wisconsin  |
-- | 87 | Florida    |
-- | 72 | Virginia   |
-- | 96 | Indiana    |
-- | 41 | Arkansas   |
-- +----+------------+
-- 9 rows in set (0.00 sec)