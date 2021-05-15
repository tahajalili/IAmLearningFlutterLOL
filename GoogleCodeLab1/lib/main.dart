import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Word Pair App",
      home: RandomWords(),
      );

  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
  final _saved = <WordPair>{};

  Widget _buildSuggestion(){
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context,  i){
        _suggestion.addAll(generateWordPairs().take(10));
        if(i.isOdd) return Divider(height: 40,);

        return _buildRow(_suggestion[i]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont  ,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite: Icons.favorite_border,
        color: alreadySaved? Colors.red: null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First App"),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestion(),
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final tiles = _saved.map((
              (WordPair pair){
                return ListTile(
                  title: Text(pair.asPascalCase,
                  style: _biggerFont,
                  ),

                );
              }
          )
          );
          final divided = tiles.isNotEmpty ? ListTile.divideTiles(context: context, tiles: tiles).toList(): <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: Text("Liked WordPairs"),
            ),
            body: ListView(children: divided,),
          );
        }

      )
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}
