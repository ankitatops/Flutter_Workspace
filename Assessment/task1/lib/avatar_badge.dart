import 'package:flutter/material.dart';

class AvatarBadge extends StatefulWidget {
  final String imageUrl;
  final bool isOnline;
  final double radius;

  const AvatarBadge({
    super.key,
    required this.imageUrl,
    this.isOnline = false,
    this.radius = 35,
  });

  @override
  State<AvatarBadge> createState() => _AvatarBadgeState();
}

class _AvatarBadgeState extends State<AvatarBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration:  Duration(seconds: 1))
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
        if (widget.isOnline)
          Positioned(
            bottom: 3,
            right: 3,
            child: ScaleTransition(
              scale: _animation,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
