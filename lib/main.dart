import 'package:flutter/material.dart';
import 'package:projecto_inicial/screen/home_screen.dart';
import 'package:projecto_inicial/screen/login_screen.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Estado global para el modo oscuro
  bool isDarkMode = false;

  // Función para cambiar el tema
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moodia',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.green.shade200,
          onPrimary: Colors.black, 
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade200,
          foregroundColor: Colors.black,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.green.shade200,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color.fromARGB(255, 20, 119, 144),
          onPrimary: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 20, 119, 144),
          foregroundColor: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: const Color.fromARGB(255, 20, 119, 144),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context) => LoginScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/home_screen': (context) => HomeScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      },
    );
  }
}
