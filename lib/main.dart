import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ptk_merchant/splash/view/splash_page.dart';
import 'package:ptk_merchant/util/appConstant.dart';
import 'login/view/validation_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icon color
    ));

    Stripe.publishableKey = ApiConstant.stripePublishableKey;

    return ChangeNotifierProvider(
        create: (context) => ValidationProvider(),
        // ← create/init your state model
        child: MaterialApp(
            title: 'Premier Ticket Merchant',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            home: SplashPage()
            // BlocProvider(
            //   create: (context) =>
            //       LoginBloc(ptkrepository: PtkmerchantRepository()),
            //   child: LoginPage(Repository: PtkmerchantRepository()),
            //
            // ),

            ));
  }
}
