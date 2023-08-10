import 'dart:convert';

class ApiConstant {
  static String url = "https://dev.premiertickets.co/";

  static String getAuthKeyBaseString() {
    final strBytes = utf8.encode("20A0751C-9FEE-47F8-A6A9-335BE39834");
    return base64.encode(strBytes);
  }

  static const stripePublishableKey = "pk_test_45snJR3JtbYZ3cnjWBJiTPuJ";

  /**
    "test_publishablekey" : "pk_test_45snJR3JtbYZ3cnjWBJiTPuJ",
   "test_secretkey" : "sk_test_N4BRpPt1kiXb435XPCEgMiWL",
   */
}
