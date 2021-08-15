CREATE TABLE parts(
    part_id INT GENERATED ALWAYS AS IDENTITY,
    part_name VARCHAR2(50) NOT NULL,
    capacity INT NOT NULL,
    cost DEC(15,2) NOT NULL,
    list_price DEC(15,2) NOT NULL,
    gross_margin AS ((list_price - cost) / cost),
    PRIMARY KEY(part_id)
);
