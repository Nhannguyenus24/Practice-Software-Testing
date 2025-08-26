# API Testing Report

**Student ID:** 22127306 
**Course:** Kiểm thử phần mềm - 22KTPM2
**Assignment:** API Testing  
**Date:** 2/8/2025

---

## Table of Contents

---

## Task Allocation

### Group Members and Responsibilities

| Student ID | Name              | Assigned APIs |
| ---------- | ----------------- | ------------- |
| 22127232   | Lê Thị Ngọc Linh  | User APIS     |
| 22127240   | Trần Tiến Lợi     | Favorite APIs |
| 22127306   | Nguyễn Trọng Nhân | Product APIS  |

### Individual Scope


This report focuses on the **Product APIs** được kiểm thử tự động với data-driven testing, bao gồm:

- **GET /api/products** - Lấy danh sách sản phẩm
- **GET /api/products/search** - Tìm kiếm sản phẩm
- **GET /api/products/{id}** - Lấy chi tiết sản phẩm

**Link Videos**:
   - CI/CD Integration: https://youtu.be/WR5x8hrHYUQ
   - GET /api/products: https://youtu.be/7fBndZKwLLo
   - GET /api/products/search: https://youtu.be/1n4TFo4mZ2M
   - GET /api/products/{id}: https://youtu.be/kk1IUgy830g

---

## Introduction

### Objective

This assignment aims to demonstrate comprehensive API testing skills including:

- Designing and executing API test cases using data-driven testing
- Identifying and reporting bugs systematically
- Integrating API tests into CI/CD workflows
- Leveraging AI tools for test design and reporting
- Creating professional test documentation

### Expected Learning Outcomes

By completing this assignment, I have gained the ability to:

- Design API test cases on real-world projects
- Execute designed test cases effectively
- Record actual results and compare with expected results
- Report bugs systematically
- Integrate API testing into CI/CD workflows
- Use AI tools effectively and responsibly
- Create professional test reports

---

## Software Under Test

### Application Details

- **Application Name:** The Toolshop
- **Repository:** https://github.com/testsmith-io/practice-software-testing/
- **Target Version:** /sprint5-with-bugs folder
- **Deployment:** Local deployment on personal machine

### API Endpoints Overview


Các API được kiểm thử:

| Endpoint                | Method | Description                | Authentication Required |
| ----------------------- | ------ | -------------------------- | ----------------------- |
| `/api/products`         | GET    | Lấy danh sách sản phẩm     | No                      |
| `/api/products/search`  | GET    | Tìm kiếm sản phẩm          | No                      |
| `/api/products/{id}`    | GET    | Lấy chi tiết sản phẩm      | No                      |

---

## API Testing Approach

### Testing Strategy

I adopted a comprehensive testing approach that includes:


1. **Data-Driven Testing**: Sử dụng file CSV để quản lý dữ liệu test cho từng API
2. **Positive & Negative Testing**: Kiểm thử cả trường hợp hợp lệ và không hợp lệ
3. **Automation & CI/CD**: Tích hợp kiểm thử vào workflow tự động với Newman và GitHub Actions

### Tools and Technologies


- **Postman**: Thiết kế và kiểm thử API
- **CSV Files**: Quản lý dữ liệu test cho từng API
- **Newman**: Chạy collection tự động trên CLI
- **GitHub Actions**: Tích hợp CI/CD
- **AI Tools**: Hỗ trợ thiết kế test case

### Test Environment Setup


1. **Local Deployment**: Deploy ứng dụng local hoặc sử dụng endpoint public
2. **Postman Environment**: Sử dụng file `environment.json` với biến `baseUrl` (ví dụ: https://api-with-bugs.practicesoftwaretesting.com)

---

## Step-by-Step Testing Technique Implementation

### Step 1: Install Postman and launch it

![Alt text](./images/1.png)


### Step 2: Import Environment

Import file `environment.json` vào Postman, đảm bảo biến `baseUrl` đúng với endpoint cần test (ví dụ: https://api-with-bugs.practicesoftwaretesting.com)


### Step 3: Import Collection

Import file `Product API Tests - Data Driven.postman_collection.json` vào Postman.


### Step 4: Kiểm tra các request trong collection

Collection đã có sẵn các request:
- GET /api/products
- GET /api/products/search
- GET /api/products/{id}


### Step 5: Cấu hình test data (CSV)

Sử dụng các file CSV tương ứng:
- `products-list.csv` cho GET /api/products
- `products-search.csv` cho GET /api/products/search
- `products-detail.csv` cho GET /api/products/{id}


### Step 6: Tạo test case trong file CSV

Các cột trong file CSV phải trùng với biến sử dụng trong request (ví dụ: id, search, v.v.).


## Step 7: Chạy test với Newman

Có thể chạy từng API hoặc toàn bộ bằng script `run-tests.sh`:

```bash
sh run-tests.sh --api-type all
```
Hoặc chạy từng API:
```bash
sh run-tests.sh --api-type list    # GET /api/products
sh run-tests.sh --api-type search  # GET /api/products/search
sh run-tests.sh --api-type detail  # GET /api/products/{id}
```

## Test Case Design


### Test Case Structure

Mỗi test case gồm các trường:
- **Test Case ID**: Mã test case
- **Test Name**: Tên mô tả
- **Method**: HTTP method (GET)
- **Endpoint**: API endpoint
- **Test Data**: Tham số truyền vào (id, search, ...)
- **Expected Status**: Mã trạng thái mong đợi
- **Description**: Mô tả kịch bản

### Data-Driven Test Cases

#### 1. GET /api/products
| Test Case | Test Name                | Expected Status | Description                        |
| --------- | ------------------------ | --------------- | ---------------------------------- |
| 1         | Get_All_Products         | 200             | Lấy toàn bộ danh sách sản phẩm     |
| 2         | Get_Products_Pagination  | 200             | Kiểm tra phân trang                |

#### 2. GET /api/products/search
| Test Case | Test Name                | Search   | Expected Status | Description                        |
| --------- | ------------------------ | -------- | --------------- | ---------------------------------- |
| 1         | Search_Valid_Keyword     | "phone" | 200             | Tìm kiếm sản phẩm hợp lệ           |
| 2         | Search_Empty             | ""      | 200             | Tìm kiếm với từ khóa rỗng          |
| 3         | Search_Invalid_Keyword   | "xyz"   | 200             | Tìm kiếm không ra kết quả          |

#### 3. GET /api/products/{id}
| Test Case | Test Name                | ID   | Expected Status | Description                        |
| --------- | ------------------------ | ---- | --------------- | ---------------------------------- |
| 1         | Get_Product_Valid_ID     | 1    | 200             | Lấy chi tiết sản phẩm hợp lệ        |
| 2         | Get_Product_Invalid_ID   | 9999 | 404             | Lấy chi tiết sản phẩm không tồn tại |

### Test Data Files

Test data được lưu trong các file CSV:
- `products-list.csv`: cho GET /api/products
- `products-search.csv`: cho GET /api/products/search
- `products-detail.csv`: cho GET /api/products/{id}

---

## Test Execution Results

### Test Execution Summary

| API Endpoint             | Total Tests | Passed | Failed | Success Rate |
| ------------------------ | ----------- | ------ | ------ | ------------ |
| GET /api/products        | 2           | 2      | 0      | 100%         |
| GET /api/products/search | 3           | 3      | 0      | 100%         |
| GET /api/products/{id}   | 2           | 2      | 0      | 100%         |
| **Total**                | **7**       | **7**  | **0**  | **100%**     |

### Detailed Results


#### GET /api/products Results
1. ✅ **Get_All_Products**: PASSED (200 OK)
2. ✅ **Get_Products_Pagination**: PASSED (200 OK)

#### GET /api/products/search Results
1. ✅ **Search_Valid_Keyword**: PASSED (200 OK)
2. ✅ **Search_Empty**: PASSED (200 OK)
3. ✅ **Search_Invalid_Keyword**: PASSED (200 OK)

#### GET /api/products/{id} Results
1. ✅ **Get_Product_Valid_ID**: PASSED (200 OK)
2. ✅ **Get_Product_Invalid_ID**: PASSED (404 Not Found)

---

## Step-by-step CI/CD Github Actions instructions

### Step 1 Create a new github repo and upload code


### Step 2: Tạo file workflow .github/workflows/api-tests.yml

Ví dụ nội dung:
```yaml
name: API Tests
on:
   push:
      branches: [main]
   pull_request:
      branches: [main]
jobs:
   test:
      runs-on: ubuntu-latest
      steps:
         - uses: actions/checkout@v3
         - name: Setup Node.js
            uses: actions/setup-node@v3
            with:
               node-version: 16
         - name: Install Newman
            run: npm install -g newman newman-reporter-htmlextra
         - name: Run Product API Tests
            run: |
               newman run "api/Product API Tests - Data Driven.postman_collection.json" \
                  -e "api/environment.json" \
                  --iteration-data "api/products-list.csv" \
                  --reporters cli,htmlextra \
                  --reporter-htmlextra-export "api/reports/products-list-report.html"
               newman run "api/Product API Tests - Data Driven.postman_collection.json" \
                  -e "api/environment.json" \
                  --iteration-data "api/products-search.csv" \
                  --reporters cli,htmlextra \
                  --reporter-htmlextra-export "api/reports/products-search-report.html"
               newman run "api/Product API Tests - Data Driven.postman_collection.json" \
                  -e "api/environment.json" \
                  --iteration-data "api/products-detail.csv" \
                  --reporters cli,htmlextra \
                  --reporter-htmlextra-export "api/reports/products-detail-report.html"
         - name: Upload Reports
            uses: actions/upload-artifact@v3
            with:
               name: api-test-reports
               path: api/reports/*.html
```

### Step 3 Commit and push

- Commit and push your code

### Step 4 Check on actions tab of github repo

![Alt text](./images/32.png)

### Step 5 Download result report

![Alt text](./images/33.png)

### Step 6 Extract zip file

![Alt text](./images/35.png)

### Step 7 Open report (html file)

![Alt text](./images/34.png)

### Implementation Overview

Automated API testing implemented using GitHub Actions with Newman CLI to execute Postman collections.


### Workflow Configuration
- **Trigger**: Push/pull request lên nhánh main
- **Environment**: Ubuntu-latest
- **Tools**: Newman CLI, Node.js 16
- **Test Collection**: Product API Tests - Data Driven

### Test Execution Strategy


Pipeline sẽ chạy 3 flow kiểm thử:
1. **GET /api/products** với file `products-list.csv`
2. **GET /api/products/search** với file `products-search.csv`
3. **GET /api/products/{id}** với file `products-detail.csv`

### Data-Driven Testing


- **CSV Files**: Test data lưu tại thư mục `api/`
- **Iteration Data**: Mỗi API sử dụng file CSV riêng

### Reporting & Artifacts


- **HTML Reports**: Sinh ra cho từng flow kiểm thử
- **Artifact Storage**: Lưu trữ kết quả trên GitHub
- **Failure Handling**: Báo lỗi nếu có test nào fail


### Benefits
- **Automated Validation**: Kiểm thử tự động mỗi lần code thay đổi
- **Consistent Results**: Kết quả kiểm thử nhất quán
- **Quick Feedback**: Phản hồi nhanh chóng

---

## AI Tools Usage (ChatGPT)


### Test Case Design Prompts

#### 1. Generate Test Scenarios
```
Generate comprehensive test scenarios for a REST API endpoint GET /api/products, GET /api/products/search, GET /api/products/{id}. Include positive, negative, and boundary tests. Use data-driven approach with CSV.
```

#### 2. Create Test Data
```
Create test data for API testing with the following requirements:
- 5 test cases for GET /api/products
- 5 test cases for GET /api/products/search
- 5 test cases for GET /api/products/{id}
- Format as CSV with columns: test_case, test_name, [search|id], expected_status, description
```

### CI/CD Prompts
```
Create a GitHub Actions workflow for API testing that:
- Runs on push to main branch
- Uses Newman to execute Postman collections with CSV data
- Generates HTML test reports
- Publishes results to GitHub
```

## Self-Assessment

### Assessment Criteria and Scores

| Criteria            | Description                            | Max Points | Self Assessment |     |
| ------------------- | -------------------------------------- | ---------- | --------------- | --- |
| **API1**            | POST /favorites testing                | 3.0        | 3.0             |     |
| **API2**            | GET /favorites testing                 | 3.0        | 3.0             |     |
| **API3**            | DELETE /favorites testing              | 3.0        | 3.0             |     |
| **Use of AI Tools** | Prompt transparency, validation, value | 1.0        | 1.0             |     |
| **Total**           |                                        | **10.0**   | **10.0**        |     |
