# 📊 Toy_Store_Ecommerce_Analysis

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Status](https://img.shields.io/badge/Project-Complete-brightgreen)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 📌 Overview

This project analyzes e-commerce transactional data to generate insights into:

- Revenue performance  
- Profitability  
- Refund behavior  
 
## 🗂️ Project Structure

```
toy_store_ecommerce_analysis/
│
├── data/
│   ├── order_item_refunds.csv
│   ├── order_items.csv
│   ├── orders.csv
│   └── products.csv
│
├── Data Analysis.sql/
│
└── README.md
```

---

## 🧠 Business Questions

This project answers key business questions such as:

- Which products generate the most revenue and profit?
- What is the overall refund rate and its impact?
- How does revenue trend over time?

---


**Joins:**
- `orders.order_id = order_items.order_id`
- `order_items.order_item_id = order_item_refunds.order_item_id`
- `order_items.product_id = products.product_id`

---

## 📊 Key Metrics

| Metric | Formula |
|------|--------|
| Total Revenue | SUM(price_usd) |
| Total Profit | SUM(price_usd - cogs_usd) |
| Net Revenue | Revenue − Refunds |
| Refund Rate | Refunds / Revenue |

---

## 🛠️ Tools & Technologies

- **SQL (MySQL)** – Data querying

---

## 🧾 Sample SQL Queries

### Revenue Over Time
```sql
SELECT 
    DATE(created_at) AS date,
    SUM(price_usd) AS revenue
FROM orders
GROUP BY date;
```

### Profit by Product
```sql
SELECT 
    product_id,
    SUM(price_usd - cogs_usd) AS profit
FROM order_items
GROUP BY product_id;
```

### Refund Rate
```sql
SELECT 
    SUM(r.refund_amount_usd) / SUM(oi.price_usd) * 100 AS refund_rate
FROM order_items oi
LEFT JOIN order_item_refunds r
ON oi.order_item_id = r.order_item_id;
```

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/tracynuwagaba/Toy_Store_Ecommerce_Analysis.git
cd Toy_Store_Ecommerce_Analysis
```

### 2. Load data into MySQL
- Import CSV files into your database
- Ensure correct schema and data types

### 3. Run SQL queries
- Navigate to `Data_Analysis.sql`
- Execute the script in your SQL environment


---

## 📈 Insights Summary (Example)

- Revenue shows consistent growth with periodic spikes  
- A small number of products drive the majority of profit  
- Refund rate is low overall but concentrated in specific products  
- High-refund products may indicate quality or expectation issues  

---


## 📄 License

This project is licensed under the MIT License.

---

## 👩🏽‍💻 Author

**Tracy Nuwagaba**  
Data Analytics | SQL | Business Intelligence  

---

## ⭐ If you find this useful

Give the repo a star ⭐ and share it!
