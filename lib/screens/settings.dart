import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // BlocProvider(
      //   create: (context) => ThemeCubit(
      //       themeRepository: RepositoryProvider.of<ThemeRepository>(context)),
      // ),
      BlocProvider(
        create: (context) => SettingsCubit(),
      ),
    ], child: const _SettingsView());
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ayarlar",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        elevation: 20.0,
        shadowColor: Colors.black,
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        bloc: BlocProvider.of<SettingsCubit>(context)..initSettings(),
        listener: (context, state) {
          if (state.settingsStatus == SettingsStatus.error) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                alertText: state.exception.toString(),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.settingsStatus) {
            case SettingsStatus.loaded:
              return const Padding(
                padding: EdgeInsets.all(12.0),
                child: _ThemeBody(),
              );
            case SettingsStatus.initial:
            case SettingsStatus.loading:
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _ThemeBody extends StatelessWidget {
  const _ThemeBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [_BrightnessTheme()],
    );
  }
}

class _BrightnessTheme extends StatefulWidget {
  const _BrightnessTheme();

  @override
  State<StatefulWidget> createState() {
    return _BrightnessThemeState();
  }
}

class _BrightnessThemeState extends State {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Icon(
            Icons.dark_mode_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          );
        } else {
          return Icon(
            Icons.light_mode_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          );
        }
      },
    );
    return Row(
      children: [
        Text("Karanlık Tema", style: Theme.of(context).textTheme.titleMedium),
        const Spacer(flex: 1),
        Switch(
          value: context.read<ThemeModeCubit>().state.themeMode == ThemeMode.dark,
          activeColor: const Color.fromARGB(197, 69, 197, 49),
          activeTrackColor: const Color.fromARGB(255, 92, 255, 67),
          inactiveThumbColor: const Color.fromARGB(255, 92, 255, 67),
          inactiveTrackColor: const Color.fromARGB(197, 69, 197, 49),
          thumbIcon: thumbIcon,
          onChanged: (value) {
            context.read<ThemeModeCubit>().switchTheme();
          },
        )
      ],
    );
  }
}
