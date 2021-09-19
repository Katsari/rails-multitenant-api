# Rails Multitenant API (WIP)

This is an opinionated Rails application designed to be used as a starter or example on how to implement a REST API with row based multitenancy and extra security by leveraging PostgreSQL's Row Level Security (RLS).

## Main features

* Row based multitenancy for data isolation (adding tenant_id to almost all tables).
* Automatically add `tenant_id` to database queries using [activerecord-multi-tenant](https://github.com/citusdata/activerecord-multi-tenant).
* A sencond layer of security for data restriction by using PostgreSQL's Row Level Security (see [PG Docs](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)). Easy policy definition, migrations and controller integration with [rls_rails](https://github.com/suus-io/rls_rails).
* Email authentication using [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth), including:
  * User registration, creation, update and deletion
  * Login and logout
  * Password reset, account confirmation
* Permission based authorization using [CanCanCan](https://github.com/CanCanCommunity/cancancan).
* Graph API using RESTful Resources by leveraging the amazing [Graphiti](https://www.graphiti.dev/guides/) gem, which includes:
  * JSON:API specification (also supports JSON and XML responses)
  * Sorting
  * Pagination
  * Filtering
  * Statictics
  * Error handling
  * Side-loading and side-posting
* Test framework setup ready for writing unit, request, resource and API tests (Rspec + Factory Bot + Faker + Shoulda Matchers + Database Cleaner + Graphiti spec helpers). Includes tests for users, roles, sessions, registrations and token validations.
