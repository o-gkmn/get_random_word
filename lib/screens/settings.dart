import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_random_word/bloc/bloc.dart';
import 'package:get_random_word/widgets/custom_alert_dialog.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:theme_repository/theme_repository.dart';
import 'package:word_repository/word_repository.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        wordRepository: RepositoryProvider.of<WordRepository>(context),
        settingsRepository: RepositoryProvider.of<SettingsRepository>(context),
      )..initSettings(),
      child: const _SettingsView(),
    );
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
                child: _SettingsBody(),
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

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ThemeModeSetting(),
        const _ThemeColorSettings(),
        const SizedBox(height: 20.0),
        Divider(color: Theme.of(context).colorScheme.onBackground),
        const SizedBox(height: 20.0),
        const _SmallPackSetting(),
        const _MediumPackSetting(),
        const _LargePackSetting(),
      ],
    );
  }
}

class _ThemeModeSetting extends StatefulWidget {
  const _ThemeModeSetting();

  @override
  State<StatefulWidget> createState() {
    return _ThemeModeSettingState();
  }
}

class _ThemeModeSettingState extends State {
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
          value:
              context.read<ThemeModeCubit>().state.themeMode == ThemeMode.dark,
          activeColor: Theme.of(context).colorScheme.primary,
          activeTrackColor: Theme.of(context).colorScheme.onPrimary,
          inactiveThumbColor: Theme.of(context).colorScheme.onPrimary,
          inactiveTrackColor: Theme.of(context).colorScheme.primary,
          thumbIcon: thumbIcon,
          onChanged: (value) {
            context.read<ThemeModeCubit>().switchTheme();
          },
        )
      ],
    );
  }
}

class _ThemeColorSettings extends StatelessWidget {
  const _ThemeColorSettings();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeColorCubit, ThemeColorState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              "Tema Rengi",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(flex: 1),
            DropdownButton(
              items: const [
                DropdownMenuItem(value: ColorTheme.green, child: Text("Yeşil")),
                DropdownMenuItem(value: ColorTheme.red, child: Text("Kırmızı"))
              ],
              value: state.colorTheme,
              dropdownColor: Theme.of(context).colorScheme.surface,
              underline: const Divider(
                height: 0,
                color: Color.fromARGB(0, 0, 0, 0),
              ),
              alignment: Alignment.centerRight,
              elevation: 15,
              onChanged: (value) {
                if (value is ColorTheme) {
                  context.read<ThemeColorCubit>().switchTheme(value);
                }
              },
            )
          ],
        );
      },
    );
  }
}

class _SmallPackSetting extends StatelessWidget {
  const _SmallPackSetting();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              "100'lük Kelime Paketi",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Switch(
              value: state.smallPackSetting,
              activeColor: Theme.of(context).colorScheme.onPrimary,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.onPrimary,
              onChanged: (value) {
                context.read<SettingsCubit>().switchSmallPack(value);
              },
            )
          ],
        );
      },
    );
  }
}

class _MediumPackSetting extends StatelessWidget {
  const _MediumPackSetting();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              "500'lük Kelime Paketi",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Switch(
              value: state.mediumPackSetting,
              activeColor: Theme.of(context).colorScheme.onPrimary,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.onPrimary,
              onChanged: (value) {
                context.read<SettingsCubit>().switchMediumPack(value);
              },
            )
          ],
        );
      },
    );
  }
}

class _LargePackSetting extends StatelessWidget {
  const _LargePackSetting();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Row(
          children: [
            Text(
              "1000'lik Kelime Paketi",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Switch(
              value: state.largePackSetting,
              activeColor: Theme.of(context).colorScheme.onPrimary,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Theme.of(context).colorScheme.onPrimary,
              onChanged: (value) {
                context.read<SettingsCubit>().switchLargePack(value);
              },
            )
          ],
        );
      },
    );
  }
}