import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';
import 'features/auth/pages/login_page.dart';
import 'features/auth/pages/register_page.dart';
import 'features/explore/pages/explore_page.dart';
import 'features/home/pages/home_preview_page.dart';
import 'features/profile/pages/profile_page.dart';
import 'features/welcome/pages/welcome_page.dart';

class VEduMatchApp extends StatelessWidget {
  const VEduMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V-EduMatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Arial',
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePreviewPage(isGuest: false),
        '/preview': (context) => const HomePreviewPage(isGuest: true),
        '/explore': (context) {
          final openSearch = ModalRoute.of(context)?.settings.arguments == true;
          return ExplorePage(openSearch: openSearch);
        },
        '/profile': (context) => const ProfilePage(),
      },
      home: const WelcomePage(),
    );
  }
}
