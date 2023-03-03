enum Flavor { DEV, PROD, TEST }

class Config {
  static Flavor? appFlavor;
  static String get baseUrlLogin {
    switch (appFlavor) {
      case Flavor.DEV:
        // return 'https://pselier.com/kitty/public_html/api/plus/v1/';
        // return 'https://server.aljasglobalexports.com/kitty/public_html/api/plus/v1/';
        return 'https://api.getplus.in/api/plus/v1/';
      case Flavor.PROD:
        // return 'https://pselier.com/kitty/public_html/api/plus/v1/';
        return 'https://api.getplus.in/api/plus/v1/';

      default:
        // return 'https://pselier.com/kitty/public_html/api/plus/v1/';
        return 'https://api.getplus.in/api/plus/v1/';
    }
  }
}
