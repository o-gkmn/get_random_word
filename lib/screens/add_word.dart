import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/add_word_cubit/add_word_cubit.dart';
import 'package:get_random_word/validator/add_word_validate.dart';
import 'package:word_api/word_api.dart';

Word word = const Word.empty();

class AddWord extends StatelessWidget {
  const AddWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWordCubit(RepositoryProvider.of(context)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kelime Ekle"),
        ),
        body: AddWordBody(),
      ),
    );
  }
}

class AddWordBody extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  AddWordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const EnglishWordField(),
              const TurkishWordField(),
              SaveButton(formKey: formKey)
            ],
          ),
        ),
      ),
    );
  }
}

class EnglishWordField extends StatelessWidget with AddWordValidateMixin {
  const EnglishWordField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        decoration: const InputDecoration(
          labelText: "İngilizce kelime",
          hintText: "Buraya yazın",
        ),
        onSaved: (String? value) {
          word = word.copyWith(englishWord: value!);
        },
      ),
    );
  }
}

class TurkishWordField extends StatelessWidget with AddWordValidateMixin {
  const TurkishWordField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        decoration: const InputDecoration(
          labelText: "Türkçe kelime",
          hintText: "Buraya yazın",
        ),
        onSaved: (String? value) {
          word = word.copyWith(turkishWord: value!);
        },
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const SaveButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          if (formKey.currentState != null &&
              formKey.currentState!.validate()) {
            formKey.currentState!.save();
            context.read<AddWordCubit>().addWord(word);
            formKey.currentState!.reset();
          }
        },
        child: const Text("Kaydet"),
      ),
    );
  }
}
