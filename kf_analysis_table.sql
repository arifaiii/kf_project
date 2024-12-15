-- Create Analysis Table
CREATE OR REPLACE TABLE rakamin-kf-analytics-444207.kimia_farma.kf_analysis_table AS
WITH 
    -- CTE to calculate profit percentage
    CTE_Laba AS (
        SELECT
            DISTINCT price,
            CASE 
                WHEN price <= 50000 THEN 10
                WHEN price > 50000 AND price <= 100000 THEN 15
                WHEN price > 100000 AND price <= 300000 THEN 20
                WHEN price > 300000 AND price <= 500000 THEN 25
                ELSE 30
            END AS persentase_gross_laba
        FROM 
            rakamin-kf-analytics-444207.kimia_farma.kf_final_transaction
    ),
    -- CTE to prepare transaction data with profit
    CTE_Transaksi AS (
        SELECT
            t.transaction_id,
            t.date,
            t.branch_id,
            t.customer_name,
            t.product_id,
            t.price AS actual_price,
            t.discount_percentage,
            l.persentase_gross_laba,
            -- Calculate nett sales
            t.price * (1 - t.discount_percentage / 100) AS nett_sales,
            -- Calculate nett profit
            (t.price * (1 - t.discount_percentage / 100)) * l.persentase_gross_laba / 100 AS nett_profit,
            t.rating AS rating_transaksi
        FROM 
            rakamin-kf-analytics-444207.kimia_farma.kf_final_transaction AS t
        LEFT JOIN 
            CTE_Laba AS l
        ON 
            t.price = l.price
    ),
    -- CTE for branch information
    CTE_Cabang AS (
        SELECT
            branch_id,
            branch_name,
            kota,
            provinsi,
            rating AS rating_cabang
        FROM 
            rakamin-kf-analytics-444207.kimia_farma.kf_kantor_cabang
    ),
    -- CTE for product information
    CTE_Produk AS (
        SELECT
            product_id,
            product_name
        FROM 
            rakamin-kf-analytics-444207.kimia_farma.kf_product
    )
-- Combine all CTE
SELECT
    tr.transaction_id,
    tr.date,
    tr.branch_id,
    c.branch_name,
    c.kota,
    c.provinsi,
    c.rating_cabang,
    tr.customer_name,
    tr.product_id,
    p.product_name,
    tr.actual_price,
    tr.discount_percentage,
    tr.persentase_gross_laba,
    tr.nett_sales,
    tr.nett_profit,
    tr.rating_transaksi
FROM
    CTE_Transaksi AS tr
LEFT JOIN 
    CTE_Cabang AS c
ON 
    tr.branch_id = c.branch_id
LEFT JOIN 
    CTE_Produk AS p
ON 
    tr.product_id = p.product_id;

SELECT *
FROM rakamin-kf-analytics-444207.kimia_farma.kf_analysis_table
ORDER BY date ASC;
