
drop schema if exists api cascade;
create schema api;

create role web_anon nologin;
create role web_user nologin;

grant usage on schema api to web_anon;
grant usage on schema api to web_user;

grant web_anon to web_admin;
grant web_user to web_admin;
