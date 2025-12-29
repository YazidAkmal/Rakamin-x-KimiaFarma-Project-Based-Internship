SELECT
  COUNTIF(transaction_id IS NULL) AS null_transaction_id,
  COUNTIF(date IS NULL) AS null_date,
  COUNTIF(branch_id IS NULL) AS null_branch_id,
  COUNTIF(customer_name IS NULL) AS null_customer_name,
  COUNTIF(product_id IS NULL) AS null_product_id,
  COUNTIF(price IS NULL) AS null_price,
  COUNTIF(discount_percentage IS NULL) AS null_discount_percentage,
  COUNTIF(rating IS NULL) AS null_rating,
FROM
  `rakamin-kf-analytics-291225.kimia_farma.kf_final_transaction`;