import 'package:flutter/material.dart';
import 'package:tabata_timer/services/locale/locale_cubit.dart';
import 'package:tabata_timer/services/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabata_timer/views/home/home_cubit.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.bottomLeft,
            height: 200,
            padding: const EdgeInsets.all(25),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ThemeCubit>().changeTheme();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          context.read<ThemeCubit>().isDark()
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context
                              .read<LocaleCubit>()
                              .state
                              .consts['changeTheme']!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.read<LocaleCubit>().changeLocale();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.language,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context
                              .read<LocaleCubit>()
                              .state
                              .consts['changeLocale']!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().deleteAll();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.delete_forever,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context
                              .read<LocaleCubit>()
                              .state
                              .consts['deleteAll']!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    context.read<ThemeCubit>().changeFont();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_size_rounded,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context
                              .read<LocaleCubit>()
                              .state
                              .consts['changeFont']!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
