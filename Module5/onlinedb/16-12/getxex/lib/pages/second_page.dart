import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxex/controllers/counter_controller.dart';


class SecondPage extends StatelessWidget {
  final CounterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: Obx(() => Text(
          "Counter: ${controller.count}",
          style: TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}
