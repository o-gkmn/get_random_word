import 'package:flutter/material.dart';
import 'package:get_random_word/validator/add_word_validate.dart';

import '../bloc/words_bloc.dart';
import '../models/words.dart';

class UpdateScreen extends StatefulWidget {
  late Words word;

  UpdateScreen.empty();
  UpdateScreen(this.word);

  @override
  State<StatefulWidget> createState() {
    return _UpdateScreenState(word);
  }
}

class _UpdateScreenState extends State<UpdateScreen> with AddWordValidateMixin {
  Words word;
  _UpdateScreenState(this.word);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext con0text) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Güncelle"),
        backgroundColor: Colors.amber[800],
      ),
      body: updateBody(),
      backgroundColor: Colors.amber[100],
    );
  }

  Widget updateBody() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            englishWordField(),
            turkishWordField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                saveButton(),
                deleteButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget englishWordField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        initialValue: word.englishWord,
        decoration: InputDecoration(
          labelText: "İngilizce kelime",
          hintText: word.englishWord,
        ),
        onSaved: (String? value) {
          word.englishWord = value!;
        },
      ),
    );
  }

  Widget turkishWordField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        initialValue: word.turkishWord,
        decoration: InputDecoration(
          labelText: "Türkçe kelime",
          hintText: word.turkishWord,
        ),
        onSaved: (String? value) {
          word.turkishWord = value!;
        },
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          if (formKey.currentState != null &&
              formKey.currentState!.validate()) {
            formKey.currentState!.save();
            WordsBloc.update(word);
            Navigator.pop(context);
          }
        },
        child: const Text("Güncelle"),
      ),
    );
  }

  Widget deleteButton() {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 20,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: () {
            WordsBloc.remove(word.id!);
            Navigator.pop(context);
          },
          child: const Text("Sil")),
    );
  }
}
