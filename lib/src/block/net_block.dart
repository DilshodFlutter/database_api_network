
import 'package:database_api_network/src/api/provider.dart';
import 'package:database_api_network/src/database/database_helper.dart';
import 'package:database_api_network/src/model/net_model.dart';
import 'package:rxdart/subjects.dart';

class NetBlock {
  DatabaseHelperNew databaseHelper = DatabaseHelperNew();
  AppProvider appProvider = AppProvider();

  final _fetchNetData = PublishSubject<List<NetModel>>();

  Stream<List<NetModel>> get getNetData => _fetchNetData.stream;

  allNetInfo() async {

    List<NetModel> data = await appProvider.getNetData();
    _fetchNetData.sink.add(data);
  }

  Future<int> saveData(NetModel update) async {
    int id = await databaseHelper.saveData(update);
    allNetInfo();
    return id;
  }

  Future<int> updateData(NetModel products) async {
    int id = await databaseHelper.updateData(products);
    allNetInfo();
    return id;
  }

  Future<int> deleteData(int delete) async {
    int id = await databaseHelper.deleteData(delete);
    allNetInfo();
    return id;
  }
}

final netBlock = NetBlock();
