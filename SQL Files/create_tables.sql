## fact_inventory
CREATE TABLE supply_chain.fact_inventory (
    snapshot_date DATE,
    product_id VARCHAR(10),
    warehouse_id VARCHAR(10),
    stock_on_hand INT,

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES supply_chain.dim_product(product_id),

    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES supply_chain.dim_warehouse(warehouse_id),

    CONSTRAINT fk_inventory_date
        FOREIGN KEY (snapshot_date)
        REFERENCES supply_chain.dim_date(date_id)
);

## fact_customer_orders
CREATE TABLE supply_chain.fact_customer_orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE,
    warehouse_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    sales_amount NUMERIC(12,2),

    CONSTRAINT fk_orders_product
        FOREIGN KEY (product_id)
        REFERENCES supply_chain.dim_product(product_id),

    CONSTRAINT fk_orders_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES supply_chain.dim_warehouse(warehouse_id),

    CONSTRAINT fk_orders_date
        FOREIGN KEY (order_date)
        REFERENCES supply_chain.dim_date(date_id)
);

## fact_purchase_orders
CREATE TABLE supply_chain.fact_purchase_orders (
    po_id VARCHAR(20) PRIMARY KEY,

    supplier_id VARCHAR(10),
    product_id VARCHAR(10),

    order_date DATE,
    expected_date DATE,
    received_date DATE,

    quantity INT,
    unit_cost NUMERIC(10,2),

    CONSTRAINT fk_po_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES supply_chain.dim_supplier(supplier_id),

    CONSTRAINT fk_po_product
        FOREIGN KEY (product_id)
        REFERENCES supply_chain.dim_product(product_id),

    CONSTRAINT fk_po_order_date
        FOREIGN KEY (order_date)
        REFERENCES supply_chain.dim_date(date_id),

    CONSTRAINT fk_po_expected_date
        FOREIGN KEY (expected_date)
        REFERENCES supply_chain.dim_date(date_id),

    CONSTRAINT fk_po_received_date
        FOREIGN KEY (received_date)
        REFERENCES supply_chain.dim_date(date_id)
);

## fact_shipments
CREATE TABLE supply_chain.fact_shipments (
    shipment_id VARCHAR(20) PRIMARY KEY,

    order_id VARCHAR(20),

    ship_date DATE,
    delivery_date DATE,

    status VARCHAR(20),

    CONSTRAINT fk_ship_order
        FOREIGN KEY (order_id)
        REFERENCES supply_chain.fact_customer_orders(order_id),

    CONSTRAINT fk_ship_date
        FOREIGN KEY (ship_date)
        REFERENCES supply_chain.dim_date(date_id)
);