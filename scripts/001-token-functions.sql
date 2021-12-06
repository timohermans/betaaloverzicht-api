-- # TODO: (M) Re-add functions to request schema
-- drop schema if exists request cascade;
-- create schema request;
-- grant usage on schema request to web_user;

create or replace function api.env_var(v text) returns text as $$
    select current_setting(v, false);
$$ stable language sql;

create or replace function api.jwt_claim(c text) returns text as $$
    select api.env_var('request.jwt.claims')::json->c;
$$ stable language sql;

create or replace function api.user_id() returns text as $$
    select api.jwt_claim('sub')::text;
$$ stable language sql;

create or replace function api.user_role() returns text as $$
    select api.jwt_claim('role')::text;
$$ stable language sql;