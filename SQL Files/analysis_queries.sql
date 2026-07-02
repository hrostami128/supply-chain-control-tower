##Suppliers average delay days
SELECT
    supplier_id,
    COUNT(*) AS total_orders,
    AVG(
        received_date - expected_date
    ) AS avg_delay_days
FROM supply_chain.fact_purchase_orders
GROUP BY supplier_id
ORDER BY avg_delay_days DESC;

## Suppliers average lead time
SELECT
    supplier_id,
    COUNT(*) AS total_orders,
    ROUND(
        AVG(received_date - order_date),
        2
    ) AS avg_lead_time
FROM supply_chain.fact_purchase_orders
GROUP BY supplier_id
ORDER BY avg_lead_time DESC;

## warehouses inventory values
SELECT
    w.warehouse_name,
    ROUND(
        SUM(
            i.stock_on_hand * p.unit_cost
        ),
        2
    ) AS inventory_value
FROM supply_chain.fact_inventory i

JOIN supply_chain.dim_product p
ON i.product_id = p.product_id

JOIN supply_chain.dim_warehouse w
ON i.warehouse_id = w.warehouse_id

GROUP BY w.warehouse_name

ORDER BY inventory_value DESC;