import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockin/widgets/text/title_text.dart';
import 'package:mockin/widgets/text/content_text.dart';
import 'package:mockin/widgets/text/category_text.dart';

class StockHowInvest extends StatelessWidget {
  const StockHowInvest({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressedAt;
    const Duration backPressDuration = Duration(seconds: 2);

    void showExitWarning(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('한 번 더 뒤로가기를 누르면 종료됩니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          print('>>> didPop 호출');
          return;
        }
        final now = DateTime.now();

        if (lastPressedAt == null ||
            now.difference(lastPressedAt!) > backPressDuration) {
          print('>>> $now');
          lastPressedAt = now;
          showExitWarning(context);
          return;
        }
        SystemNavigator.pop();
      },
      child: const Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 65),
              Center(
                child: Column(
                  children: [
                    TitleText(tt: '거래소 별 거래 시간'),
                    CategoryText(tt: '- 미국'),
                    ContentText(tt: '23:30 ~ 06:00'),
                    ContentText(tt: '※ 섬머타임 적용 시 22:30 ~ 05:00\n'),
                    CategoryText(tt: '- 홍콩'),
                    ContentText(tt: '오전장 : 10:30 ~ 13:00'),
                    ContentText(tt: '오후장 : 14:00 ~ 17:00\n'),
                    CategoryText(tt: '- 상해'),
                    ContentText(tt: '오전장 : 10:30 ~ 12:30'),
                    ContentText(tt: '오후장 : 14:00 ~ 16:00\n'),
                    CategoryText(tt: '- 심천'),
                    ContentText(tt: '오전장 : 10:30 ~ 12:30'),
                    ContentText(tt: '오후장 : 14:00 ~ 15:57\n'),
                    CategoryText(tt: '- 도쿄'),
                    ContentText(tt: '오전장 : 9:00 ~ 11:30'),
                    ContentText(tt: '오후장 : 12:30 ~ 15:00\n'),
                    CategoryText(tt: '- 하노이'),
                    ContentText(tt: '오전장 : 11:00 ~ 13:30'),
                    ContentText(tt: '오후장 : 15:00 ~ 16:30\n'),
                    CategoryText(tt: '- 호치민'),
                    ContentText(tt: '오전장 : 11:15 ~ 13:00'),
                    ContentText(tt: '오후장 : 15:00 ~ 16:30\n'),
                    TitleText(tt: '거래소 별 거래 수량 단위'),
                    CategoryText(tt: '- 미국'),
                    ContentText(tt: '1주 (가격 제한폭 X)\n'),
                    CategoryText(tt: '- 홍콩'),
                    ContentText(tt: '10-1000주이며 대부분 2000주 단위'),
                    ContentText(tt: '(가격 제한폭 X)\n'),
                    CategoryText(tt: '- 상해'),
                    ContentText(tt: '100주 (매도 1주) (±10%)\n'),
                    CategoryText(tt: '- 심천'),
                    ContentText(tt: '100주 (매도 1주) (±10%)\n'),
                    CategoryText(tt: '- 도쿄'),
                    ContentText(tt: '종목별 상이 (전일 종가별로 상이)\n'),
                    CategoryText(tt: '- 하노이'),
                    ContentText(tt: '100주 (±10%)\n'),
                    CategoryText(tt: '- 호치민'),
                    ContentText(tt: '100주 (±7%)\n'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
