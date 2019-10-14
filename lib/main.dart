import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

// Encapsulate with EasyLocalization
void main() => runApp(EasyLocalization(child: MyApp()));

// Configure supported locales
var supportedLocales = [
  Locale('en', 'US'),
  Locale('en', 'GB'),
  Locale('fr', 'FR'),
];

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Swap locale at runtime
  int localIndex = 0;
  void _switchLanguage() {
    setState(() {
      localIndex = localIndex >= supportedLocales.length - 1 ? 0 : localIndex + 1;
      EasyLocalizationProvider.of(context).data.changeLocale(supportedLocales[localIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Localizations.localeOf(context) will return the application locale from the OS.
            Text("App current locale: ${Localizations.localeOf(context)}"),

            // Display title with the correct locale
            Text(AppLocalizations.of(context).tr('title')),

            // Display sub key
            Text(AppLocalizations.of(context).tr('contact.email')),

            // Display title with the correct locale
            Text(AppLocalizations.of(context).tr('keyOnlyExistInFRJson')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchLanguage,
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}
