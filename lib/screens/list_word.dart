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
          _filterIconButton(context: context),
          IconButton(
              onPressed: () => showSearch(
                    context: context,
                    delegate: _WordsListSearchDelegate(
                      words: context.read<ListWordCubit>().wordsList,
                    ),
                  ),
              icon: const Icon(Icons.search))
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
              builder: (context) => CustomAlertDialog(
                alertText: state.exception.toString(),
              ),
            );
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

  Widget _filterIconButton({required BuildContext context}) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          enableDrag: true,
          builder: (_) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(28.0, 28.0),
                  topRight: Radius.elliptical(28.0, 28.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    indent: MediaQuery.of(context).size.width * 0.43,
                    endIndent: MediaQuery.of(context).size.width * 0.44,
                    thickness: 2.0,
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      context.read<ListWordCubit>().filterUserWord();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Kullanıcı Kelimeleri",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    onPressed: () {
                      context.read<ListWordCubit>().filterSystemWord();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sistem Kelimeleri",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _WordsListSearchDelegate extends SearchDelegate {
  final List<Word> words;

  _WordsListSearchDelegate({required this.words});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Word> matchQuery = [];
    for (Word word in words) {
      if (word.englishWord.toLowerCase().contains(query.toLowerCase()) ||
          word.turkishWord.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(word);
      }
    }
    return Container(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Theme.of(context).colorScheme.onPrimary,
            margin:
                const EdgeInsets.only(bottom: 3, left: 3.0, right: 3.0, top: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(
                matchQuery[index].englishWord,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                matchQuery[index].turkishWord,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onTap: () => Navigator.pushNamed(
                context,
                updateWord,
                arguments: matchQuery.elementAt(index),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Word> matchQuery = [];
    for (Word word in words) {
      if (word.englishWord.toLowerCase().contains(query.toLowerCase()) ||
          word.turkishWord.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(word);
      }
    }
    return Container(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Theme.of(context).colorScheme.onPrimary,
            margin:
                const EdgeInsets.only(bottom: 3, left: 3.0, right: 3.0, top: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(
                matchQuery[index].englishWord,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                matchQuery[index].turkishWord,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onTap: () => Navigator.pushNamed(
                context,
                updateWord,
                arguments: matchQuery.elementAt(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
