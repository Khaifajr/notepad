class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2/toko-toko/public';

  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listProduk = '$baseUrl/catatan';
  static const String createProduk = '$baseUrl/catatan';

  static String updateProduk(int id) {
    return '$baseUrl/catatan/$id/update';
  }

  static String showProduk(int id) {
    return '$baseUrl/catatan/$id';
  }

  static String deleteProduk(int id) {
    return '$baseUrl/catatan/$id';
  }
}
