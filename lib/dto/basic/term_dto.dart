// ignore_for_file: non_constant_identifier_names

class TermDTO {
  final String AUTH, EXCD, SYMB, GUBN, BYMD, MODP, KEYB;

  TermDTO({
    required this.EXCD,
    required this.SYMB,
    required this.GUBN,
    this.AUTH = '',
    this.BYMD = '',
    this.KEYB = '',
    this.MODP = '0',
  });

  Uri convert(String baseUrl) {
    return Uri.parse('$baseUrl?AUTH=$AUTH&BYMD=$BYMD&EXCD=$EXCD&GUBN=$GUBN&'
        'KEYB=$KEYB&MODP=$MODP&SYMB=$SYMB');
  }
}
