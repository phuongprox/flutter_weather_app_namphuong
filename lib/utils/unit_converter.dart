/// Chứa các hàm tiện ích để chuyển đổi đơn vị.
class UnitConverter {
  /// Chuyển đổi nhiệt độ từ Celsius sang Fahrenheit.
  static double toFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  /// Định dạng chuỗi nhiệt độ dựa trên đơn vị được chọn.
  ///
  /// [isCelsius] là true nếu đơn vị là Celsius.
  /// [tempInCelsius] là nhiệt độ tính bằng Celsius.
  static String formatTemperature(double tempInCelsius, bool isCelsius) {
    final temp = isCelsius ? tempInCelsius : toFahrenheit(tempInCelsius);
    return '${temp.round()}°${isCelsius ? 'C' : 'F'}';
  }
}
