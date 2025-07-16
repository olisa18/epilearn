import 'dart:math';

import 'package:flutter/material.dart';

class CircularLoader extends StatefulWidget {
  final double size;
  final Color color;

  const CircularLoader({
    Key? key,
    this.size = 50,
    this.color = Colors.deepPurple,
  }) : super(key: key);

  @override
  _CircularLoaderState createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const int circleCount = 8;
  static const double circleSize = 8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCircle(int index) {
    final double angle = (2 * pi * index) / circleCount;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final double progress = _controller.value;
        final double rotation = 2 * pi * progress;

        final double currentAngle = angle + rotation;
        final double radius = widget.size / 2 - circleSize;

        final double opacityPhase = ((index / circleCount) - progress + 1) % 1;

        final double opacity =
            0.3 + 0.7 * (1 - (2 * (opacityPhase - 0.5)).abs());

        return Transform.translate(
          offset: Offset(
            radius * cos(currentAngle),
            radius * sin(currentAngle),
          ),
          child: Opacity(
            opacity: opacity.clamp(0.3, 1.0),
            child: child,
          ),
        );
      },
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(circleCount, (index) => _buildCircle(index)),
        ),
      ),
    );
  }
}
