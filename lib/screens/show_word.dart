import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/show_word_cubit/show_word_cubit.dart';
import 'package:get_random_word/router/router_constants.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';
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
        shadowColor: Theme.of(context).colorScheme.shadow,
        title: Text(
          "Random Word",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       state.exception.toString(),
          //     ),
          //     backgroundColor: Colors.red,
          //   ),
          // );
          showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                  alertText: state.exception.toString().substring(11)));
        }
        context.read<ShowWordCubit>().initialRandomWordList();
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
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  offset: const Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Text(
              state.englishWord,
              style: Theme.of(context).textTheme.displayMedium,
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
            //foregroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  offset: const Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Text(
              state.turkishWord,
              textWidthBasis: TextWidthBasis.longestLine,
              style: Theme.of(context).textTheme.displayMedium,
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
          style: Theme.of(context).textTheme.labelMedium,
        ),
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
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
          style: Theme.of(context).textTheme.labelMedium,
        ),
        icon: Icon(
          Icons.list_alt_outlined,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => Navigator.pushNamed(context, listWord),
      ),
    );
  }
}

class NavigateSettings extends StatelessWidget {
  const NavigateSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        label: Text(
          "Ayarlar",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () => Navigator.pushNamed(context, settings),
      ),
    );
  }
}

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopupMenuState();
  }
}

class _PopupMenuState extends State<PopupMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final double _popupMenuItemCount = 3;
  final double _popupMenuItemHeight = 50;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _forwardAnimation() {
    setState(() {
      _animationController.forward();
    });
  }

  void _reverseAnimation() {
    setState(() {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onOpened: _forwardAnimation,
      onCanceled: _reverseAnimation,
      color: const Color(0x00000000),
      elevation: 0.0,
      offset: Offset(0, -(_popupMenuItemCount * _popupMenuItemHeight + 10)),
      itemBuilder: (_) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.all(0.0),
            height: _popupMenuItemHeight,
            child: const NavigateListWord(),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(0.0),
            height: _popupMenuItemHeight,
            child: const NavigateAddWord().build(context),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(0.0),
            height: _popupMenuItemHeight,
            child: const NavigateSettings(),
          ),
        ];
      },
      child: Container(
        alignment: Alignment.center,
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
          ),
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(0.0, 1.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: _animationController,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
