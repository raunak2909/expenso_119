import 'package:expense_app/data/local/db_helper.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bottom_nav_page_provider.dart';
import 'package:expense_app/ui_pages/bottomnav_page.dart';
import 'package:expense_app/ui_pages/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ExpenseBloc(dbHelper: DBHelper.getInstance()),),
      ChangeNotifierProvider(create: (context) => BottomNavPageProvider(),),
      ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense App',
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold
            ),
            displayMedium: TextStyle(
                fontSize: 25,
            ),
            bodyLarge: TextStyle(
              fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            bodyMedium: TextStyle(
              fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            bodySmall: TextStyle(
              fontSize: 14,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,)
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
            ),
            displayMedium: TextStyle(
              fontSize: 25,
            ),
            bodyLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            bodyMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
            bodySmall: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        themeMode: context.watch<ThemeProvider>().getThemeValue() ? ThemeMode.dark : ThemeMode.light,
        home: BottomNavPage(),);
  }
}
