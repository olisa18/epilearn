import 'package:flutter/material.dart';

class EpisodeSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const EpisodeSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        style: const TextStyle(
          color: Color(0xFF00FFF7),
          fontFamily: 'ComicSans',
          fontSize: 16,
        ),
        cursorColor: const Color(0xFF00FFF7),
        decoration: InputDecoration(
          hintText: 'Search Episodes...',
          hintStyle: TextStyle(
            color: const Color(0xFF00FFF7).withValues(alpha: 0.5),
            fontFamily: 'ComicSans',
          ),
          filled: true,
          fillColor: const Color(0xFF12182C),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF00FFF7)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: const Color(0xFF00FFF7).withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF00FFF7),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
