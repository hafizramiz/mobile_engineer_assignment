import 'package:mobile_engineer_assignment/core/constants/app/app_strings.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: AppStrings.appName, home: const HomePage());
  }
}
