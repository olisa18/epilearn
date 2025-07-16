import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Gradient shader for selected icon and label
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xFFFFA726), Color(0xFFFFD54F)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A1A), Color(0xFF2C2C2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orangeAccent.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent, // use container gradient
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          fontWeight: FontWeight.bold,
          fontSize: 14,
          shadows: [
            Shadow(
              color: Colors.deepOrange,
              blurRadius: 6,
              offset: Offset(1, 1),
            ),
          ],
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          fontSize: 12,
          color: Colors.grey,
        ),
        showUnselectedLabels: true,
        elevation: 0, // remove default shadow; we add our own above
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                if (currentIndex == 0) {
                  return linearGradient;
                }
                return const LinearGradient(
                  colors: [Colors.grey, Colors.grey],
                ).createShader(bounds);
              },
              child: Icon(
                Icons.list,
                color: currentIndex == 0 ? Colors.white : Colors.grey[600],
              ),
            ),
            label: 'Episodes',
          ),
          BottomNavigationBarItem(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                if (currentIndex == 1) {
                  return linearGradient;
                }
                return const LinearGradient(
                  colors: [Colors.grey, Colors.grey],
                ).createShader(bounds);
              },
              child: Icon(
                Icons.bookmark,
                color: currentIndex == 1 ? Colors.white : Colors.grey[600],
              ),
            ),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
