import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/view_model/bottom_nav_bar_view_model.dart';

import 'screens/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BottomNavBarViewModel(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: HomeView(),
      ),
    );
  }
}
