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
    const Color accentColor = Color(0xFF00FF9F);

    const Gradient titleGradient = LinearGradient(
      colors: [
        Color(0xFF2AF598),
        Color(0xFF009EFD),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Card(
      color: Colors.black.withAlpha(150),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSaved ? accentColor : Colors.transparent,
          width: 2.5,
        ),
      ),
      elevation: 12,
      shadowColor: accentColor.withAlpha(100),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: accentColor.withAlpha(64),
        highlightColor: accentColor.withAlpha(32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => titleGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: Text(
                        episode.name,
                        style: const TextStyle(
                          fontFamily: 'ComicSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: accentColor,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      episode.episode,
                      style: TextStyle(
                        fontFamily: 'ComicSans',
                        fontSize: 17,
                        color: Colors.cyan[200]?.withAlpha(217),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      episode.airDate,
                      style: TextStyle(
                        fontFamily: 'ComicSans',
                        fontSize: 14,
                        color: Colors.cyan[100]?.withAlpha(153),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Container(
                  key: ValueKey<bool>(isSaved),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSaved
                        ? RadialGradient(
                            colors: [
                              accentColor.withAlpha(77),
                              Colors.transparent,
                            ],
                            radius: 0.8,
                          )
                        : null,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? accentColor : Colors.cyan[100],
                      size: 30,
                      shadows: const [
                        Shadow(
                          blurRadius: 14,
                          color: accentColor,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    onPressed: onSave,
                    splashRadius: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
