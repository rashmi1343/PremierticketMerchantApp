import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ptk_merchant/repository/PtkmerchantRepository.dart';

import '../../login/view/login_page.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find =>Get.find();


  RxBool animate=false.obs;
   Future startAnimation() async{
     await Future.delayed(const Duration(milliseconds: 200));
     animate.value=true;
     await Future.delayed(const Duration(milliseconds: 2000));

     Get.to(LoginPage(Repository: PtkmerchantRepository(),));
   }
}