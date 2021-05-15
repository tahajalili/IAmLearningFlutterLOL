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

  Widget _buildSuggestion(){
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (context,  i){
        _suggestion.addAll(generateWordPairs().take(10));
        if(i.isOdd) return Divider(height: 40,);

        final index = i ~/ 2;

        return _buildRow(_suggestion[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair){
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont  ,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First App"),
      ),
      body: _buildSuggestion(),
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

