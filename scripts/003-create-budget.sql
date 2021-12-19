drop index if exists uq_budget_month;
drop table if exists api.budgets;
create table api.budgets (
    id serial primary key,
    year integer not null,
    month integer not null,
    amount decimal(10, 2) not null,
    user_id varchar(50) default api.user_id(),
    category_id integer references api.categories(id)
);
create unique index uq_budget_month on api.budgets (category_id, year, month);
grant all on api.budgets to web_user;
grant all on sequence api.budgets_id_seq to web_user;
-- TODO: (M) Row security policy