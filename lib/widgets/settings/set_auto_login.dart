import 'package:flutter/material.dart';
import 'package:mockin/service/setting_service.dart';
import 'package:mockin/widgets/text/category_text.dart';

class SetAutoLogin extends StatefulWidget {
  const SetAutoLogin({super.key});

  @override
  State<SetAutoLogin> createState() => _SetAutoLoginState();
}

class _SetAutoLoginState extends State<SetAutoLogin> {
  var auto = false;

  @override
  void initState() {
    super.initState();
    curAutoLogin();
  }

  void curAutoLogin() async {
    final rst = await SettingService.getAutoLogin();
    setState(() {
      auto = rst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryText(tt: '자동로그인'),
        IconButton(
            onPressed: () async {
              SettingService.setAutoLogin();
              setState(() {
                auto = !auto;
              });
            },
            icon: auto
                ? const Icon(Icons.check_box_outlined)
                : const Icon(Icons.check_box_outline_blank_outlined)),
      ],
    );
  }
}
