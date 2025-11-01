enum Flavor {
  development,
  production,
  staging,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'versioned_flavors development';
      case Flavor.production:
        return 'versioned_flavors production';
      case Flavor.staging:
        return 'versioned_flavors staging';
    }
  }

}
