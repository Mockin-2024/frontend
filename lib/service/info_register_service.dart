import 'package:mockin/api/account_api.dart';
import 'package:mockin/dto/account/acnt_num_register_dto.dart';
import 'package:mockin/dto/account/key_pair_register_dto.dart';

class InfoRegisterService {
  // 계좌번호 등록
  static accountRegister({
    required String accountNumber,
  }) async {
    if (accountNumber.isNotEmpty) {
      await AccountApi.accountRegister(
        DTO: AcntNumRegisterDTO(
          accountNumber: accountNumber,
        ),
      );
    }
  }

  // 모의키 등록
  static mockKeyRegister({
    required String mockAppkey,
    required String mockAppsecretkey,
  }) async {
    if (mockAppkey.isNotEmpty && mockAppsecretkey.isNotEmpty) {
      await AccountApi.mockKeyRegister(
        DTO: KeyPairRegisterDTO(
          appKey: mockAppkey,
          appSecret: mockAppsecretkey,
        ),
      );
    }
  }

  // 실전키 등록
  static realKeyRegister({
    required String realAppkey,
    required String realAppsecretkey,
  }) async {
    if (realAppkey.isNotEmpty && realAppsecretkey.isNotEmpty) {
      await AccountApi.realKeyRegister(
        DTO: KeyPairRegisterDTO(
          appKey: realAppkey,
          appSecret: realAppsecretkey,
        ),
      );
    }
  }
}
