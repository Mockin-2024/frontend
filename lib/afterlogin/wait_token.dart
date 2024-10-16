import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/navi.dart';
import 'package:mockin/api/login_api.dart';
import 'package:mockin/afterlogin/user_email.dart';

class WaitToken extends StatefulWidget {
  const WaitToken({super.key});

  @override
  State<WaitToken> createState() => _WaitTokenState();
}

class _WaitTokenState extends State<WaitToken> {
  bool isLoading = true;

  Future<void> mockSocketKey() async {
    var tmp = await LoginApi.getMockSocketKey(UserEmail().getEmail()!);
    if (tmp) {
      print('>>> mock web success');
    } else {
      print('>>> mock web failed');
    }
  }

  Future<void> realSocketKey() async {
    var tmp = await LoginApi.getRealSocketKey(UserEmail().getEmail()!);
    if (tmp) {
      print('>>> real web success');
    } else {
      print('>>> real web failed');
    }
  }

  Future<void> mockToken() async {
    var email = UserEmail().getEmail()!;
    var tmp = await LoginApi.getMockToken(email);
    if (tmp) {
      print('>>> mock token success');
    } else {
      print('>>> mock token failed');
    }
  }

  Future<void> realToken() async {
    var email = UserEmail().getEmail()!;
    var tmp = await LoginApi.getRealToken(email);
    if (tmp) {
      print('>>> real token success');
    } else {
      print('>>> real token failed');
    }
  }

  void doit() async {
    try {
      await mockSocketKey();
      // await realSocketKey();
      await mockToken();
      // await realToken();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Navi(),
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    doit();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
