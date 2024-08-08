import 'dart:developer';

enum EnvType {
  dev(
    title: "dev",
    ssoUrl: "",
    vapgUrl: "",
    payUrl: "",
    probitUrl: "https://api.probit.com/api/exchange/v1/ticker",
    exchangeUrl:
        "https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRWUSD",
  ),
  test(
    title: "test",
    ssoUrl: "",
    vapgUrl: "",
    payUrl: "",
    probitUrl: "https://api.probit.com/api/exchange/v1/ticker",
    exchangeUrl:
        "https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRWUSD",
  ),
  prod(
    title: "prod",
    ssoUrl: "",
    vapgUrl: "",
    payUrl: "",
    probitUrl: "https://api.probit.com/api/exchange/v1/ticker",
    exchangeUrl:
        "https://quotation-api-cdn.dunamu.com/v1/forex/recent?codes=FRX.KRWUSD",
  );

  final String title;
  final String ssoUrl;
  final String vapgUrl;
  final String payUrl;
  final String probitUrl;
  final String exchangeUrl;

  const EnvType({
    required this.title,
    required this.ssoUrl,
    required this.vapgUrl,
    required this.payUrl,
    required this.probitUrl,
    required this.exchangeUrl,
  });
}

abstract class Env {
  static EnvType _envType = EnvType.dev;
  static String _ssoUrl = EnvType.dev.ssoUrl;
  static String _vapgUrl = EnvType.dev.vapgUrl;
  static String _payUrl = EnvType.dev.payUrl;

  static EnvType get envType => Env._envType;
  static String get ssoUrl => Env._ssoUrl;
  static String get vapgUrl => Env._vapgUrl;
  static String get payUrl => Env._payUrl;

  static void initialize({
    required String envType,
    required String ssoUrl,
    required String vapgUrl,
    required String payUrl,
  }) {
    Env._envType = toEnum(
      envType: envType,
      ssoUrl: ssoUrl,
      vapgUrl: vapgUrl,
      payUrl: payUrl,
    );
    Env._ssoUrl = ssoUrl;
    Env._vapgUrl = vapgUrl;
    Env._payUrl = payUrl;
  }

  static EnvType toEnum({
    String? envType,
    String? ssoUrl,
    String? vapgUrl,
    String? payUrl,
  }) {
    EnvType? _envType;
    String? _ssoUrl;
    String? _vapgUrl;
    String? _payUrl;
    switch (envType) {
      case 'dev':
        _envType = EnvType.dev;
        _ssoUrl = EnvType.dev.ssoUrl;
        _vapgUrl = EnvType.dev.vapgUrl;
        _payUrl = EnvType.dev.payUrl;
      case 'test':
        _envType = EnvType.test;
        _ssoUrl = EnvType.test.ssoUrl;
        _vapgUrl = EnvType.test.vapgUrl;
        _payUrl = EnvType.test.payUrl;
      case 'prod':
        _envType = EnvType.prod;
        _ssoUrl = EnvType.prod.ssoUrl;
        _vapgUrl = EnvType.prod.vapgUrl;
        _payUrl = EnvType.prod.payUrl;
      default:
        _envType = EnvType.dev;
        _ssoUrl = EnvType.dev.ssoUrl;
        _vapgUrl = EnvType.dev.vapgUrl;
        _payUrl = EnvType.dev.payUrl;
    }
    // log(_envType.toString(), name: "BuildMode");
    // log(_baseUrl.toString(), name: "BaseUrl");
    return _envType;
  }
}
