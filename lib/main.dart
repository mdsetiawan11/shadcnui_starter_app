import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shadcnui_starter_app/presentation/home_page.dart';
import 'package:shadcnui_starter_app/providers/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: const <RouteBase>[],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ShadApp.router(
      title: 'Shadcn UI Starter App',
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        colorScheme: themeProvider.lightColorScheme,
        brightness: Brightness.light,
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.poppins),
      ),
      darkTheme: ShadThemeData(
        colorScheme: themeProvider.darkColorScheme,
        brightness: Brightness.dark,
        textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.poppins),
      ),
      routerConfig: _router,
    );
  }
}
