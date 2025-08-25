#!/bin/bash

# Product API Tests Runner - Data Driven
# Chạy test cho 3 API với data-driven testing

# Default values
API_TYPE="all"
OUTPUT_DIR="reports"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --api-type)
            API_TYPE="$2"
            shift 2
            ;;
        --output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [--api-type all|list|search|detail] [--output-dir reports]"
            echo ""
            echo "Options:"
            echo "  --api-type     API type to test (default: all)"
            echo "  --output-dir   Output directory for reports (default: reports)"
            echo "  -h, --help     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Tạo thư mục reports nếu chưa có
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
COLLECTION_FILE="collection.json"
ENVIRONMENT_FILE="environment.json"

echo "🚀 Product API Tests - Data Driven Testing"
echo "=========================================="
echo "Timestamp: $TIMESTAMP"
echo ""

# Function để chạy test cho một API
run_api_test() {
    local api_name="$1"
    local csv_file="$2"
    local description="$3"
    
    echo "📋 Testing $description..."
    
    local html_report="$OUTPUT_DIR/${api_name}_report_$TIMESTAMP.html"
    
    if newman run "$COLLECTION_FILE" \
        -e "$ENVIRONMENT_FILE" \
        --iteration-data "$csv_file" \
        --reporters cli,htmlextra \
        --reporter-htmlextra-export "$html_report" \
        --silent; then
        
        echo "✅ $description completed successfully"
        echo "   📊 HTML Report: $html_report"
    else
        echo "❌ $description failed"
    fi
    
    echo ""
}

# Kiểm tra Newman có được cài đặt không
if ! command -v newman &> /dev/null; then
    echo "❌ Newman not found. Please install with: npm install -g newman newman-reporter-htmlextra newman-reporter-junit"
    exit 1
fi

NEWMAN_VERSION=$(newman --version)
echo "✅ Newman version: $NEWMAN_VERSION"

# Kiểm tra các file cần thiết
REQUIRED_FILES=("$COLLECTION_FILE" "$ENVIRONMENT_FILE" "products-list.csv" "products-search.csv" "products-detail.csv")
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "❌ Required file not found: $file"
        exit 1
    fi
done

echo "✅ All required files found"
echo ""

# Chạy test theo loại API được chọn
case "$API_TYPE" in
    "list")
        run_api_test "products-list" "products-list.csv" "GET /api/products (Danh sách sản phẩm)"
        ;;
    "search")
        run_api_test "products-search" "products-search.csv" "GET /api/products/search (Tìm kiếm sản phẩm)"
        ;;
    "detail")
        run_api_test "products-detail" "products-detail.csv" "GET /api/products/{id} (Chi tiết sản phẩm)"
        ;;
    "all")
        echo "🔄 Running all API tests..."
        echo ""
        
        run_api_test "products-list" "products-list.csv" "GET /api/products (Danh sách sản phẩm)"
        run_api_test "products-search" "products-search.csv" "GET /api/products/search (Tìm kiếm sản phẩm)"
        run_api_test "products-detail" "products-detail.csv" "GET /api/products/{id} (Chi tiết sản phẩm)"
        
        echo "🎉 All tests completed!"
        ;;
    *)
        echo "❌ Invalid API type: $API_TYPE"
        echo "Usage: $0 --api-type [all|list|search|detail]"
        exit 1
        ;;
esac

echo ""
echo "📁 Reports generated in: $OUTPUT_DIR"
echo "📊 Open HTML reports in your browser to view detailed results"
echo ""
echo "🔧 To run specific API tests:"
echo "   $0 --api-type list    # Test GET /api/products"
echo "   $0 --api-type search  # Test GET /api/products/search"
echo "   $0 --api-type detail  # Test GET /api/products/{id}"
echo "   $0 --api-type all     # Test all APIs (default)" 