import 'package:mockin/api/favorite_api.dart';
import 'package:mockin/dto/favorite/favorite_stock_dto.dart';

class FavoriteData {
  static final FavoriteData _instance = FavoriteData._internal();

  factory FavoriteData() {
    return _instance;
  }

  FavoriteData._internal();

  // 이런 형식
  Map<String, List<String>> data = {
    'NAS': [],
    'NYS': [],
    'HKS': [],
    'AMS': [],
    'SHS': [],
    'SZS': [],
    'HSX': [],
    'HNX': [],
    'TSE': [],
  };

  // read를 수행하여 각 거래소의 선호 종목을 채움
  Future<void> init() async {
    data = await FavoriteApi.readFavoriteStock();
  }

  // 거래소 코드, 종목 코드를 받아 선호 종목 여부 확인
  bool isFavorite({required String excd, required String symb}) {
    return data[excd]!.contains(symb);
  }

  // 변수로 넘겨받은 거래소의 선호 종목 리스트 반환
  List<String> excdFavorite({required String excd}) {
    return data[excd]!;
  }

  // 선호 종목 추가/삭제
  Future<bool> favoriteChange(
      {required String excd,
      required String symb,
      required bool addOrDelete}) async {
    if (!addOrDelete) {
      // 추가
      data[excd]!.add(symb);
    } else {
      // 삭제
      data[excd]!.remove(symb);
    }

    return await FavoriteApi.addDeleteFavorite(
        DTO: FavoriteStockDTO(excd: excd, symb: symb));
  }
}
