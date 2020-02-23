# ETL Worshop SVKPK

## Overview

![entity-scheme](img/reos-schema.png "Entity scheme")

## Entity types

### Person

| Field name         | RDF property                     | Expected value       | Source MARC field |
| ------------------ | -------------------------------- | -------------------- | ----------------- |
| Type               | rdf:type                         | schema:Person        |                   |
| Name               | schema:name                      | Literal              | 100a              |
| Given name         | schema:givenName                 | Literal              | 100a              |
| Family name        | schema:familyName                | Literal              | 100a              |
| Birth date         | schema:birthDate                 | Literal              | KDNa              |
| Birth place        | schema:birthPlace                | schema:Place         | R02               |
| Death date         | schema:deathDate                 | Literal              | KDUa              |
| Death place        | schema:deathPlace                | schema:Place         | R03               |
| Description        | schema:disambiguatingDescription | Literal              | 678a              |
| Works about person | schema:about                     | schema:Creative Work | 670a              |
| Keywords           | dcterms:subject                  | Literal              | R06a              |
| Authority ID       | mads:isIdentifiedByAutority      | URI                  | 100/7             |

### Place

| Field name | RDF property  | Expected value | Source MARC field |
| ---------- | ------------- | -------------- | ----------------- |
| Type       | rdf:type      | schema:Place   |                   |
| Name       | schema:name   | Literal        | R02/R03           |
| Same as    | schema:sameAs | URI            |                   |

### Creative Work

| Field name | RDF property | Expected value      | Source MARC field |
| ---------- | ------------ | ------------------- | ----------------- |
| Type       | rdf:type     | schema:CreativeWork |                   |
| Name       | schema:name  | Literal             | 670a              |
