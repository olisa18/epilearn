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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search Episodes...',
          hintStyle: TextStyle(color: Colors.orangeAccent.withAlpha(180)),
          filled: true,
          fillColor: Colors.black54,
          prefixIcon: const Icon(Icons.search, color: Colors.orangeAccent),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.orangeAccent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
