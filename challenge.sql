CREATE OR REPLACE TABLE rakamin-kf-analytics-291225.kimia_farma.kf_analysis AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating AS rating_cabang,
  t.customer_name,
  p.product_id,
  p.product_name,
  p.price AS actual_price,
  t.discount_percentage,
  
  -- persentase_gross_laba
  CASE
    WHEN p.price <= 50000 THEN 0.10
    WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
    WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
    WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

-- nett sales
  (p.price * (1 - t.discount_percentage / 100.0)) AS nett_sales,

-- nett profit
  ((p.price - (t.price * t.discount_percentage)) * CASE
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
      WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
      WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
      ELSE 0.30
    END
  )AS nett_profit,

  t.rating AS rating_transaksi

FROM
  rakamin-kf-analytics-291225.kimia_farma.kf_final_transaction AS t
LEFT JOIN
  rakamin-kf-analytics-291225.kimia_farma.kf_kantor_cabang AS kc
  ON t.branch_id = kc.branch_id
LEFT JOIN
  rakamin-kf-analytics-291225.kimia_farma.kf_product AS p
  ON t.product_id = p.product_id;