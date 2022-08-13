import 'package:database_api_network/src/block/net_block.dart';
import 'package:database_api_network/src/model/net_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    netBlock.allDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<NetModel>>(
        stream: netBlock.getDatabase,
        builder: (context, snapshot) {
          List<NetModel> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  netBlock.deleteData(data[index].id);
                },
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Image.network(data[index].image),
                        Text(data[index].name),
                        Text(data[index].favourite.toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
