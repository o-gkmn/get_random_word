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
        title: const Text("Random Word"),
        actions: const <Widget>[
          NavigateAddWord(),
          NavigateListWord(),
        ],
      ),
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
        // if (state.pageStatus == PageStatus.loading) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text(
        //           "Liste yüklemesi sürüyor...",
        //         ),
        //         backgroundColor: Colors.amberAccent),
        //   );
        // }
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
    return BlocBuilder<ShowWordCubit, ShowWordState>(builder: (context, state) {
      return TextButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () => Navigator.pushNamed(context, addWord).then(
          (value) => context.read<ShowWordCubit>().initialRandomWordList(),
        ),
      );
    });
  }
}

class NavigateListWord extends StatelessWidget {
  const NavigateListWord({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Icon(
        Icons.list_alt_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () => Navigator.pushNamed(context, listWord),
    );
  }
}
