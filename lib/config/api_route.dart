import 'env_constants.dart';

enum Flavor { develop, qa, staging, production, local }

class APIEndpoints {
  const APIEndpoints._();

  static String get appApiBaseUrl {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        return '';
      case Flavor.qa:
        return 'BaseUrl';
      case Flavor.staging:
        return 'https://pixabay.com/api/';
      case Flavor.production:
        return 'BaseUrl';
      case Flavor.local:
        return 'BaseUrl';
    }
  }
}