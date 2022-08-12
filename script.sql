create table consumed_products
(
    id                         bigint unsigned auto_increment
        primary key,
    smaregi_product_history_id bigint unsigned                     not null,
    smaregi_product_id         bigint unsigned                     not null,
    smaregi_store_id           varchar(20)                         not null,
    amount                     int                                 not null,
    smaregi_update_time        timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at                 timestamp                           null,
    updated_at                 timestamp                           null,
    constraint smaregi_product_history_id_uniq
        unique (smaregi_product_history_id)
)
    collate = utf8mb4_unicode_ci;

create index smaregi_product_id_idx
    on consumed_products (smaregi_product_id);

create table employees
(
    id             bigint unsigned auto_increment
        primary key,
    name           varchar(191)         not null,
    email          varchar(191)         not null,
    password       varchar(191)         not null,
    remember_token varchar(191)         null,
    role           int                  null,
    type           tinyint(1) default 2 not null comment '0: null, 1: product manager, 2:salar',
    memo           varchar(191)         null,
    created_at     timestamp            null,
    updated_at     timestamp            null,
    deleted_at     timestamp            null,
    last_login_at  timestamp            null
)
    collate = utf8mb4_unicode_ci;

create table exchange_rate_logs
(
    id         bigint unsigned auto_increment
        primary key,
    value      varchar(191) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table failed_jobs
(
    id         bigint unsigned auto_increment
        primary key,
    uuid       varchar(191)                        not null,
    connection text                                not null,
    queue      text                                not null,
    payload    longtext                            not null,
    exception  longtext                            not null,
    failed_at  timestamp default CURRENT_TIMESTAMP not null,
    constraint failed_jobs_uuid_unique
        unique (uuid)
)
    collate = utf8mb4_unicode_ci;

create table jobs
(
    id           bigint unsigned auto_increment
        primary key,
    queue        varchar(191)     not null,
    payload      longtext         not null,
    attempts     tinyint unsigned not null,
    reserved_at  int unsigned     null,
    available_at int unsigned     not null,
    created_at   int unsigned     not null
)
    collate = utf8mb4_unicode_ci;

create index jobs_queue_index
    on jobs (queue);

create table mat_orders
(
    id              bigint auto_increment
        primary key,
    mat_supplier_id bigint        not null,
    employee_id     bigint        not null,
    name            varchar(191)  not null,
    extra_data      text          not null,
    deleted_at      timestamp     null,
    created_at      timestamp     null,
    updated_at      timestamp     null,
    status          tinyint       not null,
    stock_status    tinyint       not null,
    mail_status     int default 0 not null,
    ordered_at      timestamp     null
)
    collate = utf8mb4_unicode_ci;

create table mat_suppliers
(
    id           bigint unsigned auto_increment
        primary key,
    name         varchar(191) not null,
    memo         text         not null,
    deleted_at   timestamp    null,
    created_at   timestamp    null,
    updated_at   timestamp    null,
    mail_address varchar(191) null
)
    collate = utf8mb4_unicode_ci;

create table migrations
(
    id        int unsigned auto_increment
        primary key,
    migration varchar(191) not null,
    batch     int          not null
)
    collate = utf8mb4_unicode_ci;

create table order_updater_logs
(
    id          bigint auto_increment
        primary key,
    order_id    bigint     not null,
    updater_id  bigint     not null,
    role        tinyint(1) null,
    from_status tinyint(1) not null,
    to_status   tinyint(1) not null,
    created_at  timestamp  null,
    updated_at  timestamp  null
)
    collate = utf8mb4_unicode_ci;

create table other_order_products
(
    id             bigint unsigned auto_increment
        primary key,
    other_order_id bigint       not null,
    product_id     varchar(191) not null,
    unit_price     decimal      null,
    selling_price  decimal      null,
    quantity       int          not null,
    created_at     timestamp    null,
    updated_at     timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table other_orders
(
    id           bigint unsigned auto_increment
        primary key,
    supplier_id  bigint       not null,
    employee_id  bigint       not null,
    extra_data   text         not null,
    status       tinyint      not null,
    name         varchar(191) not null,
    memo         text         null,
    created_user bigint       not null,
    deleted_at   timestamp    null,
    created_at   timestamp    null,
    updated_at   timestamp    null,
    stock_status tinyint      not null
)
    collate = utf8mb4_unicode_ci;

create table password_resets
(
    email      varchar(191) not null,
    token      varchar(191) not null,
    created_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create index password_resets_email_index
    on password_resets (email);

create table payment_methods
(
    id            bigint auto_increment
        primary key,
    name          varchar(191)   null,
    rate          decimal(10, 2) null,
    fee           decimal(10, 2) null,
    from_currency varchar(191)   null comment 'default USD',
    to_currency   varchar(191)   null comment 'default JPY',
    created_at    timestamp      null,
    updated_at    timestamp      null
)
    collate = utf8mb4_unicode_ci;

create table payment_fee_tiers
(
    id          int auto_increment
        primary key,
    payment_id  bigint        null,
    amount_from decimal       null,
    amount_to   decimal       null,
    fee_amount  decimal(8, 2) null,
    created_at  timestamp     null,
    updated_at  timestamp     null,
    constraint fk_payment_id_payment_fee_tiers
        foreign key (payment_id) references payment_methods (id)
)
    collate = utf8mb4_unicode_ci;

create table products
(
    id                 bigint auto_increment
        primary key,
    smaregi_id         bigint unsigned                      null,
    name               text                                 null,
    internal_code      varchar(191)                         null,
    supplier_code      varchar(191)                         null,
    selling_price      decimal(10, 2) unsigned default 0.00 not null,
    unit_price         decimal(10, 2) unsigned default 0.00 not null,
    profit_margin_bank decimal(10, 2)          default 0.00 not null,
    memo               text                                 null,
    created_at         timestamp                            null,
    updated_at         timestamp                            null,
    color              varchar(50)                          null,
    size               varchar(50)                          null,
    size_constant      varchar(50)                          null,
    deleted_at         timestamp                            null,
    category_id        int                                  null,
    constraint smaregi_id_uniq
        unique (smaregi_id)
)
    collate = utf8mb4_unicode_ci;

create index smaregi_id_idx
    on products (smaregi_id);

create table settings
(
    id         bigint auto_increment
        primary key,
    `key`      varchar(191) not null,
    value      varchar(191) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table stores
(
    id               bigint auto_increment
        primary key,
    smaregi_store_id varchar(20) not null,
    name             text        not null,
    product_amount   decimal     null,
    type             int         null comment '1: EC
2: Defected',
    created_at       timestamp   null,
    updated_at       timestamp   null,
    deleted_at       timestamp   null
)
    collate = utf8mb4_unicode_ci;

create index smaregi_store_id
    on stores (smaregi_store_id);

create table stores_products
(
    smaregi_store_id varchar(20)     not null,
    smaregi_id       bigint unsigned not null,
    quantity         int default 0   not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    primary key (smaregi_store_id, smaregi_id),
    constraint fk_smaregi_id_store_product
        foreign key (smaregi_id) references products (smaregi_id),
    constraint fk_store_id_store_product
        foreign key (smaregi_store_id) references stores (smaregi_store_id)
)
    collate = utf8mb4_unicode_ci;

create table suppliers
(
    id                bigint auto_increment
        primary key,
    name              varchar(191) null,
    code              varchar(191) null,
    payment_method_id bigint       null,
    memo              text         null,
    created_at        timestamp    null,
    updated_at        timestamp    null,
    deleted_at        timestamp    null,
    mail_address      varchar(191) null,
    constraint fk_payment_method_id_suppliers
        foreign key (payment_method_id) references payment_methods (id)
)
    collate = utf8mb4_unicode_ci;

create table orders
(
    id                        bigint auto_increment
        primary key,
    name                      varchar(191)                not null,
    supplier_id               bigint                      not null,
    payment_method_id         bigint                      null,
    status                    tinyint(1)                  null,
    current_rate              decimal                     null,
    paypal_rate               decimal(10, 2)              not null,
    tt_rate                   decimal(10, 2)              not null,
    bank_rate                 decimal(10, 2)              not null,
    current_fee               decimal                     null,
    paypal_fee                decimal(10, 2) default 0.00 not null,
    tt_fee                    decimal(10, 2) default 0.00 not null,
    bank_fee                  decimal(10, 2) default 0.00 not null,
    profit_margin_bank        decimal(10, 2) default 0.00 not null,
    lead_time                 int                         not null,
    purchase_order_document   tinyint(1)                  not null,
    order_mode                int            default 1    not null,
    lead_time_estimation      int            default 2    not null,
    estimated_at              timestamp                   null,
    execution_at              timestamp                   null,
    paid_at                   timestamp                   null,
    received_at               timestamp                   null,
    estimated_completion_time timestamp                   null,
    completed_at              timestamp                   null,
    created_at                timestamp                   null,
    updated_at                timestamp                   null,
    deleted_at                timestamp                   null,
    note                      text                        null,
    constraint fk_payment_method_id_orders
        foreign key (payment_method_id) references payment_methods (id),
    constraint fk_supplier_id_orders
        foreign key (supplier_id) references suppliers (id)
)
    collate = utf8mb4_unicode_ci;

create table order_products
(
    order_id           bigint                      not null,
    product_id         bigint                      not null,
    quantity           int                         null,
    unit_price         decimal(10, 2)              null,
    selling_price      decimal(10, 2)              not null,
    profit_margin_bank decimal(10, 2) default 0.00 not null,
    created_at         timestamp                   null,
    updated_at         timestamp                   null,
    size               varchar(191)                null,
    size_constant      varchar(191)                null,
    supplier_code      varchar(191)                null,
    arrival_at         timestamp                   null,
    arrived_amount     int                         null,
    quality_status     tinyint                     null,
    quantity_status    tinyint                     null,
    restock_at         timestamp                   null,
    restock_quantity   int                         null,
    labeling_status    tinyint                     null,
    primary key (order_id, product_id),
    constraint fk_order_id_order_products
        foreign key (order_id) references orders (id),
    constraint fk_product_id_order_products
        foreign key (product_id) references products (id)
)
    collate = utf8mb4_unicode_ci;

create table supplier_products
(
    product_id  bigint    not null
        primary key,
    supplier_id bigint    not null,
    created_at  timestamp null,
    updated_at  timestamp null,
    constraint fk_product_id_supplier_products
        foreign key (product_id) references products (id),
    constraint fk_supplier_id_supplier_products
        foreign key (supplier_id) references suppliers (id)
)
    collate = utf8mb4_unicode_ci;

create table users
(
    id                bigint unsigned auto_increment
        primary key,
    name              varchar(191) not null,
    email             varchar(191) not null,
    email_verified_at timestamp    null,
    password          varchar(191) not null,
    remember_token    varchar(100) null,
    created_at        timestamp    null,
    updated_at        timestamp    null,
    constraint users_email_unique
        unique (email)
)
    collate = utf8mb4_unicode_ci;


