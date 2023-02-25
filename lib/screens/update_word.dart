import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/router/router.dart';
import 'package:get_random_word/validator/add_word_validate.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';
import 'package:word_repository/word_repository.dart';

String turkishWord = "";
String englishWord = "";

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key, this.word = const Word.empty()});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UpdateWordCubit(RepositoryProvider.of(context), word),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Güncelle",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: BlocListener<UpdateWordCubit, UpdateWordState>(
            listener: (context, state) {
              switch (state.status) {
                case UpdateStatus.failure:
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      alertText: state.exception.toString(),
                    ),
                  );
                  break;
                case UpdateStatus.succed:
                  Navigator.pushReplacementNamed(context, listWord);
                  break;
                case UpdateStatus.inital:
                default:
              }
            },
            child: _UpdateScreenBody()),
      ),
    );
  }
}

class _UpdateScreenBody extends StatelessWidget {
  _UpdateScreenBody();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _EnglishWordField(),
            const _TurkishWordField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _SaveButton(formKey: formKey),
                const _DeleteButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EnglishWordField extends StatelessWidget with AddWordValidateMixin {
  const _EnglishWordField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateWordCubit, UpdateWordState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: TextFormField(
            validator: nullCheck,
            style: Theme.of(context).textTheme.labelMedium,
            initialValue: state.word.englishWord,
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
                  width: 2.5,
                ),
              ),
              labelText: "İngilizce kelime",
              hintText: state.word.englishWord,
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
            onSaved: (String? value) {
              englishWord = value!;
            },
          ),
        );
      },
    );
  }
}

class _TurkishWordField extends StatelessWidget with AddWordValidateMixin {
  const _TurkishWordField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateWordCubit, UpdateWordState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: TextFormField(
            validator: nullCheck,
            style: Theme.of(context).textTheme.labelMedium,
            initialValue: state.word.turkishWord,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2.5)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 2.5)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground,
                        width: 2.5)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.5,
                  ),
                ),
                labelText: "Türkçe kelime",
                hintText: state.word.turkishWord,
                labelStyle: Theme.of(context).textTheme.labelMedium),
            onSaved: (String? value) {
              turkishWord = value!;
            },
          ),
        );
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _SaveButton({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateWordCubit, UpdateWordState>(
      builder: (context, state) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width / 2) - 20,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState != null &&
                  formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<UpdateWordCubit>().updateWord(state.word.copyWith(
                    englishWord: englishWord, turkishWord: turkishWord));
                Navigator.pop(context, listWord);
              }
            },
            child: Text(
              "Güncelle",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateWordCubit, UpdateWordState>(
        builder: (context, state) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width / 2) - 20,
        child: ElevatedButton(
            onPressed: () {
              context.read<UpdateWordCubit>().deleteWord(state.word);
              Navigator.pop(context, listWord);
            },
            child:
                Text("Sil", style: Theme.of(context).textTheme.displayMedium)),
      );
    });
  }
}
