import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_random_word/bloc/words_bloc.dart';
import 'package:get_random_word/models/words.dart';
import 'package:get_random_word/widget/add_word.dart';
import 'package:get_random_word/widget/alert.dart';
import 'package:get_random_word/widget/list_word.dart';

class ShowWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowWordState();
  }
}

class _ShowWordState extends State<ShowWord> {
  final _random = Random();

  var words = <Words>[];
  String newWord = "İNGİLİZCE KELİME";
  String turkishTranslate = "TÜRKÇE KELİME";
  String newWordAlertText = "Daha önce kelime eklememişsiniz. Kelime ekleyin";
  String translateAlertText = "Türkçeye çevirilecek herhangi bir kelime yok";
  Words? randomWord;

  @override
  void initState() {
    super.initState();
    initialWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text("Random Word"),
        actions: <Widget>[
          TextButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                goToAddWord();
              }),
          TextButton(
              child: const Icon(Icons.list_alt_outlined, color: Colors.white),
              onPressed: () {
                goToListWord();
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [englishWordText(), turkishWordText()],
              ),
              Column(
                children: [newWordButton(), showTranslateButton()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget englishWordText() {
    return Container(
      margin: const EdgeInsets.all(7.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
              style: BorderStyle.solid, color: Colors.green, width: 10),
          borderRadius: BorderRadius.circular(15.0)),
      child: Text(
        newWord,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontFamily: "Times New Roman"),
      ),
    );
  }

  Widget turkishWordText() {
    return Container(
      margin: const EdgeInsets.all(7.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
              style: BorderStyle.solid, color: Colors.grey, width: 10),
          borderRadius: BorderRadius.circular(15.0)),
      child: Text(
        turkishTranslate,
        textWidthBasis: TextWidthBasis.longestLine,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontFamily: "Times New Roman"),
      ),
    );
  }

  Widget newWordButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (words.isEmpty) {
              Alert.alertEmptyWordsList(context, newWordAlertText);
            } else {
              randomWord = getRandomWord();
              newWord = randomWord!.englishWord;
              turkishTranslate = "Kelimenin Türkçesi";
            }
          });
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.amber[800],
        ),
        child: const Text("Yeni kelime"),
      ),
    );
  }

  Widget showTranslateButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (randomWord == null) {
              Alert.alertEmptyWordsList(context, translateAlertText);
            } else {
              turkishTranslate = randomWord!.turkishWord;
            }
          });
        },
        style: ElevatedButton.styleFrom(primary: Colors.amber[800]),
        child: const Text("Kelimenin Türkçesi"),
      ),
    );
  }

  goToAddWord() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddWord()));
    initialWords();
  }

  goToListWord() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListWord()));
    initialWords();
  }

  Words getRandomWord() {
    var randomWord = words[_random.nextInt(words.length)];
    return randomWord;
  }

  void initialWords() async {
    var wordsFuture = await WordsBloc.getWords();
    setState(() {
      newWord = "İNGİLİZCE KELİME";
      turkishTranslate = "TÜRKÇE KELİME";
      words = wordsFuture.cast();
      randomWord = null;
    });
  }
}
