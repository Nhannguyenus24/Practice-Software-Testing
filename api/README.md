# Product API Tests - Data Driven Testing - test 

Bộ test hoàn chỉnh cho 3 API Product với data-driven testing sử dụng CSV files.

## Cấu trúc thư mục

```
tests/api/
├── collection.json          # Postman collection
├── environment.json         # Postman environment
├── products-list.csv        # Data cho GET /api/products
├── products-search.csv      # Data cho GET /api/products/search  
├── products-detail.csv      # Data cho GET /api/products/{id}
└── README.md               # Hướng dẫn này
```

## 🚀 Cách sử dụng

### 1. Import vào Postman

1. Mở Postman
2. Import file `collection.json`
3. Import file `environment.json`
4. Chọn environment "Product API Test Environment"

### 2. Chạy với Newman (Command Line)

#### Cài đặt Newman:
```bash
npm install -g newman newman-reporter-htmlextra newman-reporter-junit
```

#### Chạy test cho từng API:

**GET /api/products (Danh sách sản phẩm):**
```bash
newman run collection.json \
  -e environment.json \
  --iteration-data products-list.csv \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export reports/products-list-report.html
```

**GET /api/products/search (Tìm kiếm sản phẩm):**
```bash
newman run collection.json \
  -e environment.json \
  --iteration-data products-search.csv \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export reports/products-search-report.html
```

**GET /api/products/{id} (Chi tiết sản phẩm):**
```bash
newman run collection.json \
  -e environment.json \
  --iteration-data products-detail.csv \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export reports/products-detail-report.html
```

#### Chạy tất cả test:
```bash
# Tạo thư mục reports
mkdir -p reports

# Chạy tất cả test
newman run collection.json \
  -e environment.json \
  --iteration-data products-list.csv \
  --reporters cli,htmlextra \
  --reporter-htmlextra-export reports/all-tests-report.html
```

## 📊 Data-Driven Test Cases

### 1. GET /api/products (products-list.csv)

| Test Case | Mô tả | Tham số |
|-----------|-------|---------|
| all_products | Lấy toàn bộ sản phẩm | Không có filter |
| brand_1 | Lọc theo brand 1 | by_brand=1 |
| category_3 | Lọc theo category 3 (Hammer) | by_category=3 |
| rental_products | Lọc sản phẩm cho thuê | is_rental=1 |
| price_range_10_50 | Lọc giá từ 10-50 | between=price,10,50 |
| sort_name_asc | Sắp xếp theo tên tăng dần | sort=name,asc |
| invalid_brand | Brand không tồn tại | by_brand=999 |

### 2. GET /api/products/search (products-search.csv)

| Test Case | Mô tả | Tham số |
|-----------|-------|---------|
| search_hammer | Tìm kiếm "hammer" | q=hammer |
| search_drill | Tìm kiếm "drill" | q=drill |
| search_sql_injection | Thử SQL injection | q='; DROP TABLE products; -- |
| search_xss | Thử XSS | q=<script>alert('xss')</script> |
| search_empty | Tìm kiếm rỗng | q= |

### 3. GET /api/products/{id} (products-detail.csv)

| Test Case | Mô tả | Tham số |
|-----------|-------|---------|
| valid_id_1 | ID hợp lệ | product_id=1 |
| valid_id_27 | ID sản phẩm rental | product_id=27 |
| invalid_id_999 | ID không tồn tại | product_id=999 |
| zero_id | ID bằng 0 | product_id=0 |
| negative_id | ID âm | product_id=-1 |
| non_numeric_id | ID không phải số | product_id=abc |

## 🔧 Cấu hình Environment

File `environment.json` chứa:
- `baseUrl`: http://localhost:8091/api

## 📈 Test Coverage

### Functional Testing
- ✅ Lấy danh sách sản phẩm
- ✅ Lọc theo brand, category, rental status
- ✅ Lọc theo khoảng giá
- ✅ Sắp xếp theo tên, giá
- ✅ Tìm kiếm sản phẩm
- ✅ Lấy chi tiết sản phẩm

### Edge Cases
- ✅ Tham số không hợp lệ
- ✅ ID không tồn tại
- ✅ ID âm, zero, non-numeric
- ✅ Tìm kiếm rỗng
- ✅ Ký tự đặc biệt

### Security Testing
- ✅ SQL Injection attempts
- ✅ XSS attempts
- ✅ Input validation

### Performance Testing
- ✅ Response time < 2s
- ✅ Content-Type validation

## 🐛 Bug Detection

Collection tự động phát hiện:
- Status code không đúng
- Response structure sai
- Data validation failures
- Security vulnerabilities
- Performance issues

## 📋 Requirements

- Node.js (cho Newman)
- Docker containers đang chạy
- Database đã được seed với dữ liệu từ `toolshop-data.sql`

## 🚀 Quick Start

1. **Khởi động API:**
```bash
docker-compose up -d
docker-compose exec laravel-api php artisan migrate:fresh --seed --force
```

2. **Chạy test:**
```bash
cd tests/api
newman run collection.json -e environment.json --data products-list.csv
```

## 📝 Notes

- Tất cả test cases dựa trên dữ liệu thực từ `toolshop-data.sql`
- Collection sử dụng data-driven approach với CSV files
- Mỗi API có file CSV riêng để dễ quản lý

- Test scripts tự động validate response structure và data 
