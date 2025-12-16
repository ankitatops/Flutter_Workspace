import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxex/controllers/counter_controller.dart';
import 'second_page.dart';

class HomePage extends StatelessWidget {
  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Example")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// STATE MANAGEMENT
              Obx(
                () => Text(
                  "Counter: ${controller.count}",
                  style: TextStyle(fontSize: 30),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: controller.increment,
                child: Text("Increment"),
              ),

              ElevatedButton(
                onPressed: controller.decrement,
                child: Text("Decrement"),
              ),

              Divider(height: 30),

              /// NAVIGATION
              ElevatedButton(
                onPressed: () {
                  Get.to(SecondPage());
                },
                child: Text("Go to Second Page"),
              ),

              /// SNACKBAR
              ElevatedButton(
                onPressed: () {
                  Get.snackbar("Hello", "This is GetX Snackbar", snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.blue,colorText: Colors.white, margin: EdgeInsets.all(12));
                },
                child: Text("Show Snackbar"),
              ),

              /// DIALOG
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    barrierDismissible: false,
                    title: "Dialog",
                    middleText: "This is GetX Dialog",
                    backgroundColor: Colors.white,
                    titleStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    middleTextStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    radius: 12,
                    textConfirm: "OK",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.blue,
                    onConfirm: () => Get.back(),
                  );
                },
                child: Text("Show Dialog"),
              ),

              /// BOTTOM SHEET
              ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Bottom Sheet",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () => Get.back(),
                            child: Text("Close"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text("Show Bottom Sheet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
