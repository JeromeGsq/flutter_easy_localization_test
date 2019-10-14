Flutter easy localization
===============

**easy_localization package**: https://pub.dev/packages/easy_localization

• **files and folders**
```dart
Project
+-- resources
|    +-- langs   
|        |-- en-GB.json
|        |-- en-US.json
|        +-- fr-FR.json
+-- lib
     +-- main.dart

```
• **fr-FR.json**
```json
{
    "title": "Bonjour depuis FR",
    "hello": "Bonjour",
    "contact": {
        "phone": "téléphone",
        "email": "courriel"
    },
    "keyOnlyExistInFRJson": "Cette clé n'existe que dans le fichier fr-FR.json"
}
```

• **main.dart**

Configure supported locales in `supportedLocales`
```dart
// You need to configure supported locales here
// You need to configure Info.plist too
//
// The order of this list matters. By default, if the
// device's locale doesn't exactly match a locale in
// supportedLocales then the first locale in
// supportedLocales with a matching
// Locale.languageCode is used. If that fails then the
// first locale in supportedLocales is used.
final supportedLocales = [
  Locale("en", "US"),
  Locale("en", "GB"),
  Locale("fr", "FR"),
];
```

```dart
// Wrap with EasyLocalization
void main() => runApp(EasyLocalization(child: MyApp()));
```

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          // Configure EasylocaLization delegate
          EasylocaLizationDelegate(locale: data.locale, path: 'resources/langs'),
        ],
        supportedLocales: supportedLocales,
        locale: data.savedLocale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

• **Use key inside widget tree** 
```dart
// Display title with the correct locale
Text(AppLocalizations.of(context).tr('title')),

// Display sub key
Text(AppLocalizations.of(context).tr('contact.email')),

// If the key does not exist, AppLocalizations will return the key name 'keyOnlyExistInFRJson'
Text(AppLocalizations.of(context).tr('keyOnlyExistInFRJson')),
```

• **Swap language** 
```dart
// Swap locale at runtime
void _switchLanguage() {
  setState(() {
    EasyLocalizationProvider.of(context).data.changeLocale(Locale("fr", "FR"));
  });
}
```

Pro/Cons
===============
**Pros:**
- Support multiple language/country configurations (ex: `en-GB` and `en-US`)
- Classic JSON file format
- You can sort values with subkeys like `contact.phone`
- Don't need to regenerate files or execute command lines

**Cons:** 
- Must declare each json files in the pubspec.yaml as assets