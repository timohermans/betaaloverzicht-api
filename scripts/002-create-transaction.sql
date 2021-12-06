drop table if exists api.transactions;
drop table if exists api.categories;

create table api.categories (
    id serial primary key,
    name varchar(255) not null unique
);

grant all on api.categories to web_user;
grant all on sequence api.categories_id_seq to web_user;

create table api.transactions (
    id SERIAL PRIMARY KEY,
    code VARCHAR(100) NOT NULL UNIQUE,
    iban VARCHAR(34) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    follow_number INTEGER,
    date_transaction DATE NOT NULL,
    amount VARCHAR(50) NOT NULL,
    amount_after_transaction VARCHAR(50) NOT NULL,
    iban_other_party VARCHAR(34),
    name_other_party VARCHAR(255),
    description TEXT,
    inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id VARCHAR(50) DEFAULT api.user_id(),

    category_id integer references api.categories (id)
);


-- TODO: (M) Row level security policy of user_id

grant all on api.transactions to web_user;
grant all on sequence api.transactions_id_seq to web_user;
