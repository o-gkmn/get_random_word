import 'package:flutter/material.dart';
import 'package:get_random_word/bloc/words_bloc.dart';
import 'package:get_random_word/models/words.dart';
import 'package:get_random_word/widget/update_word.dart';

class ListWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListWordState();
  }
}

class _ListWordState extends State {
  var words = <Words>[];

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
        title: const Text("Kelime Listesi"),
      ),
      body: Container(
        color: Colors.amber[100],
        padding: const EdgeInsets.only(top: 15.0, left: 3.0, right: 3.0),
        child: ListView.builder(
          itemCount: words.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Colors.grey[300],
              child: ListTile(
                onTap: () {
                  goToUpdate(words[index]);
                },
                title: Text(words[index].englishWord),
                subtitle: Text(words[index].turkishWord),
              ),
            );
          },
        ),
      ),
    );
  }

  goToUpdate(Words word) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateScreen(word)));
    initialWords();
  }

  void initialWords() async {
    var wordsFuture = await WordsBloc.getWords();
    setState(() {
      words = wordsFuture.cast();
    });
  }
}
