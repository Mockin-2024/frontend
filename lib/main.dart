import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mockin/afterlogin/navi.dart';
import 'package:mockin/afterlogin/wait_token.dart';
import 'package:mockin/login/find_pw.dart';
import 'package:mockin/login/info_register.dart';
import 'package:mockin/login/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mockin/login/signup.dart';
import 'package:mockin/provider/exchange_provider.dart';
import 'package:mockin/storage/jwt_token.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await JwtToken().init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExchangeProvider(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});

  final GoRouter _router = GoRouter(initialLocation: '/login', routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: '/findpw',
      builder: (context, state) => const FindPw(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => InfoRegister(),
    ),
    GoRoute(
      path: '/getToken',
      builder: (context, state) => const WaitToken(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const Navi(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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
