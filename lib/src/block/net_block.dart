import 'package:database_api_network/src/api/provider.dart';
import 'package:database_api_network/src/database/database_helper.dart';
import 'package:database_api_network/src/model/net_model.dart';
import 'package:rxdart/subjects.dart';

class NetBlock {
  DatabaseHelper databaseHelper = DatabaseHelper();
  AppProvider appProvider = AppProvider();

  final _fetchNetData = PublishSubject<List<NetModel>>();
  final _fetchDatabase = PublishSubject<List<NetModel>>();

  Stream<List<NetModel>> get getNetData => _fetchNetData.stream;

  Stream<List<NetModel>> get getDatabase => _fetchDatabase.stream;
  List<NetModel> data = [];

  allNetInfo() async {
    data = await appProvider.getNetData();
    compare(data);
  }

  allDatabase() async {
    List<NetModel> database = await databaseHelper.getData();
    _fetchDatabase.sink.add(database);
  }

  compare(List<NetModel> data) async {
    List<NetModel> database = await databaseHelper.getData();
    for (int i = 0; i < data.length; i++) {
      data[i].favourite = false;
      for (int j = 0; j < database.length; j++) {
        if (data[i].id == database[j].id) {
          data[i].favourite = true;
          break;
        }
      }
    }
    _fetchNetData.sink.add(data);
  }

  Future<int> saveData(NetModel save) async {
    int id = await databaseHelper.saveData(save);
    compare(data);
    return id;
  }

  Future<int> updateData(NetModel products) async {
    int id = await databaseHelper.updateData(products);
    allNetInfo();
    return id;
  }

  Future<int> deleteData(int delData) async {
    int id = await databaseHelper.deleteData(delData);
    compare(data);
    allDatabase();
    return id;
  }
}

final netBlock = NetBlock();
