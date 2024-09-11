import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shadcnui_starter_app/providers/theme_provider.dart';
import 'package:shadcnui_starter_app/utils/color_scheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Shadcn UI Starter App',
            style: ShadTheme.of(context).textTheme.h3),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(LucideIcons.settings2),
          );
        }),
      ),
      drawer: BuildDrawer(isDarkMode: isDarkMode, themeProvider: themeProvider),
      body: const Center(
        child: Column(
          children: [
            ShadButton(
              child: Text('Button'),
            )
          ],
        ),
      ),
    );
  }
}

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    super.key,
    required this.isDarkMode,
    required this.themeProvider,
  });

  final bool isDarkMode;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            const Text('Dark'),
            const SizedBox(
              height: 5,
            ),
            ShadSwitch(
              value: isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('Color'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 600,
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: colorScheme.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        themeProvider.changeColorScheme(index);
                      },
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    themeProvider.selectedColorScheme == index
                                        ? colorScheme[index].color
                                        : Colors.transparent)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme[index].color),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
