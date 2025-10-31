import 'package:flutter/material.dart';





class status extends StatefulWidget {
  const status({super.key});

  @override
  State<status> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<status> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatar Badge with Switch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarBadge(
              imageUrl: 'https://i.pravatar.cc/150?img=10',
              isOnline: _isOnline,
              showStatus: true,
              radius: 50,
            ),

            const SizedBox(height: 30),

            Text(
              _isOnline ? 'User is ONLINE 🟢' : 'User is OFFLINE 🔴',
              style: TextStyle(
                fontSize: 18,
                color: _isOnline ? Colors.green : Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text('Toggle Online Status'),
              value: _isOnline,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.redAccent,
              onChanged: (value) {
                setState(() {
                  _isOnline = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarBadge extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;
  final bool showStatus;
  final double radius;

  const AvatarBadge({
    Key? key,
    required this.imageUrl,
    this.isOnline = false,
    this.showStatus = true,
    this.radius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.grey[300],
        ),

        if (showStatus)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: radius / 3,
              height: radius / 3,
              decoration: BoxDecoration(
                color: isOnline ? Colors.green : Colors.redAccent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
