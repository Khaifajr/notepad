import 'dart:convert';
import 'package:notepad/helpers/api.dart';
import 'package:notepad/helpers/api_url.dart';
import 'package:notepad/model/catatan.dart';

class ProdukBloc {
  static Future<List<Catatan>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Catatan> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Catatan.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addProduk({Catatan? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {"title": produk!.title, "konten": produk.konten};

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateProduk({required Catatan produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    var body = {
      "kode_produk": produk.title,
      "nama_produk": produk.konten,
    };
    // ignore: avoid_print
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['code'] == 200;
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['code'] == 200;
  }
}
