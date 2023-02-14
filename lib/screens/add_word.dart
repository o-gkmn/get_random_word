import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/validator/add_word_validate.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';
import 'package:word_repository/word_repository.dart';

Word word = const Word.empty();

class AddWord extends StatelessWidget {
  const AddWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWordCubit(RepositoryProvider.of<WordRepository>(context)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Kelime Ekle",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
          child: _AddWordBody(),
        ),
      ),
    );
  }
}

class _AddWordBody extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  _AddWordBody();

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
              const _EnglishWordField(),
              const Spacer(flex: 1),
              const _TurkishWordField(),
              const Spacer(flex: 2),
              _SaveButton(formKey: formKey),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _EnglishWordField extends StatelessWidget with AddWordValidateMixin {
  const _EnglishWordField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        style: Theme.of(context).textTheme.labelMedium,
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
            labelText: "İngilizce kelime",
            labelStyle: Theme.of(context).textTheme.labelMedium,
            hintText: "Buraya yazın",
            hintStyle: Theme.of(context).textTheme.labelMedium),
        onSaved: (String? value) {
          word = word.copyWith(englishWord: value!);
        },
      ),
    );
  }
}

class _TurkishWordField extends StatelessWidget with AddWordValidateMixin {
  const _TurkishWordField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextFormField(
        validator: nullCheck,
        style: Theme.of(context).textTheme.labelMedium,
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
          labelText: "Türkçe kelime",
          labelStyle: Theme.of(context).textTheme.labelMedium,
          hintText: "Buraya yazın",
          hintStyle: Theme.of(context).textTheme.labelMedium,
          // labelStyle:
          //     TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        onSaved: (String? value) {
          word = word.copyWith(turkishWord: value!);
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _SaveButton({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWordCubit, AddWordState>(
      builder: (context, state) {
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
          child:
              Text("Kaydet", style: Theme.of(context).textTheme.displayMedium),
        ),
      );
    });
  }
}
