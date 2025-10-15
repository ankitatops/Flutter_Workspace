import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: ProfileCardApp(), debugShowCheckedModeBanner: false),
  );
}

class ProfileCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Card Example'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Profile card at the very top (no padding/margin)
          ProfileCard(),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-600nw-2558760599.jpg",
              ),
              radius: 50,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' Ankita',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Mobile App Developer passionate about Flutter and UI design.!',
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.teal),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
