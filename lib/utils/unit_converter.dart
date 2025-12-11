// đổi đơn vi
class UnitConverter {
  // C -> F
  static double toFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  static String formatTemperature(double tempInCelsius, bool isCelsius) {
    final temp = isCelsius ? tempInCelsius : toFahrenheit(tempInCelsius);
    return '${temp.round()}°${isCelsius ? 'C' : 'F'}';
  }
}
