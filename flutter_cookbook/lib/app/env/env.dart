// Flutter 서버 환경 분리 클래스
// Dev : 개발 및 테스트 진행 환경
// Stag : Dev 개발 완료 후 개발된 API를 테스트하는 환경
// Prod : 실제 서비스 환경

enum BuildType {
  dev,
  stag,
  prod,
}

class Env {
  static Env? _instance;
  static get instance => _instance;
  late BuildType _buildType;

  Env(BuildType buildType) {
    _buildType = buildType;
  }

  factory Env.getInstance(BuildType buildType) {
    _instance ??= Env(buildType);
    return _instance!;
  }

  String getScheme() {
    if (_buildType == BuildType.dev) {
      return 'http';
    } else {
      return 'https';
    }
  }

  String getHost() {
    if (_buildType == BuildType.dev) {
      return 'localhost:8080';
    } else if (_buildType == BuildType.stag) {
      return '';
    } else {
      return '';
    }
  }

  String getApiKey() {
    if (_buildType == BuildType.dev) {
      return '';
    } else if (_buildType == BuildType.stag) {
      return '';
    } else {
      return '';
    }
  }
}
