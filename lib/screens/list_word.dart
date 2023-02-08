import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/list_word_cubit/list_word_cubit.dart';
import 'package:get_random_word/router/router_constants.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';

class ListWord extends StatelessWidget {
  const ListWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListWordCubit(RepositoryProvider.of(context))..initialListWord(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Kelime Listesi",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: const ListWordBody(),
      ),
    );
  }
}

class ListWordBody extends StatelessWidget {
  const ListWordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListWordCubit, ListWordState>(
      listener: (context, state) {
        if (state.status == ListStatus.failure) {
          showDialog(
              context: context,
              builder: (context) =>
                  CustomAlertDialog(alertText: state.exception.toString()));
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ListStatus.succed:
            return Container(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              child: ListView.builder(
                itemCount: state.words.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    margin: const EdgeInsets.only(
                        bottom: 3, left: 3.0, right: 3.0, top: 7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(
                        state.words[index].englishWord,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        state.words[index].turkishWord,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        updateWord,
                        arguments: state.words.elementAt(index),
                      ),
                    ),
                  );
                },
              ),
            );
          case ListStatus.empty:
            return Center(
              child: Text(
                "Listeniz bomboş.\n\nBiraz kelime eklemeye ne dersin?",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            );
          case ListStatus.initial:
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
