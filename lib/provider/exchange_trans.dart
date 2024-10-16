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

  static Map<String, String> money = {
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
  // '나스닥', '뉴욕', '홍콩', '아멕스', '상해', '심천', '호치민', '하노이', '도쿄'
}
