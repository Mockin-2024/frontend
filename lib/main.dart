import 'package:flutter/material.dart';
import 'package:mockin/login/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await JwtToken().init();
  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      theme: ThemeData(
        fontFamily: 'nanum-barun-gothic',
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
