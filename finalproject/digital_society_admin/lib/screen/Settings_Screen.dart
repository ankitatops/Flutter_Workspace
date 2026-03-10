import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final appState = MyApp.of(context)!;
    bool isDark = appState.isDark;

    return Scaffold(

      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Container(

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),

            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0,3),
              )
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Row(
                children: [

                  Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),

              Switch(
                value: isDark,

                activeColor: Colors.blue,

                onChanged: (value) {
                  appState.toggleTheme(value);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}