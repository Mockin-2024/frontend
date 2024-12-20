import 'package:flutter/material.dart';
import 'package:mockin/afterlogin/navi.dart';
import 'package:mockin/api/oauth2_api.dart';
import 'package:mockin/dto/account/user_email_dto.dart';
import 'package:mockin/storage/favorite_data.dart';

class WaitToken extends StatefulWidget {
  const WaitToken({super.key});

  @override
  State<WaitToken> createState() => _WaitTokenState();
}

class _WaitTokenState extends State<WaitToken> {
  bool isLoading = true;

  Future<void> mockToken() async {
    var tmp = await Oauth2Api.getMockToken(
        DTO: UserEmailDTO(
      email: '',
    ));
    if (tmp) {
      print('>>> mock token success');
    } else {
      print('>>> mock token failed');
    }
  }

  Future<void> realToken() async {
    var tmp = await Oauth2Api.getRealToken(
        DTO: UserEmailDTO(
      email: '',
    ));
    if (tmp) {
      print('>>> real token success');
    } else {
      print('>>> real token failed');
    }
  }

  void doit() async {
    try {
      await mockToken();
      await realToken();
      await FavoriteData().init();

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
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
  }
}
