import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/add_word_cubit/add_word_cubit.dart';
import 'package:get_random_word/validator/add_word_validate.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';
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
        body: BlocListener<AddWordCubit, AddWordState>(
          listener: (context, state) {
            if (state.status == AddWordStatus.failed) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  alertText: state.exception.toString(),
                ),
              );
            }
          },
          child: AddWordBody(),
        ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              const EnglishWordField(),
              const Spacer(flex: 1),
              const TurkishWordField(),
              const Spacer(flex: 2),
              SaveButton(formKey: formKey),
              const Spacer(flex: 3),
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
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 2.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error, width: 2.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 2.5)),
          labelText: "İngilizce kelime",
          hintText: "Buraya yazın",
          labelStyle:
              TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.5)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error, width: 2.5)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 2.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.5)),
            labelText: "Türkçe kelime",
            hintText: "Buraya yazın",
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
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
        onPressed: () {
          if (formKey.currentState != null &&
              formKey.currentState!.validate()) {
            formKey.currentState!.save();
            context.read<AddWordCubit>().addWord(word);
            formKey.currentState!.reset();
          }
        },
        child: Text("Kaydet",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      ),
    );
  }
}
