import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/setting_theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(switchThemeProviderProvider);

    return Scaffold(
        appBar: AppBar(
            elevation: 2,
            title: Text(context.tr('setting'),
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold))),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffeae2d1).withOpacity(0.4)),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 40,
                                child: Icon(
                                  Icons.person_2_rounded,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Myo Thiha',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text('+669*****654')
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffeae2d1).withOpacity(0.4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        context.tr('lbl_general'),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.light_mode),
                              const SizedBox(width: 16),
                              Text(
                                context.tr('label_day_nigh_mode'),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: theme == ThemeMode.system
                                      ? const Color(4294959229)
                                      : Colors.grey.withOpacity(0.25),
                                  child: IconButton(
                                    iconSize: 24,
                                    onPressed: () {
                                      ref
                                          .read(switchThemeProviderProvider
                                              .notifier)
                                          .updateThemeMode(ThemeMode.system);
                                    },
                                    icon: const Icon(Icons.auto_mode),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: CircleAvatar(
                                  backgroundColor: theme == ThemeMode.light
                                      ? const Color(4294959229)
                                      : Colors.grey.withOpacity(0.25),
                                  radius: 20,
                                  child: IconButton(
                                    iconSize: 24,
                                    onPressed: () {
                                      ref
                                          .read(switchThemeProviderProvider
                                              .notifier)
                                          .updateThemeMode(ThemeMode.light);
                                    },
                                    icon: const Icon(Icons.light_mode),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: theme == ThemeMode.dark
                                    ? const Color(4294959229)
                                    : Colors.grey.withOpacity(0.25),
                                radius: 20,
                                child: IconButton(
                                  onPressed: () {
                                    ref
                                        .read(switchThemeProviderProvider
                                            .notifier)
                                        .updateThemeMode(ThemeMode.dark);
                                  },
                                  icon: const Icon(Icons.mode_night),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          showDragHandle: true,
                          useRootNavigator: true,
                          context: context,
                          sheetAnimationStyle: AnimationStyle(
                              duration: const Duration(milliseconds: 700),
                              reverseDuration:
                                  const Duration(milliseconds: 300)),
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 270,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    context.tr('label_select_language'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .setLocale(const Locale('en', 'US'));
                                      GoRouter.of(context).pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                                      child: Card.outlined(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: context.locale
                                                            .languageCode ==
                                                        "en"
                                                    ? const Color(0xffebc31a)
                                                    : const Color(0xffffffff)),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'images/eng_flag.png',
                                                fit: BoxFit.cover,
                                                width: 45,
                                                height: 32,
                                              ),
                                              Text(
                                                context.tr('english'),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .setLocale(const Locale('my', 'MM'));
                                      GoRouter.of(context).pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top:8,right: 16),
                                      child: Card.outlined(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: context.locale
                                                            .languageCode ==
                                                        "my"
                                                    ? const Color(0xffebc31a)
                                                    : const Color(0xffffffff)),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'images/mm_flag.png',
                                                fit: BoxFit.cover,
                                                width: 45,
                                                height: 32,
                                              ),
                                              Text(
                                                context.tr('myanmar'),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.language),
                                const SizedBox(width: 16),
                                Text(
                                  context.tr('label_language'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  context.tr(context.locale.languageCode == "en"
                                      ? 'english'
                                      : 'myanmar'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
