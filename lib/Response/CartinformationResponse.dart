// To parse this JSON data, do
//
//     final cartinformationResponse = cartinformationResponseFromJson(jsonString);

import 'dart:convert';

CartinformationResponse cartinformationResponseFromJson(String str) =>
    CartinformationResponse.fromJson(json.decode(str));

String cartinformationResponseToJson(CartinformationResponse data) =>
    json.encode(data.toJson());

class CartinformationResponse {
  CartinformationResponse({
    this.status,
    this.msg,
    this.result,
    this.requestsessionid,
    this.sessionvalueinfo,
  });

  final String? status;
  final String? msg;
  final Result? result;
  final String? requestsessionid;
  final Sessionvalueinfo? sessionvalueinfo;

  factory CartinformationResponse.fromJson(Map<String, dynamic> json) =>
      CartinformationResponse(
        status: json["status"],
        msg: json["msg"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        requestsessionid: json["requestsessionid"],
        sessionvalueinfo: json["sessionvalueinfo"] == null
            ? null
            : Sessionvalueinfo.fromJson(json["sessionvalueinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "result": result?.toJson(),
        "requestsessionid": requestsessionid,
        "sessionvalueinfo": sessionvalueinfo?.toJson(),
      };
}

class Result {
  Result({
    this.eventId,
    this.eventUrl,
    this.eventTitle,
    this.eventDetail,
    this.eventDate,
    this.eventTime,
    this.eventseconddatetime,
    this.eventInfo,
    this.eventSmallImage,
    this.eventStageLocation,
    this.seatingPlan,
    this.isSeatBooking,
    this.enableAttendee,
    this.venueAddress,
    this.venuepostCode,
    this.venueState,
    this.venueCountry,
    this.eventtype,
    this.promoterDetail,
    this.currencySymbol,
    this.currencyCode,
    this.ticketInformation,
    this.formAction,
    this.promoterId,
    this.promoterStripeAccountId,
    this.isEventStripeConnect,
    this.customerCountry,
    this.customerState,
    this.customerSession,
    this.customerCart,
    this.paymentMethod,
    this.bookingFee,
    this.couponcode,
    this.isPhoneBooking,
    this.showSkip,
  });

  final int? eventId;
  final String? eventUrl;
  final String? eventTitle;
  final String? eventDetail;
  final String? eventDate;
  final String? eventTime;
  final String? eventseconddatetime;
  final String? eventInfo;
  final String? eventSmallImage;
  final String? eventStageLocation;
  final String? seatingPlan;
  final String? isSeatBooking;
  final String? enableAttendee;
  final String? venueAddress;
  final String? venuepostCode;
  final String? venueState;
  final String? venueCountry;
  final String? eventtype;
  final String? promoterDetail;
  final String? currencySymbol;
  final String? currencyCode;
  final dynamic ticketInformation;
  final String? formAction;
  final String? promoterId;
  final String? promoterStripeAccountId;
  final String? isEventStripeConnect;
  final List<CustomerCountry>? customerCountry;
  final List<CustomerState>? customerState;
  final CustomerSession? customerSession;
  final CustomerCart? customerCart;
  final List<PaymentMethod>? paymentMethod;
  final BookingFee? bookingFee;
  final List<dynamic>? couponcode;
  final String? isPhoneBooking;
  final int? showSkip;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        eventId: json["EventId"],
        eventUrl: json["eventURL"],
        eventTitle: json["eventTitle"],
        eventDetail: json["eventDetail"],
        eventDate: json["eventDate"],
        eventTime: json["eventTime"],
        eventseconddatetime: json["eventseconddatetime"],
        eventInfo: json["eventInfo"],
        eventSmallImage: json["eventSmallImage"],
        eventStageLocation: json["eventStageLocation"],
        seatingPlan: json["seatingPlan"],
        isSeatBooking: json["isSeatBooking"],
        enableAttendee: json["enable_attendee"],
        venueAddress: json["venueAddress"],
        venuepostCode: json["venuepostCode"],
        venueState: json["venueState"],
        venueCountry: json["venueCountry"],
        eventtype: json["eventtype"],
        promoterDetail: json["promoterDetail"],
        currencySymbol: json["CurrencySymbol"],
        currencyCode: json["CurrencyCode"],
        ticketInformation: json["ticketInformation"],
        formAction: json["formAction"],
        promoterId: json["PromoterId"],
        promoterStripeAccountId: json["PromoterStripeAccountId"],
        isEventStripeConnect: json["isEventStripeConnect"],
        customerCountry: json["customerCountry"] == null
            ? []
            : List<CustomerCountry>.from(json["customerCountry"]!
                .map((x) => CustomerCountry.fromJson(x))),
        customerState: json["customerState"] == null
            ? []
            : List<CustomerState>.from(
                json["customerState"]!.map((x) => CustomerState.fromJson(x))),
        customerSession: json["customerSession"] == null
            ? null
            : CustomerSession.fromJson(json["customerSession"]),
        customerCart: json["customerCart"] == null
            ? null
            : CustomerCart.fromJson(json["customerCart"]),
        paymentMethod: json["paymentMethod"] == null
            ? []
            : List<PaymentMethod>.from(
                json["paymentMethod"]!.map((x) => PaymentMethod.fromJson(x))),
        bookingFee: json["bookingFee"] == null
            ? null
            : BookingFee.fromJson(json["bookingFee"]),
        couponcode: json["couponcode"] == null
            ? []
            : List<dynamic>.from(json["couponcode"]!.map((x) => x)),
        isPhoneBooking: json["isPhoneBooking"],
        showSkip: json["showSkip"],
      );

  Map<String, dynamic> toJson() => {
        "EventId": eventId,
        "eventURL": eventUrl,
        "eventTitle": eventTitle,
        "eventDetail": eventDetail,
        "eventDate": eventDate,
        "eventTime": eventTime,
        "eventseconddatetime": eventseconddatetime,
        "eventInfo": eventInfo,
        "eventSmallImage": eventSmallImage,
        "eventStageLocation": eventStageLocation,
        "seatingPlan": seatingPlan,
        "isSeatBooking": isSeatBooking,
        "enable_attendee": enableAttendee,
        "venueAddress": venueAddress,
        "venuepostCode": venuepostCode,
        "venueState": venueState,
        "venueCountry": venueCountry,
        "eventtype": eventtype,
        "promoterDetail": promoterDetail,
        "CurrencySymbol": currencySymbol,
        "CurrencyCode": currencyCode,
        "ticketInformation": ticketInformation,
        "formAction": formAction,
        "PromoterId": promoterId,
        "PromoterStripeAccountId": promoterStripeAccountId,
        "isEventStripeConnect": isEventStripeConnect,
        "customerCountry": customerCountry == null
            ? []
            : List<dynamic>.from(customerCountry!.map((x) => x.toJson())),
        "customerState": customerState == null
            ? []
            : List<dynamic>.from(customerState!.map((x) => x.toJson())),
        "customerSession": customerSession?.toJson(),
        "customerCart": customerCart?.toJson(),
        "paymentMethod": paymentMethod == null
            ? []
            : List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
        "bookingFee": bookingFee?.toJson(),
        "couponcode": couponcode == null
            ? []
            : List<dynamic>.from(couponcode!.map((x) => x)),
        "isPhoneBooking": isPhoneBooking,
        "showSkip": showSkip,
      };
}

class BookingFee {
  BookingFee({
    this.planArray,
    this.cutomerFeePerBooking,
    this.organizerFee,
  });

  final PlanArray? planArray;
  // final List<CutomerFeePerBooking>? cutomerFeePerBooking;
  final List<CutomerFeePerBooking>? cutomerFeePerBooking;
  final dynamic organizerFee;

  factory BookingFee.fromJson(Map<String, dynamic> json) => BookingFee(
        planArray: json["planArray"] == null
            ? null
            : PlanArray.fromJson(json["planArray"]),
        cutomerFeePerBooking: json["cutomerFeePerBooking"] == null ||
                json["cutomerFeePerBooking"].runtimeType ==
                    int // In some event cutomerFeePerBooking is coming 0 in api
            ? []
            : List<CutomerFeePerBooking>.from(json["cutomerFeePerBooking"]!
                .map((x) => CutomerFeePerBooking.fromJson(x))),
        organizerFee: json["organizerFee"],
      );

  Map<String, dynamic> toJson() => {
        "planArray": planArray?.toJson(),
        "cutomerFeePerBooking": cutomerFeePerBooking == null
            ? []
            : List<dynamic>.from(cutomerFeePerBooking!.map((x) => x.toJson())),
        "organizerFee": organizerFee,
      };
}

class CutomerFeePerBooking {
  CutomerFeePerBooking({
    this.planId,
    this.tariffId,
    this.tariffName,
    this.tariffType,
    this.tariffPaymentMethodId,
    this.tariffGatewayid,
    this.tariffCredicardId,
    this.tariffFeeType,
    this.tariffFeeModifier,
    this.tarriffPaidBy,
    this.tariffStartAmount,
    this.tariffEndAmount,
    this.customerFee,
  });

  final String? planId;
  final String? tariffId;
  final String? tariffName;
  final String? tariffType;
  final String? tariffPaymentMethodId;
  final dynamic tariffGatewayid;
  final dynamic tariffCredicardId;
  final String? tariffFeeType;
  final String? tariffFeeModifier;
  final String? tarriffPaidBy;
  final String? tariffStartAmount;
  final String? tariffEndAmount;
  final int? customerFee;

  factory CutomerFeePerBooking.fromJson(Map<String, dynamic> json) =>
      CutomerFeePerBooking(
        planId: json["PlanId"],
        tariffId: json["tariff_id"],
        tariffName: json["tariff_name"],
        tariffType: json["tariff_type"],
        tariffPaymentMethodId: json["tariff_payment_method_id"],
        tariffGatewayid: json["tariff_gatewayid"],
        tariffCredicardId: json["tariff_credicard_id"],
        tariffFeeType: json["tariff_fee_type"],
        tariffFeeModifier: json["tariff_fee_modifier"],
        tarriffPaidBy: json["tarriff_paid_by"],
        tariffStartAmount: json["tariff_start_amount"],
        tariffEndAmount: json["tariff_end_amount"],
        customerFee: json["CustomerFee"],
      );

  Map<String, dynamic> toJson() => {
        "PlanId": planId,
        "tariff_id": tariffId,
        "tariff_name": tariffName,
        "tariff_type": tariffType,
        "tariff_payment_method_id": tariffPaymentMethodId,
        "tariff_gatewayid": tariffGatewayid,
        "tariff_credicard_id": tariffCredicardId,
        "tariff_fee_type": tariffFeeType,
        "tariff_fee_modifier": tariffFeeModifier,
        "tarriff_paid_by": tarriffPaidBy,
        "tariff_start_amount": tariffStartAmount,
        "tariff_end_amount": tariffEndAmount,
        "CustomerFee": customerFee,
      };
}

class PlanArray {
  PlanArray({
    this.planId,
    this.planName,
    this.planDescription,
  });

  final String? planId;
  final String? planName;
  final String? planDescription;

  factory PlanArray.fromJson(Map<String, dynamic> json) => PlanArray(
        planId: json["PlanId"],
        planName: json["PlanName"],
        planDescription: json["planDescription"],
      );

  Map<String, dynamic> toJson() => {
        "PlanId": planId,
        "PlanName": planName,
        "planDescription": planDescription,
      };
}

class CustomerCart {
  CustomerCart({
    this.customerTicketInformation,
    this.cartInformation,
    this.customerattendee,
  });

  final dynamic customerTicketInformation;
  final CartInformation? cartInformation;
  final List<dynamic>? customerattendee;

  factory CustomerCart.fromJson(Map<String, dynamic> json) => CustomerCart(
        customerTicketInformation: json["CustomerTicketInformation"],
        cartInformation: json["CartInformation"] == null
            ? null
            : CartInformation.fromJson(json["CartInformation"]),
        customerattendee: json["customerattendee"] == null
            ? []
            : List<dynamic>.from(json["customerattendee"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "CustomerTicketInformation": customerTicketInformation,
        "CartInformation": cartInformation?.toJson(),
        "customerattendee": customerattendee == null
            ? []
            : List<dynamic>.from(customerattendee!.map((x) => x)),
      };
}

class CartInformation {
  CartInformation({
    this.seatname,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.cartGrandTotal,
    this.isDescount,
    this.totalDiscount,
    this.eventType,
    this.promoCode,
    this.promoid,
    this.cartReleaseMin,
    this.cartReleaseSec,
  });

  final dynamic seatname;
  final dynamic totalPrice;
  final dynamic totalPriceAfterDiscount;
  final dynamic cartGrandTotal;
  final dynamic isDescount;
  final dynamic totalDiscount;
  final String? eventType;
  final dynamic promoCode;
  final dynamic promoid;
  final dynamic cartReleaseMin;
  final dynamic cartReleaseSec;

  factory CartInformation.fromJson(Map<String, dynamic> json) =>
      CartInformation(
        seatname: json["seatname"],
        totalPrice: json["TotalPrice"],
        totalPriceAfterDiscount: json["TotalPriceAfterDiscount"],
        cartGrandTotal: json["CartGrandTotal"],
        isDescount: json["IsDescount"],
        totalDiscount: json["TotalDiscount"],
        eventType: json["EventType"],
        promoCode: json["PromoCode"],
        promoid: json["promoid"],
        cartReleaseMin: json["CartReleaseMin"],
        cartReleaseSec: json["CartReleaseSec"],
      );

  Map<String, dynamic> toJson() => {
        "seatname": seatname,
        "TotalPrice": totalPrice,
        "TotalPriceAfterDiscount": totalPriceAfterDiscount,
        "CartGrandTotal": cartGrandTotal,
        "IsDescount": isDescount,
        "TotalDiscount": totalDiscount,
        "EventType": eventType,
        "PromoCode": promoCode,
        "promoid": promoid,
        "CartReleaseMin": cartReleaseMin,
        "CartReleaseSec": cartReleaseSec,
      };
}

class CustomerCountry {
  CustomerCountry({
    this.countryId,
    this.countryName,
  });

  final String? countryId;
  final String? countryName;

  factory CustomerCountry.fromJson(Map<String, dynamic> json) =>
      CustomerCountry(
        countryId: json["CountryId"],
        countryName: json["CountryName"],
      );

  Map<String, dynamic> toJson() => {
        "CountryId": countryId,
        "CountryName": countryName,
      };
}

class CustomerSession {
  CustomerSession({
    this.member,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.streetName,
    this.city,
    this.countryId,
    this.stateId,
    this.postCode,
  });

  final Member? member;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? streetName;
  final String? city;
  final String? countryId;
  final String? stateId;
  final String? postCode;

  factory CustomerSession.fromJson(Map<String, dynamic> json) =>
      CustomerSession(
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
        firstName: json["FirstName"],
        lastName: json["LastName"],
        mobile: json["Mobile"],
        email: json["Email"],
        streetName: json["street_name"],
        city: json["city"],
        countryId: json["countryId"],
        stateId: json["stateId"],
        postCode: json["post_code"],
      );

  Map<String, dynamic> toJson() => {
        "member": member?.toJson(),
        "FirstName": firstName,
        "LastName": lastName,
        "Mobile": mobile,
        "Email": email,
        "street_name": streetName,
        "city": city,
        "countryId": countryId,
        "stateId": stateId,
        "post_code": postCode,
      };
}

class Member {
  Member({
    this.id,
    this.userRoletype,
    this.cart,
  });

  final String? id;
  final String? userRoletype;
  final Cart? cart;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["ID"],
        userRoletype: json["user_roletype"],
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "user_roletype": userRoletype,
        "cart": cart?.toJson(),
      };
}

class Cart {
  Cart({
    this.blockTime,
    this.releasetime,
  });

  final String? blockTime;
  final String? releasetime;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        blockTime: json["blockTime"],
        releasetime: json["releasetime"],
      );

  Map<String, dynamic> toJson() => {
        "blockTime": blockTime,
        "releasetime": releasetime,
      };
}

class CustomerState {
  CustomerState({
    this.stateId,
    this.stateName,
  });

  final String? stateId;
  final String? stateName;

  factory CustomerState.fromJson(Map<String, dynamic> json) => CustomerState(
        stateId: json["StateId"],
        stateName: json["StateName"],
      );

  Map<String, dynamic> toJson() => {
        "StateId": stateId,
        "StateName": stateName,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.methodName,
    this.paymentProcessor,
    this.paymentGroupCustomer,
    this.paymentGroupAffiliate,
    this.paymentGroupPromoter,
    this.paymentGroupAdmin,
    this.paymentGroupGuest,
    this.paymentTemplate,
    this.paymentDescription,
    this.displaydiv,
    this.paymentProcessorDetails,
  });

  final String? id;
  final String? methodName;
  final String? paymentProcessor;
  final String? paymentGroupCustomer;
  final String? paymentGroupAffiliate;
  final String? paymentGroupPromoter;
  final String? paymentGroupAdmin;
  final String? paymentGroupGuest;
  final String? paymentTemplate;
  final String? paymentDescription;
  final String? displaydiv;
  final PaymentProcessorDetails? paymentProcessorDetails;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        methodName: json["method_name"],
        paymentProcessor: json["payment_processor"],
        paymentGroupCustomer: json["payment_group_customer"],
        paymentGroupAffiliate: json["payment_group_affiliate"],
        paymentGroupPromoter: json["payment_group_promoter"],
        paymentGroupAdmin: json["payment_group_admin"],
        paymentGroupGuest: json["payment_group_guest"],
        paymentTemplate: json["payment_template"],
        paymentDescription: json["payment_description"],
        displaydiv: json["displaydiv"],
        paymentProcessorDetails: json["payment_processor_details"] == null
            ? null
            : PaymentProcessorDetails.fromJson(
                json["payment_processor_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method_name": methodName,
        "payment_processor": paymentProcessor,
        "payment_group_customer": paymentGroupCustomer,
        "payment_group_affiliate": paymentGroupAffiliate,
        "payment_group_promoter": paymentGroupPromoter,
        "payment_group_admin": paymentGroupAdmin,
        "payment_group_guest": paymentGroupGuest,
        "payment_template": paymentTemplate,
        "payment_description": paymentDescription,
        "displaydiv": displaydiv,
        "payment_processor_details": paymentProcessorDetails?.toJson(),
      };
}

class PaymentProcessorDetails {
  PaymentProcessorDetails({
    this.testSecretkey,
    this.testPublishablekey,
    this.liveSecretkey,
    this.livePublishablekey,
    this.liveStatementdescriptor,
    this.currency,
    this.mode,
  });

  final String? testSecretkey;
  final String? testPublishablekey;
  final String? liveSecretkey;
  final String? livePublishablekey;
  final String? liveStatementdescriptor;
  final String? currency;
  final String? mode;

  factory PaymentProcessorDetails.fromJson(Map<String, dynamic> json) =>
      PaymentProcessorDetails(
        testSecretkey: json["test_secretkey"],
        testPublishablekey: json["test_publishablekey"],
        liveSecretkey: json["live_secretkey"],
        livePublishablekey: json["live_publishablekey"],
        liveStatementdescriptor: json["live_statementdescriptor"],
        currency: json["currency"],
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "test_secretkey": testSecretkey,
        "test_publishablekey": testPublishablekey,
        "live_secretkey": liveSecretkey,
        "live_publishablekey": livePublishablekey,
        "live_statementdescriptor": liveStatementdescriptor,
        "currency": currency,
        "mode": mode,
      };
}

class Sessionvalueinfo {
  Sessionvalueinfo({
    this.member,
  });

  final Member? member;

  factory Sessionvalueinfo.fromJson(Map<String, dynamic> json) =>
      Sessionvalueinfo(
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "member": member?.toJson(),
      };
}
