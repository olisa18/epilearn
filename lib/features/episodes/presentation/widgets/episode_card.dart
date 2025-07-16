import 'package:flutter/material.dart';
import 'package:epilearn/features/episodes/domain/episode_model.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeModel episode;
  final VoidCallback? onTap;
  final VoidCallback? onSave;
  final bool isSaved;

  const EpisodeCard({
    super.key,
    required this.episode,
    this.onTap,
    this.onSave,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSaved ? Colors.orangeAccent : Colors.transparent,
            width: 3,
          )),
      elevation: 6,
      shadowColor: Colors.orangeAccent.withOpacity(0.6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.orange.withValues(alpha: 0.3),
        highlightColor: Colors.orange.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name,
                      style: const TextStyle(
                        fontFamily: 'ComicSans',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.orangeAccent,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.deepOrange,
                            offset: Offset(1, 1),
                          )
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      episode.episode,
                      style: TextStyle(
                        fontFamily: 'ComicSans',
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      episode.airDate,
                      style: TextStyle(
                        fontFamily: 'ComicSans',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: IconButton(
                  key: ValueKey<bool>(isSaved),
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? Colors.yellowAccent : Colors.grey[400],
                    size: 30,
                    shadows: const [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.yellow,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
