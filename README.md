
## Lưu ý
Project sử dụng flutter 3.0.5.
Thư viện quản lý state GetX

# Tạo file .env để chứa thông tin cấu hình project
- Tạo file '.env' cùng cấp với file env_source.txt.
- Copy tất cả nội dung từ file env_source.txt vào file '.env'.

# Điều hướng 
- Sử dụng app_navigator (./lib/app/global/app_navigator.dart);

# data
- Sử dụng json_serializable để tạo models và generate file model adapter.
- Sử dụng hive_box để xử lý và lưu cache cũng như generate ra file hive adapter tương ứng với mỗi model.
- Sử dụng retrofit kết hợp với dio để viết api và generate file api RetrofitGenerator.

- Để đồng thời generate tất cả các file adapter trong project, chạy lệnh:
flutter pub run build_runner build --delete-conflicting-outputs

# Ads

- Tích hợp quảng cáo của Google Admob, tất cả xử lý liên quan tới Admob Ads được viết tại (./lib/app/utils/ads_admob_utils.dart);
- Tích hợp quảng cáo của IronSource, tất cả xử lý liên quan tới Ironsource Ads được viết tại (./lib/app/utils/ads_ironsource_utils.dart);

- Để dễ dàng quản lý và tránh chồng chéo Ads sử dụng AdsController, AdsController sẽ tương tác trực tiếp với các views sử dụng quảng cáo (xem tại ./lib/ui/pages/ads/controller.dart).

# xử lý nghiệp vụ
- Các Widgets dùng chung được chứa tại ./lib/ui/components
- Mỗi một view/screen/page đều được chứa trong một thư mục tại  ./lib/ui/pages. Mỗi page này thì thường được chia làm 2 file controller.dart và [view].dart.
- controller.dart sẽ xử lý tất cả các logic nghiệp vụ phân tách hoàn toàn với UI là [view].dart.
