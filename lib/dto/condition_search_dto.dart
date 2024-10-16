class ConditionSearchDTO {
  // 현재가
  String coYnPricecur; // 현재가 선택 여부
  String coStPricecur; // 현재가 시작 범위
  String coEnPricecur; // 현재가 끝 범위

  // 등락율
  String coYnRate; // 등락율 선택 여부
  String coStRate; // 등락율 시작율
  String coEnRate; // 등락율 끝율

  // 시가총액
  String coYnValx; // 시가총액 선택 여부
  String coStValx; // 시가총액 시작액
  String coEnValx; // 시가총액 끝액

  // 발행주식
  String coYnShar; // 발행주식 선택 여부
  String coStShar; // 발행주식 시작 수
  String coEnShar; // 발행주식 끝 수

  // 거래량
  String coStVolume; // 거래량 선택 여부
  String coYnVolume; // 거래량 시작량
  String coEnVolume; // 거래량 끝량

  // 거래대금
  String coYnAmt; // 거래대금 선택 여부
  String coStAmt; // 거래대금 시작금
  String coEnAmt; // 거래대금 끝금

  // EPS
  String coYnEps; // EPS 선택 여부
  String coStEps; // EPS 시작
  String coEnEps; // EPS 끝

  // PER
  String coYnPer; // PER 선택 여부
  String coStPer; // PER 시작
  String coEnPer; // PER 끝

  String EXCD; // 거래소 정보
  String email; // 이메일

  ConditionSearchDTO({
    required this.EXCD,
    required this.email,
    this.coYnPricecur = '',
    this.coStPricecur = '',
    this.coEnPricecur = '',
    this.coYnRate = '',
    this.coStRate = '',
    this.coEnRate = '',
    this.coYnValx = '',
    this.coStValx = '',
    this.coEnValx = '',
    this.coYnShar = '',
    this.coStShar = '',
    this.coEnShar = '',
    this.coStVolume = '',
    this.coYnVolume = '',
    this.coEnVolume = '',
    this.coYnAmt = '',
    this.coStAmt = '',
    this.coEnAmt = '',
    this.coYnEps = '',
    this.coStEps = '',
    this.coEnEps = '',
    this.coYnPer = '',
    this.coStPer = '',
    this.coEnPer = '',
  });

  Uri convert(String baseurl) {
    return Uri.parse('$baseurl?AUTH=&EXCD=$EXCD&'
        'coYnPricecur=$coYnPricecur&coStPricecur=$coStPricecur&coEnPricecur=$coEnPricecur&'
        'coYnRate=$coYnRate&coStRate=$coStRate&coEnRate=$coEnRate&'
        'coYnValx=$coYnValx&coStValx=$coStValx&coEnValx=$coEnValx&'
        'coYnShar=$coYnShar&coStShar=$coStShar&coEnShar=$coEnShar&'
        'coYnVolume=$coYnVolume&coStVolume=$coStVolume&coEnVolume=$coEnVolume&'
        'coYnAmt=$coYnAmt&coStAmt=$coStAmt&coEnAmt=$coEnAmt&'
        'coYnEps=$coYnEps&coStEps=$coStEps&coEnEps=$coEnEps&'
        'coYnPer=$coYnPer&coStPer=$coStPer&coEnPer=$coEnPer&'
        'KEYB=&email=$email');
  }
}
