import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          alignment: Alignment.center,
          children: [
          Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
        ),
        Positioned(
          top: 150,
          child: CircleAvatar(
            radius: 70,
            backgroundImage: const NetworkImage(
              'https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-600nw-2558760599.jpg',
            ),
            backgroundColor: Colors.grey[300],
          ),
        ),

        Positioned(
            top: 300,
            child: Column(
                children: const [
                Text(
                    'Ankita Gondaliya',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                ),
                  SizedBox(height: 10),
                  Text(
                    'Flutter Developer ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
            ),
        ),
          ],
        ),
    );
  }
}
