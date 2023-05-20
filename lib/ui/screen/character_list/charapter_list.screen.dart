import 'package:flutter/material.dart';
import 'package:ygroup/data/entity/character.entity.dart';
import 'package:ygroup/data/repository/character.repository.dart';
import 'package:ygroup/ui/screen/character_list/widget/character_item.widget.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late ScrollController _scrollController;
  final List<Character> _characters = [];
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        final newCharacters = await CharacterRepository.getCharacterList(page: _page);
        setState(() {
          _characters.addAll(newCharacters);
          _page++;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
      ),
      body: (_isLoading && _characters.isEmpty)
          ? progressWidget()
          : ListView.builder(
              controller: _scrollController,
              itemCount: _characters.length + 1,
              itemBuilder: (context, index) {
                if (index < _characters.length) {
                  final character = _characters[index];
                  return CharacterItem(character: character);
                } else if (_isLoading) {
                  return progressWidget();
                }
              },
            ),
    );
  }

  Widget progressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
