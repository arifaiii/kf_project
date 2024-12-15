# Project Based Internship Kimia Farma X Rakamin

## Kimia Farma Performance Analytics 2020 - 2023

Project ini bertujuan untuk menganalisis performa Kimia Farma selama periode 2020 hingga 2023. Analisis ini mencakup berbagai aspek, seperti penjualan, keuntungan, dan performa cabang. Data yang telah diolah akan digunakan untuk membangun dashboard interaktif menggunakan Google Looker Studio.

Sebelum membangun dashboard, data dianalisis dan diolah menggunakan query SQL. Query ini membuat tabel analisis yang menggabungkan data transaksi, cabang, dan produk untuk menghasilkan informasi berikut:
- Penjualan Bersih (Net Sales): Menghitung total penjualan setelah diskon.
- Keuntungan Bersih (Net Profit): Menghitung keuntungan bersih berdasarkan persentase laba kotor.
- Informasi Produk dan Cabang: Menyertakan nama produk, lokasi cabang, dan rating.

Query ini terdiri dari beberapa Common Table Expression (CTE):

- CTE_Laba: Menghitung persentase laba kotor berdasarkan rentang harga.
- CTE_Transaksi: Menambahkan informasi penjualan dan keuntungan ke data transaksi.
- CTE_Cabang: Menambahkan informasi cabang (lokasi dan rating).
- CTE_Produk: Menambahkan informasi produk.

Hasil akhir query disimpan dalam tabel kf_analysis_table yang akan dihubungkan untuk membuat dashboard pada Google Looker Studio. Dashboard dapat diakses [di sini.](https://lookerstudio.google.com/reporting/9d167a6d-4e7d-49fe-b368-96aaebd0fb90)
