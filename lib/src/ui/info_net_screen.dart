import 'package:database_api_network/src/block/net_block.dart';
import 'package:database_api_network/src/model/net_model.dart';
import 'package:database_api_network/src/ui/favourite/favourite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetInfoScreen extends StatefulWidget {
  const NetInfoScreen({Key? key}) : super(key: key);

  @override
  State<NetInfoScreen> createState() => _NetInfoScreenState();
}

class _NetInfoScreenState extends State<NetInfoScreen> {
  @override
  void initState() {
    super.initState();
    netBlock.allNetInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const FavouriteScreen();
                },
              ),
            );
          },
          child: Text("Favourite"),
        ),
      ),
      body: StreamBuilder<List<NetModel>>(
        stream: netBlock.getNetData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NetModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (data[index].favourite) {
                      netBlock.deleteData(data[index].id);
                    } else {
                      netBlock.saveData(data[index]);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Image.network(data[index].image),
                        const SizedBox(height: 10.0),
                        Text(data[index].name),
                        const SizedBox(height: 10.0),
                        Text(data[index].favourite.toString()),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center();
        },
      ),
    );
  }
}
