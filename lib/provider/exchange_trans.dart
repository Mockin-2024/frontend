class ExchangeTrans {
  static Map<String, String> trade = {
    '나스닥': 'NAS',
    '뉴욕': 'NYS',
    '홍콩': 'HKS',
    '아멕스': 'AMS',
    '상해': 'SHS',
    '심천': 'SZS',
    '호치민': 'HSX',
    '하노이': 'HNX',
    '도쿄': 'TSE',
  };

  static Map<String, String> orderTrade = {
    'NAS': 'NASD',
    'NYS': 'NYSE',
    'HKS': 'SEHK',
    'AMS': 'AMEX',
    'SHS': 'SHAA',
    'SZS': 'SZAA',
    'HSX': 'VNSE',
    'HNX': 'HASE',
    'TSE': 'TKSE',
  };

  static Map<String, String> buyOrder = {
    'NAS': 'VTTT1002U',
    'NYS': 'VTTT1002U',
    'AMS': 'VTTT1002U',
    'HKS': 'VTTS1002U',
    'SHS': 'VTTS0202U',
    'SZS': 'VTTS0305U',
    'HSX': 'VTTS0311U',
    'HNX': 'VTTS0311U',
    'TSE': 'VTTS0308U',
  };

  static Map<String, String> sellOrder = {
    'NAS': 'VTTT1001U',
    'NYS': 'VTTT1001U',
    'AMS': 'VTTT1001U',
    'HKS': 'VTTS1001U',
    'SHS': 'VTTS1005U',
    'SZS': 'VTTS0304U',
    'HSX': 'VTTS0310U',
    'HNX': 'VTTS0310U',
    'TSE': 'VTTS0307U',
  };

  static Map<String, String> sign = {
    '나스닥': '\$',
    '뉴욕': '\$',
    '홍콩': 'HK\$',
    '아멕스': '\$',
    '상해': '¥',
    '심천': '¥',
    '호치민': '₫',
    '하노이': '₫',
    '도쿄': '¥',
  };

  static Map<String, String> signExchange = {
    'NAS': '\$',
    'NYS': '\$',
    'HKS': 'HK\$',
    'AMS': '\$',
    'SHS': '¥',
    'SZS': '¥',
    'HSX': '₫',
    'HNX': '₫',
    'TSE': '¥',
  };

  static Map<String, String> transactionCurrency = {
    'NAS': 'USD',
    'NYS': 'USD',
    'HKS': 'HKD',
    'AMS': 'USD',
    'SHS': 'CNY',
    'SZS': 'CNY',
    'HSX': 'VND',
    'HNX': 'VND',
    'TSE': 'JPY',
  };

  static Map<String, String> nationCode = {
    'US': '미국',
    'CN': '중국',
    'HK': '홍콩',
    'JP': '일본',
    'VN': '베트남',
  };

  static Map<int, String> optToString = {
    1: '거래대금',
    2: '거래량',
    3: '시가총액',
    4: '급상승',
    5: '급하락',
  };
  // '나스닥', '뉴욕', '홍콩', '아멕스', '상해', '심천', '호치민', '하노이', '도쿄'
}
