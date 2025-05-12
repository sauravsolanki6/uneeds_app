import 'dart:math';

import 'package:UNGolds/network/call/buygoldwalletstatus.dart';
import 'package:UNGolds/network/call/get_profile_call.dart';
import 'package:UNGolds/network/response/addnominee_response.dart';
import 'package:UNGolds/network/response/all_amount_response.dart';
import 'package:UNGolds/network/response/bank_details_response.dart';
import 'package:UNGolds/network/response/bank_operation_response.dart';
import 'package:UNGolds/network/response/buy_gold_checkout_response.dart';
import 'package:UNGolds/network/response/buy_gold_on_emi_response.dart';
import 'package:UNGolds/network/response/buy_gold_place_order_response.dart';
import 'package:UNGolds/network/response/buygoldemiresponse.dart';
import 'package:UNGolds/network/response/buygoldpaymentuneedswalletresponse.dart';
import 'package:UNGolds/network/response/buygoldwalletresponse.dart';
import 'package:UNGolds/network/response/ccavenueapiresponse.dart';
import 'package:UNGolds/network/response/ccavenueupdatePayEMIresponse.dart';
import 'package:UNGolds/network/response/ccavenueupdateresponse.dart';
import 'package:UNGolds/network/response/change_password_response.dart';
import 'package:UNGolds/network/response/deleteaccoutresponse.dart';
import 'package:UNGolds/network/response/deliveryaddressresponse.dart';
import 'package:UNGolds/network/response/eNachresponse.dart';
import 'package:UNGolds/network/response/eNachresponseresponse.dart';
import 'package:UNGolds/network/response/earn_history_response.dart';
import 'package:UNGolds/network/response/emi_charge_history_response.dart';
import 'package:UNGolds/network/response/emi_charge_paid_history_response.dart';
import 'package:UNGolds/network/response/emi_invoice_response.dart';
import 'package:UNGolds/network/response/emi_receipt_response.dart';
import 'package:UNGolds/network/response/emipaymentwalletresponse.dart';
import 'package:UNGolds/network/response/emiwalletpaymentresponse.dart';
import 'package:UNGolds/network/response/forgot_password_response.dart';
import 'package:UNGolds/network/response/get_address_response.dart';
import 'package:UNGolds/network/response/get_city_response.dart';
import 'package:UNGolds/network/response/get_fees_response.dart';
import 'package:UNGolds/network/response/get_kyc_response.dart';
import 'package:UNGolds/network/response/get_kyc_status_response.dart';
import 'package:UNGolds/network/response/get_profile_response.dart';
import 'package:UNGolds/network/response/get_state_response.dart';
import 'package:UNGolds/network/response/getenachtokenresponse.dart';
import 'package:UNGolds/network/response/getwayactiveresponse.dart';
import 'package:UNGolds/network/response/live_rate_response.dart';
import 'package:UNGolds/network/response/login_response.dart';
import 'package:UNGolds/network/response/my_order_invoice_response.dart';
import 'package:UNGolds/network/response/my_order_list_response.dart';
import 'package:UNGolds/network/response/my_order_list_without_emi.dart';
import 'package:UNGolds/network/response/order_profit_response.dart';
import 'package:UNGolds/network/response/otp_verify_response.dart';
import 'package:UNGolds/network/response/phonepayurlresponse.dart';
import 'package:UNGolds/network/response/place_order_emi_response.dart';
import 'package:UNGolds/network/response/product_list_response.dart';
import 'package:UNGolds/network/response/purchase_history_response.dart';
import 'package:UNGolds/network/response/referal_customer_list.dart';
import 'package:UNGolds/network/response/referandearn_response.dart';
import 'package:UNGolds/network/response/repayment_schedule_response.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:UNGolds/network/response/sign_up_response.dart';
import 'package:UNGolds/network/response/submit_bank_response.dart';
import 'package:UNGolds/network/response/submit_kyc_response.dart';
import 'package:UNGolds/network/response/tds_history_response.dart';
import 'package:UNGolds/network/response/trackemiorderesponse.dart';
import 'package:UNGolds/network/response/trackorderresponse.dart';
import 'package:UNGolds/network/response/transferamountresponse.dart';
import 'package:UNGolds/network/response/unique_field_response.dart';
import 'package:UNGolds/network/response/updateCCAvenueProductResponse.dart';
import 'package:UNGolds/network/response/update_onward_profile_response.dart';
import 'package:UNGolds/network/response/update_profile_response.dart';
import 'package:UNGolds/network/response/updatecustomeridresponse.dart';
import 'package:UNGolds/network/response/updatetheemipaystatusresponse.dart';
import 'package:UNGolds/network/response/viewemiorderresponse.dart';
import 'package:UNGolds/network/response/walletamountresponse.dart';
import 'package:UNGolds/network/response/walletcreadithistory.dart';
import 'package:UNGolds/network/response/walletdebithistoryresponse.dart';
import 'package:UNGolds/network/response/withdraw_history_response.dart';
import 'package:UNGolds/screens/bankdetailpage/add_bank_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:developer' as dev;
import '../constant/printmessage.dart';

// 202cb962ac59075b964b07152d234b70
class Networkcall {
  postMethod1(
      int requestCode, String url, String body, BuildContext context) async {
    var response = await post(Uri.parse(url), body: body);
    var data = response.body;
    try {
      if (response.statusCode == 200) {
        switch (requestCode) {
          case 52:
            return data;
            break;
          case 56:
            return data;
        }
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Network Response', 'Network Response', context);
    }
  }

  Future<List<Object?>?> postMethod(
      int requestCode, String url, String body, BuildContext context) async {
    var response = await post(Uri.parse(url), body: body);
    var data = response.body;
    dev.log(url);
    dev.log(body);
    try {
      if (response.statusCode == 200) {
        String str = "[" + data + "]";
        dev.log(str);
        switch (requestCode) {
          case 1:
            final signupresponse = signupresponseFromJson(str);
            return signupresponse;
          case 2:
            final uniquefiled = uniquefieldresponseFromJson(str);
            return uniquefiled;
          case 3:
            final otp = otpverifyresponseFromJson(str);
            return otp;
          case 4:
            final login = loginresponseFromJson(str);
            return login;
          case 5:
            final forgotpassword = forgotpasswordresponseFromJson(str);
            return forgotpassword;
          case 6:
            final changepassword = changepasswordresponseFromJson(str);
            return changepassword;
            break;
          case 8:
            final getprofile = getprofileresponseFromJson(str);
            return getprofile;
          case 10:
            final getcity = getcityresponseFromJson(str);
            return getcity;
          case 11:
            final getkyc = getkycstatusresponseFromJson(str);
            return getkyc;
          case 12:
            final getfees = getfeesresponseFromJson(str);
            return getfees;
          case 13:
            final productlist = productlistresponseFromJson(str);
            return productlist;
          case 14:
            final buygoldonemi = buygoldonemiresponseFromJson(str);
            return buygoldonemi;
            break;
          case 15:
            final updateonwardprofile =
                updateonwardprofileresponseFromJson(str);
            return updateonwardprofile;
          case 16:
            final updateprofile = updateprofileresponseFromJson(str);
            return updateprofile;
          case 17:
            final submitkyc = submitkycresponseFromJson(str);
            return submitkyc;
          case 18:
            final submitbankresponse = submitbankdetailsresponseFromJson(str);
            return submitbankresponse;
          case 19:
            final bankdetail = bankdetailresponseFromJson(str);
            return bankdetail;
          case 20:
            final operationresponse = bankaccountoperationresponseFromJson(str);
            return operationresponse;
          case 21:
            final getkyc = getkycresponseFromJson(str);
            return getkyc;
          case 22:
            final getaddressresponse = getaddressresponseFromJson(str);
            return getaddressresponse;
          case 23:
            final placeorder = placeorderemiresponseFromJson(str);
            return placeorder;
          case 24:
            final my_order_with_emi = myorderlistresponseFromJson(str);
            return my_order_with_emi;
          case 25:
            final repayment = repaymentscheduleresponseFromJson(str);
            return repayment;
          case 26:
            final refer = referalandearnresponseFromJson(str);
            return refer;
          case 27:
            final earnhistory = earnhistoryresponseFromJson(str);
            return earnhistory;
          case 28:
            final withdraw = withdrawhistoryresponseFromJson(str);
            return withdraw;
            break;
          case 29:
            final emiinvoice = emiinvoiceresponseFromJson(str);
            return emiinvoice;
          case 30:
            final allamount = allamountresponseFromJson(str);
            return allamount;

          case 31:
            final emireceipt = emireceiptresponseFromJson(str);
            return emireceipt;
          case 32:
            final paidemihistory = emichargepaidhistoryresponseFromJson(str);
            return paidemihistory;
          case 33:
            final emihistory = emichargehistoryresponseFromJson(str);
            return emihistory;
          case 34:
            final buygoldcheckout = buygoldcheckoutresponseFromJson(str);
            return buygoldcheckout;
          case 35:
            final placeorder = buygoldplaceorderresponseFromJson(str);
            return placeorder;
          case 36:
            final sendreq = sendrequestresponseFromJson(str);
            return sendreq;
          case 37:
            final emipayment = emipaymentwalletresponseFromJson(str);
            return emipayment;
          case 38:
            final tdshistory = tdshistoryresponseFromJson(str);
            return tdshistory;
          case 39:
            final referallist = referalcustomerlistresponseFromJson(str);
            return referallist;
          case 40:
            final purchasehisto = purchasehistoryresponseFromJson(str);
            return purchasehisto;
          case 41:
            final profit = orderprofitresponseFromJson(str);
            return profit;
          case 42:
            final orderlist = myorderwithoutemiresponseFromJson(str);

            return orderlist;
          case 43:
            final orderinvoice = myorderinvoiceresponseFromJson(str);
            return orderinvoice;
          case 44:
            final track = trackorderresponseFromJson(str);
            return track;
          case 45:
            final updatetheemistatus =
                updatetheemipaystatusresponseFromJson(str);
            return updatetheemistatus;
          case 46:
            break;
          case 47:
            final ccavenue = ccavenueapiresponseFromJson(str);
            return ccavenue;

          case 48:
            final ccavnueresponse = updatetheccavnueresponseFromJson(str);
            return ccavnueresponse;
          case 49:
            final ccavenupayemi = updateccavenuePayEmIresponseFromJson(str);
            return ccavenupayemi;
          case 50:
            final ccavnuproduct = updateccavenueProductresponseFromJson(str);
            return ccavnuproduct;
            break;
          case 51:
            final encahurl = enachurlresponseFromJson(str);

            return encahurl;
          case 53:
            final viewemiorder = viewemiorderresponseFromJson(str);
            return viewemiorder;
          case 54:
            final trackemiorder = trackemiorderresponseFromJson(str);
            return trackemiorder;
            break;
          case 55: //Not Use
            final phonepayurl = phonepayurlresponseFromJson(str);
            return phonepayurl;
            break;
          case 56: //Not Use

            break;
          case 57:
            final nomineeresponse = addnomineedetailsresponseFromJson(str);
            return nomineeresponse;
          case 58:
            final transfer = transferamountresponseFromJson(str);
            return transfer;
            break;
          case 59:
            final debithistory = walletdebithstoryresponseFromJson(str);
            return debithistory;
          case 60:
            final walletamount = walletamountesponseFromJson(str);
            return walletamount;
          case 61:
            final creadithistory = walletcreadithstoryresponseFromJson(str);
            return creadithistory;
          case 62:
            final buygoldwallet = buygoldwalletresponseFromJson(str);
            return buygoldwallet;
          case 63:
            final buygoldwalletstatus =
                buygoldwalletstatusresponseFromJson(str);
            return buygoldwalletstatus;
          case 64:
            final buygoldemiresponse =
                buygoldemiwalletstatusresponseFromJson(str);
            return buygoldemiresponse;
          case 65:
            final emiwalletpayment = emiwalletpaymentresponseFromJson(str);
            return emiwalletpayment;
          case 67:
            final deleteaccount = deleteaccountresponseFromJson(str);
            return deleteaccount;
          case 68:
            final deliveryadd = deliveryaddressresponseFromJson(str);
            return deliveryadd;
          case 69:
            final customeridresponse = updatecustomeridresponseFromJson(str);
            return customeridresponse;
          case 70:
            final getenach = getenachtoakenresponseFromJson(str);
            return getenach;
          case 71:
            final enach = enachresponseresponseFromJson(str);
            return enach;
          case 72:
            final uneedwallet = buygoldpaymentuneedswalletresponseFromJson(str);
            return uneedwallet;
        }
        if (response.statusCode == 400) {
          PrintMessage.printmessage('Check internet connection',
              'Network Response', 'Network Response', context);
          return null;
        }
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Network Response', 'Network Response', context);
      return null;
    }
  }

  Future<List<Object?>?> getMethod(
      int requestCode, String url, BuildContext context) async {
    var response = await get(Uri.parse(url));
    var data = response.body;
    try {
      if (response.statusCode == 200) {
        String str = "[" + data + "]";
        switch (requestCode) {
          case 7:
            final liverate = liverateresponseFromJson(str);
            return liverate;
          case 9:
            final getstate = getstateresponseFromJson(str);
            return getstate;
          case 66:
            final getwaystatus = getwayactiveresponseFromJson(str);
            return getwaystatus;
        }
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Network Response', 'Network Response', context);
    }
  }
}
