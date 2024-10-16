import 'package:flutter/material.dart';
import 'package:mockin/login/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExchangeProvider(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
