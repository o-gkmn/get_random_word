import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/list_word_cubit/list_word_cubit.dart';
import 'package:get_random_word/router/router_constants.dart';

class ListWord extends StatelessWidget {
  const ListWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListWordCubit(RepositoryProvider.of(context)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kelime Listesi"),
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
    return BlocBuilder<ListWordCubit, ListWordState>(
      builder: (context, state) {
        if (state is ListWordLoaded) {
          return Container(
            padding: const EdgeInsets.only(left: 3.0, right: 3.0),
            child: ListView.builder(
              itemCount: state.words.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).colorScheme.primary,
                  margin: const EdgeInsets.only(
                      bottom: 3, left: 3.0, right: 3.0, top: 7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ListTile(
                      title: Text(state.words[index].englishWord),
                      subtitle: Text(state.words[index].turkishWord),
                      onTap: () => Navigator.pushReplacementNamed(
                          context, updateWord,
                          arguments: state.words.elementAt(index))),
                );
              },
            ),
          );
        } else if (state is ListWordEmpty) {
          return const Center(
              child: Text(
            "Listeniz bomboş.\n\nBiraz kelime eklemeye ne dersin?",
            textAlign: TextAlign.center,
          ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
