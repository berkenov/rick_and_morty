import 'package:flutter/material.dart';
import 'package:ygroup/data/entity/episode.entity.dart';

class EpisodeItem extends StatelessWidget {
  final Episode episode;

  const EpisodeItem({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          episode.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        Text("Date: ${episode.airDate}"),
        Text("Episode: ${episode.episode}")

      ],
    );
  }
}
