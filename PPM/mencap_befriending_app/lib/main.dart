import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'LoginPages.dart';
import 'SettingsPages.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _currentThemeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _currentThemeMode =
          _currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: whiteSwatch,
          appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black, 
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: blackSwatch,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white, 
        ),
      ),
      themeMode: _currentThemeMode,
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/Settings': (context) => SettingsPage(onToggleTheme: _toggleTheme),
        '/MainPage': (context) => MainPage(),
        '/ChangeUsername': (context) => ChangeUsernameSettings(),
        '/ChangePassword': (context) => ChangePasswordSettings(),
        '/SearchPage': (context) => IndexPage(),
      },
    );
  }
}




//Main Page
class MainPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    ElevatedButton(
                       onPressed: () {
                          Navigator.pushNamed(context, '/SearchPage');
                        },
                        child: const Text("Search")),
                        const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Settings');
                        },
                        child: const Text("Settings")),
                        const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Back")),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

MaterialColor blackSwatch = const MaterialColor(0xFF000000, {
  50: const Color(0xFFFAFAFA),
  100: const Color(0xFFF5F5F5),
  200: const Color(0xFFEEEEEE),
  300: const Color(0xFFE0E0E0),
  350: const Color(0xFFD6D6D6),
  400: const Color(0xFFBDBDBD),
  500: const Color(0xFF000000),
  600: const Color(0xFF757575),
  700: const Color(0xFF616161),
  800: const Color(0xFF424242),
  850: const Color(0xFF303030),
  900: const Color(0xFF212121),
});

MaterialColor whiteSwatch = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );