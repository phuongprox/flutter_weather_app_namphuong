# 🌤️ Flutter Weather App

## 🎯 Giới thiệu Dự án

Ứng dụng thời tiết này là một dự án cá nhân được xây dựng bằng Flutter, tập trung vào việc **tích hợp API**, **quản lý trạng thái phức tạp** , và áp dụng triết lý **Offline-First**.

Mục tiêu chính là tạo ra một ứng dụng đáng tin cậy, cung cấp thông tin thời tiết **thực tế** với giao diện người dùng **động**.


## ✨ Tổng hợp tính năng
### I. Dữ liệu thời tiết & dự báo

* **Thời tiết hiện tại:** Hiển thị nhiệt độ, "Feels like", icon, và mô tả chi tiết (Độ ẩm, áp suất, tốc độ gió, tầm nhìn).
* **Dự báo hàng giờ:** Chi tiết 24 giờ tiếp theo.
* **Dự báo hàng ngày:** Dự báo 5 ngày với nhiệt độ tối thiểu/tối đa.

### II. Quản lý vị trí & tìm kiếm

* **Vị trí tự động:** Tự động phát hiện vị trí hiện tại bằng GPS (`geolocator`)[cite: 658, 749].
* **Tìm kiếm thành phố:** Chức năng tìm kiếm linh hoạt theo tên thành phố[cite: 653].
* **Thành phố yêu thích:** Lưu trữ và quản lý tới **5** thành phố yêu thích[cite: 655, 761].

---

## 💻 Công nghệ Sử dụng

|  | Công cụ/Package | Ghi chú |
| :--- | :--- | :--- |
| **Kiến trúc** | **Provider** | Quản lý trạng thái ứng dụng (State Management). |
| **API** | **OpenWeatherMap** (Chính) | Cung cấp dữ liệu thời tiết. |
| **Bảo mật** | **`flutter_dotenv`** | Tải API Key từ file `.env` (không commit). |
| **Mạng/Cache** | `http`, `connectivity_plus`, `shared_preferences` | Xử lý HTTP requests, kiểm tra kết nối, và lưu trữ cache. |
| **Vị trí** | `geolocator`, `geocoding` | Xử lý GPS và dịch ngược tọa độ. |
| **Testing** | `mockito`, `flutter_test` | Hỗ trợ Unit Tests cho Service và Model. |

---

## ⚙️ Hướng dẫn Thiết lập Dự án

### 1. Tải Mã nguồn

```bash
git clone [https://github.com/phuongprox/flutter_weather_app_namphuong.git]
cd flutter_weather_app_namphuong
```
### 2. Cài đặt Phụ thuộc
```bash
Bash: flutter pub get
```
### 3. Thiết lập API Key (BẮT BUỘC) 
```bash
⚠️ Cảnh báo Bảo mật: Không được commit API Key lên GitHub.Lấy khóa API miễn phí từ OpenWeatherMap
Tạo file mới tên là .env ở thư mục gốc của dự án.Thêm khóa API vào file .env theo định dạng sau:Đoạn mã# .env
OPENWEATHER_API_KEY=YOUR_ACTUAL_OPENWEATHER_API_KEY_HERE
```
### 4. Chạy Ứng dụng
```bash
Bash: flutter run
```
---

<div align="center">

<img src="screenshot\home.png" width="100"/>
<img src="screenshot\loading.png" width="100"/>
<img src="screenshot\dark.png" width="100"/>
<img src="screenshot\search_screen.png" width="100"/>
<img src="screenshot\setting.png" width="100"/>
<img src="screenshot\temperature.png" width="100"/>
<img src="screenshot\windspeed.png" width="100"/>
<img src="screenshot\precipitation.png" width="100"/>
<img src="screenshot\cloud.png" width="100"/>
</div>
---
