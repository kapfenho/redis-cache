# redis-cache

Creating a telco customer search cache with [redis.io](http://redis.io).

The cache is designed to serve a small number of search field combinations of an multi-field search form.

## Use Case and Architecture

A common customer search form shall deliver result sets from
several CRM systems.

The search shall be very responsive and deliver a data set with all
necessary attributes to identify a customer, as well as the CRM system hosting it.

After selecting one customer from the search result set, the
customer view from the corresponding CRM system is called.

However, no look-ahead is shall be done. So only data that is
explicitely searched for shall be displayed.

## The Search

The search covers consumer and business customers:

**Fields:**
+ Company name
+ First name
+ Last name
+ ZIP
+ Account number
+ MSISDN (phone number)

**Searches executed**

+ for MSISDN
+ for account number
+ for last name
+ for last name and first name
+ for last name and zip
+ for company name

## Original Data Model

+ A customer consists of a firstname, lastname, and ZIP
+ A customer has one or more accounts
+ An account consists of an Account-ID
+ An account has one or more subscribers
+ A subscriber consists of a subscriber ID and an MSISDN

## Redis data design

+ Denormalized, complete data set stored as string
    + base for the complete fetch based on subscriber ID
+ Fields of this complete set are needed as lookup indexes (hashes)
    + MSISDN
    + Account-ID
+ Last name is stored as set (unordered collection of strings)

### Todo

+ create rake interface instead shell script
+ create sample sinatra app for lookups
+ work on README
 



