import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'common/theme.dart';
import 'generated/l10n.dart';
import 'models/movie.dart';
import 'ui/movie.dart';
import 'ui/my_movies.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //can't turn the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieModel()),
      ],
      child: MaterialApp(
        // scale
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          // maxWidth: 1200,
          minWidth: 400,
          defaultScale: true,
        ),

        //language
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,

        //title && theme
        title: "Title",
        theme: appTheme,

        //routes
        initialRoute: '/',
        routes: {
          '/': (context) => MyMovies(),
          '/movie': (context) => Movie(),
        },
      ),
    );
  }
}
