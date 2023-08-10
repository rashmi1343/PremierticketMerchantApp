import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/bloc/login_bloc.dart';
import '../../login/view/login_page.dart';
import '../../repository/PtkmerchantRepository.dart';
import 'SplashScreenController.dart';

import 'package:get/get.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () =>     Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => LoginBloc(ptkrepository: PtkmerchantRepository()),
            child: LoginPage(Repository: PtkmerchantRepository()),
          );
        })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Image.asset("assets/images/ptk_icon_new.png",
              height: 100, width: double.infinity, fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
// class SplashPage extends StatelessWidget {
//   final splashController = Get.put(SplashScreenController());
//
//   // void initState() {
//   //   super.initState();
//   //   Timer(
//   //       Duration(seconds: 3),
//   //       () =>     Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //         return BlocProvider(
//   //           create: (context) => LoginBloc(ptkrepository: PtkmerchantRepository()),
//   //           child: LoginPage(Repository: PtkmerchantRepository()),
//   //         );
//   //       })));
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     splashController.startAnimation();
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Stack(
//           children: [
//             Obx(() => AnimatedPositioned(
//                   duration: const Duration(milliseconds: 1000),
//                   top: splashController.animate.value ? 0 : -30,
//                   left: splashController.animate.value ? 10 : -70,
//                   bottom: splashController.animate.value ? 60 : 0,
//                   child: Container(
//                       margin: const EdgeInsets.only(top: 20),
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.all(10),
//                       child: const Image(
//                         image: AssetImage("assets/images/ptk_icon_new.png"),
//                         width: 350,
//
//                       )),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
