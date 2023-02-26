import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/router/router.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';
import 'package:word_repository/word_repository.dart';

class ListWord extends StatelessWidget {
  const ListWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListWordCubit(
          RepositoryProvider.of<WordRepository>(context)..getAllWords())
        ..initialListWord(),
      child: const _ListWordBody(),
    );
  }
}

class _ListWordBody extends StatelessWidget {
  const _ListWordBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: const Text("Kullanıcı kelimeleri"),
                  onTap: () => context.read<ListWordCubit>().filterUserWord(),
                ),
                PopupMenuItem(
                  child: const Text("Sistem kelimeleri"),
                  onTap: () => context.read<ListWordCubit>().filterSystemWord(),
                )
              ];
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.filter_list_rounded),
            ),
          )
        ],
        title: Text(
          "Kelime Listesi",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocConsumer<ListWordCubit, ListWordState>(
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
                        onTap: () => Navigator.pushNamed(
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
      ),
    );
  }
}
