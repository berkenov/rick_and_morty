import 'package:flutter/material.dart';
import 'package:ygroup/data/entity/character.entity.dart';
import 'package:ygroup/data/entity/episode.entity.dart';
import 'package:ygroup/data/repository/character.repository.dart';
import 'package:ygroup/ui/common/widget/ui_utils.dart';
import 'package:ygroup/ui/screen/character/widget/episode.widget.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 150.0,
                backgroundImage: NetworkImage(widget.character.image),
                backgroundColor: Colors.grey,
              ),
            ),
            verticalSpace(10),
            Text(
              widget.character.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            verticalSpace(10),
            _buildStatus(),
            verticalSpace(10),
            _buildGender(),
            Expanded(
              child: _buildEpisodes(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGender() {
    const textStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Gender: ",
          style: textStyle,
        ),
        Text(widget.character.gender,
            style: textStyle.copyWith(
              color: widget.character.isMale ? Colors.blueAccent : Colors.pink,
            )),
      ],
    );
  }

  Widget _buildStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.character.isAlive ? Colors.green : Colors.red,
      ),
      child: Text(
        widget.character.status,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  Widget _buildEpisodes() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Episodes",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.deepOrange),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: widget.character.episode.length,
              separatorBuilder: (BuildContext context, int index) => verticalSpace(10),
              itemBuilder: (context, index) {
                final url = widget.character.episode[index];
                return Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: FutureBuilder<Episode>(
                    future: CharacterRepository.getEpisode(url: url),
                    builder: (context, state) {
                      if (state.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.connectionState == ConnectionState.done) {
                        final episode = state.data;
                        if (episode != null) {
                          return EpisodeItem(episode: episode);
                        }
                      }
                      return const Text("Error download");
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
