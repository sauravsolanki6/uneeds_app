import 'dart:convert';

import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/deliveryaddress.dart';
import 'package:UNGolds/network/call/addnomineedetailscall.dart';
import 'package:UNGolds/network/call/bank_account_operation_call.dart';
import 'package:UNGolds/network/call/buy_gold_check_out.call.dart';
import 'package:UNGolds/network/call/buy_gold_on_emi.dart';
import 'package:UNGolds/network/call/buy_gold_place_order_call.dart';
import 'package:UNGolds/network/call/buygoldccavenucall.dart';
import 'package:UNGolds/network/call/buygoldwalletcall.dart';
import 'package:UNGolds/network/call/callforenachurl.dart';
import 'package:UNGolds/network/call/ccavenueapicall.dart';
import 'package:UNGolds/network/call/change_password_call.dart';
import 'package:UNGolds/network/call/deleteaccountcall.dart';
import 'package:UNGolds/network/call/deliveryaddresscall.dart';
import 'package:UNGolds/network/call/emi_invoice_call.dart';
import 'package:UNGolds/network/call/emi_pay_wallet_call.dart';
import 'package:UNGolds/network/call/emi_receipt_call.dart';
import 'package:UNGolds/network/call/emiwalletpaymentcall.dart';
import 'package:UNGolds/network/call/enachresponsecall.dart';
import 'package:UNGolds/network/call/enachurlcall.dart';
import 'package:UNGolds/network/call/forgot_password_call.dart';
import 'package:UNGolds/network/call/get_city_call.dart';
import 'package:UNGolds/network/call/get_profile_call.dart';
import 'package:UNGolds/network/call/login_call.dart';
import 'package:UNGolds/network/call/my_order_list_call.dart';
import 'package:UNGolds/network/call/myorderinvoicecall.dart';
import 'package:UNGolds/network/call/otp_verify_call.dart';
import 'package:UNGolds/network/call/payemiunwalletcall.dart';
import 'package:UNGolds/network/call/payemiusingccevenucall.dart';
import 'package:UNGolds/network/call/phonepayintiateurlcall.dart';
import 'package:UNGolds/network/call/place_emi_order.dart';
import 'package:UNGolds/network/call/product_list_call.dart';
import 'package:UNGolds/network/call/purhase_history_call.dart';
import 'package:UNGolds/network/call/repayment_schedule_call.dart';
import 'package:UNGolds/network/call/resend_otp_call.dart';
import 'package:UNGolds/network/call/send_request_call.dart';
import 'package:UNGolds/network/call/sign_up_call.dart';
import 'package:UNGolds/network/call/submit_bank_details.dart';
import 'package:UNGolds/network/call/submit_kyc_call.dart';
import 'package:UNGolds/network/call/track_order_call.dart';
import 'package:UNGolds/network/call/trackemiordercall.dart';
import 'package:UNGolds/network/call/transferamountcall.dart';
import 'package:UNGolds/network/call/unique_email_call.dart';
import 'package:UNGolds/network/call/unique_mobile_call.dart';
import 'package:UNGolds/network/call/unique_referal_call.dart';
import 'package:UNGolds/network/call/update_onward_profile_call.dart';
import 'package:UNGolds/network/call/update_profile_call.dart';
import 'package:UNGolds/network/call/updateccavenuecall.dart';
import 'package:UNGolds/network/call/updateccavenuepayemicall.dart';
import 'package:UNGolds/network/call/updatecustomeridcall.dart';
import 'package:UNGolds/network/call/updaterepaymentstatus.dart';
import 'package:UNGolds/network/call/updatetheemipaystatuscall.dart';
import 'package:UNGolds/network/call/viewemiordercall.dart';
import 'package:UNGolds/network/call/walletdebithistorycall.dart';
import 'package:UNGolds/network/response/eNachresponse.dart';
import 'package:UNGolds/network/response/getenachtokencall.dart';
import 'package:UNGolds/network/response/phonepayurlresponse.dart';
import 'package:UNGolds/wallet/walletdebithistory.dart';
import 'package:flutter/cupertino.dart';

import 'call/getenachurlcall.dart';

class CreateJson {
  String createjsonforsignup(
      String firstname,
      String lastname,
      String mail,
      String mobilenumber,
      String password,
      String referalcode,
      String accept,
      BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Signupcall signupcall = Signupcall(
          firstName: firstname,
          lastName: lastname,
          email: mail,
          mobile: mobilenumber,
          password: password,
          referralCode: referalcode,
          accept: accept);
      var result = Signupcall.fromJson(signupcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforsignup", "CreteJson", context);
      return "";
    }
  }

  String createjsonforuniquemobilenumber(
      String mobilenumber, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Uniquemobilecall uniquemobilecall =
          Uniquemobilecall(mobile: mobilenumber);
      var result = Uniquemobilecall.fromJson(uniquemobilecall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(e.toString(), "createjsonforuniquemobilenumber",
          "CreteJson", context);
      return "";
    }
  }

  String createjsonforuniqueemail(String mail, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Uniqueemailcall uniqueemailcall = Uniqueemailcall(email: mail);
      var result = Uniqueemailcall.fromJson(uniqueemailcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforuniqueemail", "CreteJson", context);
      return "";
    }
  }

  String createjsonforuniquereferealcode(String referal, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Uniquereferalcall uniquereferalcall =
          Uniquereferalcall(referralCode: referal);
      var result = Uniquereferalcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(e.toString(), "createjsonforuniquereferealcode",
          "CreteJson", context);
      return "";
    }
  }

  String createjsonforotpverify(int otp, int otp1, int otp2, int otp3, int otp4,
      int table_verification, String mobilenumber, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Otpverifycall uniquereferalcall = Otpverifycall(
          otp: otp,
          otp1: otp1,
          otp2: otp2,
          otp3: otp3,
          otp4: otp4,
          tblUnverifiedId: table_verification,
          mobile: mobilenumber);
      var result = Otpverifycall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforotpverify", "CreteJson", context);
      return "";
    }
  }

  String createjsonforlogin(
      String mobilenumber, String password, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Logincall uniquereferalcall =
          Logincall(mobile: mobilenumber, password: password);
      var result = Logincall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforlogin", "CreteJson", context);
      return "";
    }
  }

  String createjsonforforgotpassword(
      String mobilenumber, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Forgotpasswordcall uniquereferalcall =
          Forgotpasswordcall(mobile: mobilenumber);
      var result = Forgotpasswordcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforforgotpassword", "CreteJson", context);
      return "";
    }
  }

  String createjsonforwithID(String id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Getprofilecall uniquereferalcall = Getprofilecall(id: id);
      var result = Getprofilecall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforwithID", "CreteJson", context);
      return "";
    }
  }

  String createjsonforCity(String stateid, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Getcitycall uniquereferalcall = Getcitycall(stateId: stateid);
      var result = Getcitycall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforCity", "CreteJson", context);
      return "";
    }
  }

  String createjsonforproductlist(int offset, BuildContext context, int limit,
      String producttype, String searchtext) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Productlistcall uniquereferalcall = Productlistcall(
          offset: offset,
          limit: limit,
          producttype: producttype,
          search_text: searchtext);
      var result = Productlistcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforproductlist", "CreteJson", context);
      return "";
    }
  }

  String createjsonforgoldonemi(
      BuildContext context,
      String gramqty,
      double pergramrate,
      double bookingAmount,
      int emimonth,
      double emiAmount,
      double actualprocessingfees,
      String processingfeesgst,
      double totalprocessingfees,
      String makingcharge,
      String makinggst,
      String membersheeptype,
      String membersheepstatus,
      String membership_fee) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Buygoldonemicall uniquereferalcall = Buygoldonemicall(
          id: AppUtility.ID,
          productPricePerGram: pergramrate.toString(),
          purchaseGram: gramqty,
          actualBookingAmt: bookingAmount.toString(),
          emiAmount: emiAmount.toString(),
          emiMonth: emimonth.toString(),
          proceessAmt: actualprocessingfees.toString(),
          proceessGst: processingfeesgst.toString(),
          processTotalAmt: totalprocessingfees.toString(),
          makingAmt: makingcharge.toString(),
          makingGst: makinggst.toString(),
          membershipType: membersheeptype.toString(),
          membershipStatus: membersheepstatus.toString(),
          membership_fee: membership_fee.toString());
      var result = Buygoldonemicall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforgoldcheckout", "CreteJson", context);
      return "";
    }
  }

  String cretejsonforupdateonwardprofile(
      String id,
      String fname,
      String lname,
      String county,
      String city_id,
      String state_id,
      String imag,
      String pincode,
      String address,
      String taluka,
      String old_image,
      BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Updateonwardprofilecall call = Updateonwardprofilecall(
          id: id,
          firstName: fname,
          lastName: lname,
          country: county,
          state: state_id,
          district: city_id,
          taluka: taluka,
          pincode: pincode,
          image: imag,
          address: address,
          oldImage: old_image);
      var result = Updateonwardprofilecall.fromJson(call.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforproductlist", "CreteJson", context);
      return "";
    }
  }

  String cretejsonforupdateprofile(
      String id,
      String fname,
      String lname,
      String county,
      String city_id,
      String state_id,
      String imag,
      String pincode,
      String address,
      String taluka,
      String old_image,
      BuildContext context,
      String birthdate,
      String anniversarydate,
      String aadharno,
      String panno,
      String gstno) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Updateprofilecall call = Updateprofilecall(
          id: id,
          firstName: fname,
          lastName: lname,
          country: county,
          state: state_id,
          district: city_id,
          taluka: taluka,
          pincode: pincode,
          image: imag,
          address: address,
          oldImage: old_image,
          birthDate: birthdate,
          annivarsary: anniversarydate,
          aadharNo: aadharno,
          panNo: panno,
          gst_no: gstno);
      var result = Updateprofilecall.fromJson(call.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforproductlist", "CreteJson", context);
      return "";
    }
  }

  String createjsonforsubmitkycform(
      BuildContext context,
      String id,
      String aadharfrontphoto,
      String aadharbackphoto,
      String panphoto,
      String passportphot,
      String kycaggrement) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Submitkyccall uniquereferalcall = Submitkyccall(
          id: id,
          kycAddharFront: aadharfrontphoto,
          kycAddharBack: aadharbackphoto,
          kycPan: panphoto,
          kycPassport: passportphot,
          acceptAgreement: kycaggrement);
      var result = Submitkyccall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforsubmitkycform", "CreteJson", context);
      return "";
    }
  }

  String createjsonforsubmitbankdetails(
      BuildContext context,
      String id,
      String bankName,
      String accountnumber,
      String accounttype,
      String branchname,
      String ifsccode,
      String micrnumber,
      String image,
      String oldimage,
      String upiid) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Submitbankdetailscall uniquereferalcall = Submitbankdetailscall(
          id: id,
          bankName: bankName,
          accountNumber: accountnumber,
          accountType: accounttype,
          branchName: branchname,
          ifscCode: ifsccode,
          micrNumber: micrnumber,
          image: image,
          oldImage: oldimage,
          upiId: upiid);
      var result = Submitbankdetailscall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforsubmitbankdetails", "CreteJson", context);
      return "";
    }
  }

  String createjsonforchangepassword(
      BuildContext context, String id, String password) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Changepasswordcall changepasswordcall =
          Changepasswordcall(id: id, password: password);
      var result = Changepasswordcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforchangepassword", "CreteJson", context);
      return "";
    }
  }

  String createjsonforbankoperation(
      BuildContext context, String id, String tableid) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Bankaccountoperationcall changepasswordcall =
          Bankaccountoperationcall(id: id, tblBankAccountId: tableid);
      var result =
          Bankaccountoperationcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforbankoperation", "CreteJson", context);
      return "";
    }
  }

  String createjsonforplaceorder(String id, String orderid, String addressid,
      BuildContext context, double finaltotal, double firstemi) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Placeorderemicall changepasswordcall = Placeorderemicall(
        id: id,
        tblEmiOrderId: orderid,
        addressId: addressid,
        totalAmount: finaltotal.toString(),
        firstEmiPay: firstemi.toString(),
      );
      var result = Placeorderemicall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforplaceorder", "CreteJson", context);
      return "";
    }
  }

  String createjsonformyorderwithemi(
      String id, String ordertype, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Myorderlistcall changepasswordcall =
          Myorderlistcall(id: id, orderType: ordertype);
      var result = Myorderlistcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonformyorderwithemi", "CreteJson", context);
      return "";
    }
  }

  String createjsonforrepaymentschedule(
      String id, String orderId, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Repaymentschedulecall changepasswordcall =
          Repaymentschedulecall(id: id, tblEmiInnvoiceId: orderId);
      var result = Repaymentschedulecall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforrepaymentschedule", "CreteJson", context);
      return "";
    }
  }

  String createjsonforemiinvoice(
      String id, String orderId, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Emiinvoicecall changepasswordcall =
          Emiinvoicecall(id: id, orderId: orderId);
      var result = Emiinvoicecall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforemiinvoice", "CreteJson", context);
      return "";
    }
  }

  String craetejosnforemireceipt(String table_id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Emireceiptcall changepasswordcall =
          Emireceiptcall(tblRepaymentId: table_id);
      var result = Emireceiptcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "craetejosnforemireceipt", "CreteJson", context);
      return "";
    }
  }

  String craetejosnforbuygoldcheckout(
      String id, String productid, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Buygoldcheckoutcall changepasswordcall =
          Buygoldcheckoutcall(id: id, productId: productid);
      var result = Buygoldcheckoutcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "craetejosnforbuygoldcheckout", "CreteJson", context);
      return "";
    }
  }

  String craetejosnforbuygoldplaceorder(String id, String productid,
      BuildContext context, String cardid, String addressid) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Buygoldplaceordercall changepasswordcall = Buygoldplaceordercall(
          id: id,
          productId: productid,
          tblAddToCartId: cardid,
          addressId: addressid);
      var result = Buygoldplaceordercall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "craetejosnforbuygoldplaceorder", "CreteJson", context);
      return "";
    }
  }

  String createjsonforsendrequest(
      String id, String amount, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Sendrequestcall uniquereferalcall =
          Sendrequestcall(id: id, withdrawRequest: amount);
      var result = Sendrequestcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforsendrequest", "CreteJson", context);
      return "";
    }
  }

  String craetejsonforemipayfromwallet(
      String id,
      String isdeductfromwallet,
      String tableId,
      BuildContext context,
      String ispaylateemichage,
      double amount) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Emipaymentwalletcall uniquereferalcall = Emipaymentwalletcall(
          id: id,
          tblRepaymentId: tableId,
          allowedToPayEmiCharge: ispaylateemichage,
          total_payable_amount: amount.toString(),
          isdeductfromwallet: isdeductfromwallet);
      var result = Emipaymentwalletcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforsendrequest", "CreteJson", context);
      return "";
    }
  }

  String createjsonforpurchasehistory(String customerid, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Purchasehistorycall uniquereferalcall =
          Purchasehistorycall(customerId: customerid);
      var result = Purchasehistorycall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforpurchasehistory", "CreteJson", context);
      return "";
    }
  }

  String createjsonforresendotp(int otp, String mobilenumber,
      BuildContext context, int tableverificationid) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Resendotpcall uniquereferalcall = Resendotpcall(
          mobile: mobilenumber,
          otp: otp.toString(),
          tbl_unverified_id: tableverificationid);
      var result = Resendotpcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforpurchasehistory", "CreteJson", context);
      return "";
    }
  }

  String createjsonformyorderinvoice(String id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Myorderinvoicecall changepasswordcall =
          Myorderinvoicecall(tblInvoiceId: id);
      var result = Myorderinvoicecall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforemiinvoice", "CreteJson", context);
      return "";
    }
  }

  String createjsonfortrackorder(
      String orderid, String status, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Trackordercall changepasswordcall =
          Trackordercall(tblOrderId: orderid, status: status);
      var result = Trackordercall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfortrackorder", "CreteJson", context);
      return "";
    }
  }

  String createjsonforupdatetheemipaystatuscall(String transactionid,
      String providerReferenceId, BuildContext context, String order_id) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Updatetheemipaystatuscall changepasswordcall = Updatetheemipaystatuscall(
          transactionId: transactionid,
          providerReferenceId: providerReferenceId,
          orderid: order_id);
      var result =
          Updatetheemipaystatuscall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(e.toString(),
          "createjsonforupdatetheemipaystatuscall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforupdatetheemirepaymentstatuscall(
      String transactionid,
      String providerReferenceId,
      BuildContext context,
      String order_id,
      int allowed) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Updatetheemirepaystatuscall changepasswordcall =
          Updatetheemirepaystatuscall(
              transactionId: transactionid,
              providerReferenceId: providerReferenceId,
              orderid: order_id,
              allowed_to_pay_charge_or_deduct: allowed);
      var result =
          Updatetheemirepaystatuscall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(e.toString(),
          "createjsonforupdatetheemipaystatuscall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforccavenueapicall(String order_id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Ccavenueapicall changepasswordcall =
          Ccavenueapicall(orderId: int.parse(order_id));
      var result = Ccavenueapicall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforccavenueapicall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforudateccavenuecall(
      String orderid,
      String trackingId,
      String bankref,
      String paymenttype,
      String paymentstatus,
      BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Updatetheccavnuecall changepasswordcall = Updatetheccavnuecall(
          orderId: orderid,
          trackingId: trackingId,
          bankRefNo: bankref,
          paymentType: paymenttype,
          paymentStatus: paymentstatus);
      var result = Updatetheccavnuecall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforudateccavenuecall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforbuygoldcall(
      String order_id, String id, String toatalpayable, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Buygoldccavenuecall changepasswordcall = Buygoldccavenuecall(
        orderId: order_id,
        id: id,
        totalPayableAmount: toatalpayable,
      );
      var result = Buygoldccavenuecall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(e.toString(),
          "createjsonforpayemiccavenueapicall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforpayemiccavenueapicall(
      String order_id,
      String id,
      String toatalpayable,
      int allowed_to_pay_charge_or_deduct,
      BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Payemiusingccavenuecall changepasswordcall = Payemiusingccavenuecall(
          orderId: order_id,
          id: id,
          totalPayableAmount: toatalpayable,
          allowed_to_pay_charge_or_deduct: allowed_to_pay_charge_or_deduct);
      var result =
          Payemiusingccavenuecall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(e.toString(),
          "createjsonforpayemiccavenueapicall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforPayEMIudateccavenuecall(
      String orderid,
      String trackingId,
      String bankref,
      String orderstatus,
      String paymentstatus,
      String allwoedtopaychargeordeduct,
      BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      UpdateccavenuePayEmIcall changepasswordcall = UpdateccavenuePayEmIcall(
          orderId: orderid,
          trackingId: trackingId,
          bankRefNo: bankref,
          orderStatus: orderstatus,
          allowedToPayChargeOrDeduct: allwoedtopaychargeordeduct,
          paymentStatus: paymentstatus);
      var result =
          UpdateccavenuePayEmIcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforudateccavenuecall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforenachurlcall(
      String orderid, String emiorderid, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Enachurlcall changepasswordcall =
          Enachurlcall(orderId: orderid, emiOrderId: emiorderid);
      var result = Enachurlcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachurlcall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforenachdata(
      List<EnachdataDatum> data, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Callforenachurl changepasswordcall = Callforenachurl(
          consumerId: data[0].consumerId,
          customerEmail: data[0].customerEmail,
          customerMobile: "8999166472",
          emiAmount: data[0].emiAmount,
          emiEndDate: data[0].emiEndDate,
          emiMonth: data[0].emiMonth,
          emiStartDate: data[0].emiStartDate,
          enachFrom: data[0].enachFrom,
          orderId: data[0].orderId,
          token: data[0].token,
          txnId: data[0].txnId);
      var result = Callforenachurl.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachurlcall", "CreteJson", context);
      return "";
    }
  }

  String createjsonforemitrackorder(
      String orderid, String status, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Trackemiordercall changepasswordcall =
          Trackemiordercall(orderId: orderid, orderStatus: status);
      var result = Trackemiordercall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfortrackorder", "CreteJson", context);
      return "";
    }
  }

  String createjsonforviewemiorder(String orderid, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Viewemiordercall changepasswordcall = Viewemiordercall(orderId: orderid);
      var result = Viewemiordercall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfortrackorder", "CreteJson", context);
      return "";
    }
  }

  String createjsonforinitiateurlphonepay(
      List<PhonepayurlDatum> data, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      PhonepayurlDatum changepasswordcall = PhonepayurlDatum(
          merchantId: data[0].merchantId,
          merchantTransactionId: data[0].merchantTransactionId,
          merchantUserId: data[0].merchantUserId,
          amount: data[0].amount,
          redirectUrl: data[0].redirectUrl,
          redirectMode: data[0].redirectMode,
          callbackUrl: data[0].callbackUrl,
          merchantOrderId: data[0].merchantOrderId,
          mobileNumber: data[0].mobileNumber,
          message: data[0].message,
          email: data[0].email,
          shortName: data[0].shortName,
          paymentInstrument: data[0].paymentInstrument);
      var result = PhonepayurlDatum.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachurlcall", "CreteJson", context);
      return "";
    }
  }

  //date 06/07/2024
  String createjsonforgetencahurlcall(String orderid, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Getenachurlcall changepasswordcall = Getenachurlcall(orderId: orderid);
      var result = Getenachurlcall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachurlcall", "CreteJson", context);
      return "";
    }
  }

  String cretajsonforaddnomineedetails(
      BuildContext context,
      String customerid,
      String name,
      String contact,
      String age,
      String relation,
      String address) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Addnomineedetailscall changepasswordcall = Addnomineedetailscall(
          customerId: customerid,
          nomineeName: name,
          nomineeContact: contact,
          nomineeAge: age,
          relationWithCustomer: relation,
          nomineeAddress: address);
      var result = Addnomineedetailscall.fromJson(changepasswordcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachurlcall", "CreteJson", context);
      return "";
    }
  }

  String createjsonfortransferamount(
      String id, String amount, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Transferamountcall uniquereferalcall =
          Transferamountcall(customerId: id, transferAmount: amount);
      var result = Transferamountcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfortransferamount", "CreteJson", context);
      return "";
    }
  }

  String createjsonforgetwalletdebithistory(String id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Walletdebithstorycall uniquereferalcall =
          Walletdebithstorycall(customerId: id);
      var result = Walletdebithstorycall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfortransferamount", "CreteJson", context);
      return "";
    }
  }

  String createjsonforbuygoldwallet(String id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Buygoldwalletcall uniquereferalcall = Buygoldwalletcall(orderId: id);
      var result = Buygoldwalletcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforbuygoldwallet", "CreteJson", context);
      return "";
    }
  }

  String createjsonforemiwallet(
      String id, String isdeduct, String amount, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Emiwalletpaymentcall uniquereferalcall = Emiwalletpaymentcall(
          orderId: id, isDeduct: isdeduct, payableAmount: amount);
      var result = Emiwalletpaymentcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforbuygoldwallet", "CreteJson", context);
      return "";
    }
  }

  String createjsonfordelete(String id, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Deleteaccountcall uniquereferalcall = Deleteaccountcall(userId: id);
      var result = Deleteaccountcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfordelete", "CreteJson", context);
      return "";
    }
  }

  String cretajsonforadddeliveryaddress(
      BuildContext context,
      String id,
      String firstname,
      String lastname,
      String mobile,
      String country_id,
      String state_id,
      String city_id,
      String taluka,
      String pincode,
      String address) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Deliveryaddresscall uniquereferalcall = Deliveryaddresscall(
          userId: id,
          full_name: firstname,
          country: country_id,
          state: state_id,
          city: city_id,
          taluka: taluka,
          pincode: pincode,
          address: address,
          mobile: mobile);
      var result = Deliveryaddresscall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonfordelete", "CreteJson", context);
      return "";
    }
  }

  String createjsonupdatecustomerid(
      String id, String cardId, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Updatecustomeridcall uniquereferalcall =
          Updatecustomeridcall(id: id, tblAddToCartId: cardId);
      var result = Updatecustomeridcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonupdatecustomerid", "CreteJson", context);
      return "";
    }
  }

  String createjsonforenachtoken(
      String id, String orderId, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Getenachtoakencall uniquereferalcall =
          Getenachtoakencall(customerId: id, orderId: orderId);
      var result = Getenachtoakencall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachtoken", "CreteJson", context);
      return "";
    }
  }

  String createjsonforenachresponse(
      String enachresponse, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Enachresponsecall uniquereferalcall =
          Enachresponsecall(enachResponse: enachresponse);
      var result = Enachresponsecall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforenachtoken", "CreteJson", context);
      return "";
    }
  }

  String createjsonforemipayunwallet(
      String id, int is_allowed_deduct, BuildContext context) {
    try {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      Payemiunwalletcall uniquereferalcall = Payemiunwalletcall(
          orderId: id, isEmiAndLatefeeDeduct: is_allowed_deduct);
      var result = Payemiunwalletcall.fromJson(uniquereferalcall.toJson());
      String str = encoder.convert(result);
      return str;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "createjsonforemipayunwallet", "CreteJson", context);
      return "";
    }
  }
}
