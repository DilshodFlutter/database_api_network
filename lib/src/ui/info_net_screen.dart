import 'package:database_api_network/src/block/net_block.dart';
import 'package:database_api_network/src/model/net_model.dart';
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
      appBar: AppBar(),
      body: StreamBuilder<List<NetModel>>(
        stream: netBlock.getNetData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NetModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Image.network(data[index].image),
                      const SizedBox(height: 10.0),
                      Text(data[index].name),
                      const SizedBox(height: 10.0),
                      Text(data[index].fullName),
                      const SizedBox(height: 10.0),
                      Text(data[index].slug),
                      const SizedBox(height: 10.0),
                      Text(data[index].price.toString()),
                      const SizedBox(height: 10.0),
                      Text(data[index].drugId.toString()),
                    ],
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