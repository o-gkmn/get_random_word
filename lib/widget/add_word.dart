import 'package:flutter/material.dart';
import 'package:get_random_word/bloc/words_bloc.dart';
import 'package:get_random_word/models/words.dart';
import 'package:get_random_word/validator/add_word_validate.dart';

class AddWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddWordState();
  }
}

class _AddWordState extends State with AddWordValidateMixin {
  var formKey = GlobalKey<FormState>();
  var word = Words.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: const Text("Kelime Ekle"),
        backgroundColor: Colors.amber[800],
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                englishWordField(),
                turkishWordField(),
                saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget englishWordField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        decoration: const InputDecoration(
          labelText: "İngilizce kelime",
          hintText: "Buraya yazın",
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
        decoration: const InputDecoration(
          labelText: "Türkçe kelime",
          hintText: "Buraya yazın",
        ),
        onSaved: (String? value) {
          word.turkishWord = value!;
        },
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
        ),
        onPressed: () {
          if (formKey.currentState != null &&
              formKey.currentState!.validate()) {
            formKey.currentState!.save();
            WordsBloc.add(word);
            formKey.currentState!.reset();
          }
        },
        child: const Text("Kaydet"),
      ),
    );
  }
}
