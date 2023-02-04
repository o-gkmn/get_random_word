import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/show_word_cubit/show_word_cubit.dart';
import 'package:get_random_word/router/router_constants.dart';
import 'package:word_repository/word_repository.dart';

class ShowWord extends StatelessWidget {
  const ShowWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowWordCubit(
        RepositoryProvider.of<WordRepository>(context),
      )..initialRandomWordList(),
      child: const ShowWordView(),
    );
  }
}

class ShowWordView extends StatelessWidget {
  const ShowWordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        shadowColor: Colors.black,
        title: const Text("Random Word"),
        centerTitle: true,
      ),
      floatingActionButton: const PopupMenu(),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: const Align(
          alignment: Alignment.center,
          child: ShowWordDesign(),
        ),
      ),
    );
  }
}

class ShowWordDesign extends StatelessWidget {
  const ShowWordDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShowWordCubit, ShowWordState>(
      bloc: BlocProvider.of<ShowWordCubit>(context),
      listener: (context, state) {
        if (state.pageStatus == PageStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.exception.toString(),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: const [
              EnglishWordButton(),
              ShowTranslateButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class EnglishWordButton extends StatelessWidget {
  const EnglishWordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowWordCubit, ShowWordState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            context.read<ShowWordCubit>().emitOpenEnglishWord();
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
          child: Container(
            margin: const EdgeInsets.all(7.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                style: BorderStyle.solid,
                color: Theme.of(context).primaryColor,
                width: 10,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              state.englishWord,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Times New Roman",
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShowTranslateButton extends StatelessWidget {
  const ShowTranslateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowWordCubit, ShowWordState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            context.read<ShowWordCubit>().emitOpenTurkishWord();
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          ),
          child: Container(
            margin: const EdgeInsets.all(7.0),
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                style: BorderStyle.solid,
                color: Theme.of(context).colorScheme.secondary,
                width: 10,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              state.turkishWord,
              textWidthBasis: TextWidthBasis.longestLine,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: "Times New Roman",
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavigateAddWord extends StatelessWidget {
  const NavigateAddWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        label: Text(
          "Kelime Ekle",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () => Navigator.pushNamed(context, addWord).then(
          (value) => context.read<ShowWordCubit>().initialRandomWordList(),
        ),
      ),
    );
  }
}

class NavigateListWord extends StatelessWidget {
  const NavigateListWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        label: Text(
          "Kelime Listesi",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        icon: Icon(
          Icons.list_alt_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () => Navigator.pushNamed(context, listWord),
      ),
    );
  }
}

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: const Color(0x00000000),
      elevation: 0.0,
      offset: const Offset(0, -110),
      itemBuilder: (_) {
        return [
          const PopupMenuItem(
            padding: EdgeInsets.all(0.0),
            child: NavigateListWord(),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(0.0),
            child: const NavigateAddWord().build(context),
          ),
        ];
      },
      child: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onBackground,
              offset: const Offset(0.0, 1.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
