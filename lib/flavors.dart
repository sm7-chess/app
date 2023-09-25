enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Dev';
      case Flavor.staging:
        return 'Beta';
      case Flavor.prod:
        return 'Prod';
      default:
        return 'title';
    }
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'D2Chess Dev';
      case Flavor.staging:
        return 'D2Chess Beta';
      case Flavor.prod:
        return 'D2Chess';
      default:
        return 'title';
    }
  }
}
