import 'package:flutter/material.dart';

class StockHowInvest extends StatelessWidget {
  const StockHowInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 65),
            Center(
              child: Column(
                children: [
                  CategoryText(tt: '거래소 별 거래 시간'),
                  CountryText(tt: '미국'),
                  ContentText(tt: '23:30 ~ 06:00'),
                  ContentText(tt: '※ 섬머타임 적용 시 22:30 ~ 05:00\n'),
                  CountryText(tt: '홍콩'),
                  ContentText(tt: '오전장 : 10:30 ~ 13:00'),
                  ContentText(tt: '오후장 : 14:00 ~ 17:00\n'),
                  CountryText(tt: '상해'),
                  ContentText(tt: '오전장 : 10:30 ~ 12:30'),
                  ContentText(tt: '오후장 : 14:00 ~ 16:00\n'),
                  CountryText(tt: '심천'),
                  ContentText(tt: '오전장 : 10:30 ~ 12:30'),
                  ContentText(tt: '오후장 : 14:00 ~ 15:57\n'),
                  CountryText(tt: '도쿄'),
                  ContentText(tt: '오전장 : 9:00 ~ 11:30'),
                  ContentText(tt: '오후장 : 12:30 ~ 15:00\n'),
                  CountryText(tt: '하노이'),
                  ContentText(tt: '오전장 : 11:00 ~ 13:30'),
                  ContentText(tt: '오후장 : 15:00 ~ 16:30\n'),
                  CountryText(tt: '호치민'),
                  ContentText(tt: '오전장 : 11:15 ~ 13:00'),
                  ContentText(tt: '오후장 : 15:00 ~ 16:30\n'),
                  CategoryText(tt: '거래소 별 거래 수량 단위'),
                  CountryText(tt: '미국'),
                  ContentText(tt: '1주 (가격 제한폭 X)\n'),
                  CountryText(tt: '홍콩'),
                  ContentText(tt: '10-1000주이며 대부분 2000주 단위'),
                  ContentText(tt: '(가격 제한폭 X)\n'),
                  CountryText(tt: '상해'),
                  ContentText(tt: '100주 (매도 1주) (±10%)\n'),
                  CountryText(tt: '심천'),
                  ContentText(tt: '100주 (매도 1주) (±10%)\n'),
                  CountryText(tt: '도쿄'),
                  ContentText(tt: '종목별 상이 (전일 종가별로 상이)\n'),
                  CountryText(tt: '하노이'),
                  ContentText(tt: '100주 (±10%)\n'),
                  CountryText(tt: '호치민'),
                  ContentText(tt: '100주 (±7%)\n'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContentText extends StatelessWidget {
  const ContentText({
    super.key,
    required this.tt,
  });
  final String tt;
  @override
  Widget build(BuildContext context) {
    return Text(
      tt,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }
}

class CountryText extends StatelessWidget {
  const CountryText({
    super.key,
    required this.tt,
  });
  final String tt;

  @override
  Widget build(BuildContext context) {
    return Text(
      '- $tt',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class CategoryText extends StatelessWidget {
  const CategoryText({
    super.key,
    required this.tt,
  });
  final String tt;
  @override
  Widget build(BuildContext context) {
    return Text(
      tt,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }
}
