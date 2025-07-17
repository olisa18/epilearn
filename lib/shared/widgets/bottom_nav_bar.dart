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
    final Shader neonGradient = const LinearGradient(
      colors: [
        Color(0xFF00FFAA),
        Color(0xFF00FFF7),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(const Rect.fromLTWH(0, 0, 200, 70));

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF12182C), Color(0xFF0D1121)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color:
                const Color.fromARGB(166, 0, 255, 247).withValues(alpha: 0.2),
            blurRadius: 16,
            spreadRadius: 4,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          fontWeight: FontWeight.bold,
          fontSize: 16,
          shadows: [
            Shadow(
              color: Color(0xFF00FFF7),
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'ComicSans',
          fontSize: 14,
          color: Colors.grey,
        ),
        items: [
          BottomNavigationBarItem(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                return currentIndex == 0
                    ? neonGradient
                    : const LinearGradient(
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
                return currentIndex == 1
                    ? neonGradient
                    : const LinearGradient(
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
