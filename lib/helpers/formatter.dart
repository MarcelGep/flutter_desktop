class Formatter {
  static String createCurrencyString(double price) {
    return price.toString().replaceAll('.', ',') + ' €';
  }

  static double createDoubleFromCurrencyString(String value) {
    return double.parse(value.split('€')[0].trim().replaceAll(',', '.'));
  }
}
