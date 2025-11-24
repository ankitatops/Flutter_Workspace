import 'package:flutter/material.dart';

class MyModel extends StatelessWidget {
  var list;

  MyModel({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(list[index]["p_name"]),
          subtitle: Column(
            children: [
              Text(list[index]["p_price"]),
              //Image.network(list[index]["p_image"])
              Text(list[index]["p_des"]),
            ],
          ),
        );
      },
    );
  }
}
