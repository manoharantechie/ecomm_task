
import 'package:e_comm/src/core/utills/init_setup.dart';
import 'package:e_comm/src/core/routes/route_config.dart';
import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/core/theme/themes.dart';
import 'package:e_comm/src/features/domain/cubit/product/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:e_comm/src/core/localization/localizations.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver = RouteObserver<PageRoute<dynamic>>();

void main() async {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

    statusBarColor: Color(0xFFFFFFFF),
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light, // status bar icon color
    systemNavigationBarIconBrightness:
    Brightness.light, // color of navigation controls
  ));
  injectionSetup();

  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }





  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouteConf>().router;

    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProductCubit()),
        ],child:    MaterialApp.router(
        title: "E-Commerce",
        theme: CustomTheme.of(context),
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        localizationsDelegates: const [
          AppLocalizationsDelegate( ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        })
    );

  }



}