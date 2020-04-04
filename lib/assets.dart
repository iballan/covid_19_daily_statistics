import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class I18n {
  final I18nLookup _lookup;

  I18n(this._lookup);

  static Locale _locale;

  static Locale get currentLocale => _locale;

  /// add custom locale lookup which will be called first
  static I18nLookup customLookup;

  static const I18nDelegate delegate = I18nDelegate();

  static I18n of(BuildContext context) => Localizations.of<I18n>(context, I18n);

  static List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en"),
      Locale("tr")
    ];
  }

  ///
  /// <table style="width:100%">
  ///   <tr>
  ///     <th>Locale</th>
  ///     <th>Translation</th>
  ///   </tr>
  ///   <tr>
  ///     <td style="width:60px;">en</td>
  ///     <td>"Covid19"</td>
  ///   </tr>
  ///   <tr>
  ///     <td style="width:60px;">tr</td>
  ///     <td>"Covid19"</td>
  ///   </tr>
  ///  </table>
  ///
  String get appName {
    return customLookup?.appName ?? _lookup.appName;
  }

  String getString(String key, [Map<String, String> placeholders]) {
    switch (key) {
      case I18nKeys.appName:
        return appName;
    }
    return null;
  }
}

class I18nKeys {
  static const String appName = "appName";
}

class I18nLookup {
  String getString(String key, [Map<String, String> placeholders]) {
    return null;
  }

  String get appName {
    return getString(I18nKeys.appName);
  }
}

class I18nLookup_tr extends I18nLookup_en {
  @override
  String get appName {
    return "Covid19";
  }
}

class I18nLookup_en extends I18nLookup {
  @override
  String get appName {
    return "Covid19";
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  @override
  Future<I18n> load(Locale locale) {
    I18n._locale = locale;
    return SynchronousFuture<I18n>(I18n(_findLookUpFromLocale(locale)));
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(I18nDelegate old) => false;

  I18nLookup _findLookUpFromLocale(Locale locale) {
    final String languageCode = locale != null ? locale.languageCode : "";
    switch (languageCode) {
        case "tr":
          return I18nLookup_tr();
        case "en":
          return I18nLookup_en();
    }
    return I18nLookup_en();
  }
}

class Assets {
  /// ![](file:///Users/mbh/Documents/mbh_proj/mob/cross/covid_19_daily_statistics/lib/assets/i18n/en.arb)
  static const String en = "lib/assets/i18n/en.arb";
  /// ![](file:///Users/mbh/Documents/mbh_proj/mob/cross/covid_19_daily_statistics/lib/assets/i18n/tr.arb)
  static const String tr = "lib/assets/i18n/tr.arb";
}

