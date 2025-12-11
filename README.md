# 🌤️ Flutter Weather App

## 🎯 Giới thiệu Dự án

[cite_start]Ứng dụng thời tiết này là một dự án cá nhân được xây dựng bằng Flutter, tập trung vào việc **tích hợp API** [cite: 5, 747][cite_start], **quản lý trạng thái phức tạp** [cite: 750][cite_start], và áp dụng triết lý **Offline-First**[cite: 752].

[cite_start]Mục tiêu chính là tạo ra một ứng dụng đáng tin cậy, cung cấp thông tin thời tiết **thực tế** với giao diện người dùng **động**[cite: 753].


## ✨ Tổng hợp tính năng
### I. Dữ liệu thời tiết & dự báo

* [cite_start]**Thời tiết hiện tại:** Hiển thị nhiệt độ, "Feels like", icon, và mô tả chi tiết (Độ ẩm, áp suất, tốc độ gió, tầm nhìn) [cite: 634-644].
* [cite_start]**Dự báo hàng giờ:** Chi tiết 24 giờ tiếp theo[cite: 648].
* [cite_start]**Dự báo hàng ngày:** Dự báo 5 ngày với nhiệt độ tối thiểu/tối đa [cite: 649-650].

### II. Quản lý vị trí & tìm kiếm

* [cite_start]**Vị trí tự động:** Tự động phát hiện vị trí hiện tại bằng GPS (`geolocator`)[cite: 658, 749].
* [cite_start]**Tìm kiếm thành phố:** Chức năng tìm kiếm linh hoạt theo tên thành phố[cite: 653].
* [cite_start]**Thành phố yêu thích:** Lưu trữ và quản lý tới **5** thành phố yêu thích[cite: 655, 761].

---

## 💻 Công nghệ Sử dụng

|  | Công cụ/Package | Ghi chú |
| :--- | :--- | :--- |
| **Kiến trúc** | **Provider** | [cite_start]Quản lý trạng thái ứng dụng (State Management)[cite: 89, 750]. |
| **API** | **OpenWeatherMap** (Chính) | [cite_start]Cung cấp dữ liệu thời tiết[cite: 26]. |
| **Bảo mật** | **`flutter_dotenv`** | [cite_start]Tải API Key từ file `.env` (không commit) [cite: 93, 736-737]. |
| **Mạng/Cache** | `http`, `connectivity_plus`, `shared_preferences` | [cite_start]Xử lý HTTP requests, kiểm tra kết nối, và lưu trữ cache[cite: 86, 90, 94]. |
| **Vị trí** | `geolocator`, `geocoding` | [cite_start]Xử lý GPS và dịch ngược tọa độ [cite: 87-88]. |
| **Testing** | `mockito`, `flutter_test` | [cite_start]Hỗ trợ Unit Tests cho Service và Model[cite: 96, 98]. |

---

## ⚙️ Hướng dẫn Thiết lập Dự án

### 1. Tải Mã nguồn

```bash
git clone [https://github.com/](https://github.com/)[Tên người dùng của bạn]/flutter_weather_app_[tên bạn].git
cd flutter_weather_app_[tên bạn]
2. Cài đặt Phụ thuộcBashflutter pub get
3. Thiết lập API Key (BẮT BUỘC) 1⚠️ Cảnh báo Bảo mật: Không được commit API Key lên GitHub.Lấy khóa API miễn phí từ OpenWeatherMap2.Tạo file mới tên là .env ở thư mục gốc của dự án.Thêm khóa API vào file .env theo định dạng sau:Đoạn mã# .env
OPENWEATHER_API_KEY=YOUR_ACTUAL_OPENWEATHER_API_KEY_HERE
4. Chạy Ứng dụngBashflutter run
📸 Ảnh chụp Màn hình (Screenshots)(Vui lòng thay thế các placeholder này bằng ảnh chụp thực tế của ứng dụng bạn)Trạng tháiMô tảClear/SunnyGiao diện nền màu sáng (vàng/xanh dương)3.RainyGiao diện nền màu tối/xám4.CloudyGiao diện nền màu sáng xám5.Night ModeGiao diện nền màu xanh đậm/gần đen6.Search ScreenHiển thị ô tìm kiếm và danh sách thành phố yêu thích7.Error StateMàn hình hiển thị ErrorWidgetCustom8.Loading StateMàn hình hiển thị hiệu ứng LoadingShimmer9.📈 Cải tiến và Bonus FeaturesUnit Tests Mở rộng: Bao gồm kiểm thử cho ForecastModel và LocationService.AQI: Tích hợp Chỉ số Chất lượng Không khí (AQI)10.Multi-API Fallback: Xây dựng logic sử dụng khóa dự phòng (WEATHER_API_KEY) nếu API chính lỗi11.Weather Animations: Thay thế icon tĩnh bằng hoạt ảnh12121212.
