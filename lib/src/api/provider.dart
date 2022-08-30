import 'dart:convert';

import 'package:database_api_network/src/model/net_model.dart';
import 'package:http/http.dart' as hhtp;

class AppProvider {
  static String baseUrl =
      "https://api.osonapteka.uz/api/v1/history?lan=ru&region=21";

  Future<List<NetModel>> getNetData() async {
    String url = baseUrl;
    hhtp.Response response = await hhtp.get(Uri.parse(url));
    final netModel = netModelFromJson(utf8.decode(response.body.codeUnits));
    return netModel;
  }
}
