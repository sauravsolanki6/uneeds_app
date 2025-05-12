import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/network/response/referandearn_response.dart';
import 'package:UNGolds/screens/referralandearn/earn_history.dart';
import 'package:UNGolds/screens/referralandearn/send_withdraw_request.dart';
import 'package:UNGolds/screens/referralandearn/transfer_earn_amount.dart';
import 'package:UNGolds/screens/referralandearn/withdraw_history.dart';
import 'package:UNGolds/screens/sign_up/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';

class ReferralAndEarn extends StatefulWidget {
  State createState() => ReferralAndEarnState();
}

class ReferralAndEarnState extends State<ReferralAndEarn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Networkcallforreferandearn();
  }

  createlink() {}

  double earnamount = 0.0, deductamount = 0.0, balanceamount = 0.0;
  String MobileNumber = "",
      Name = "",
      link = "",
      tdsPercentage = "",
      kycstatus = "";
  int bank_details = 0, isrequestpending = 0;

  Future<void> Networkcallforreferandearn() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.referal_earn,
          NetworkUtility.referal_earn_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Referalandearnresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            isrequestpending = response[0].requestPending!;
            kycstatus = response[0].kycStatus!;
            tdsPercentage = response[0].tdsDeductionPercentage!;
            bank_details = response[0].bankDetailsAdded!;
            earnamount = response[0].earnAmount!;
            deductamount = response[0].deductAmount!;
            balanceamount = earnamount - deductamount;
            Name = response[0].data![0].firstName!.replaceAll(" ", "") +
                "_" +
                response[0].data![0].lastName!;
            MobileNumber = response[0].data![0].mobile!;
            final appId =
                Platform.isAndroid ? 'com.quick.ungolds' : 'YOUR_IOS_APP_ID';
            final url = Uri.parse(
              Platform.isAndroid
                  ? "market://details?id=$appId"
                  : "https://apps.apple.com/app/id$appId",
            );
            link =
                "https://play.google.com/store/apps/details?id=com.quick.ungolds&referrer=utm_source=test&name=${Name}&mobile=${MobileNumber}";
            //"https://play.google.com/store/apps/details?id=com.quick.ungolds&name=${Name}&mobile=${MobileNumber}";
            //  link = '${url}?name=${Name}&mobile=${MobileNumber} ';
            setState(() {});
            break;
          case "false":
            SnackBarDesign(
                'No data found!', context, AppColor.errorcolor, Colors.white);

            break;
        }
      } else {
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);

        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforreferandearn',
          "Refer And Earn ", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Referral And Earn'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                AppColor.intoColor.withOpacity(0.4),
                AppColor.theamecolor.withOpacity(0.4)
              ], // Adjust the colors as needed
            ),
          ),
          child: BackdropFilter(
            filter: const ColorFilter.mode(Colors.white, BlendMode.softLight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column(
                //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Earn Amount',
                            style: TextStyle(
                                color: AppColor.bordercolor, fontSize: 12),
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Text(
                                  'Withdraw History',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColor.theamecolor,
                                      fontSize: 12),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return WithdrawHistory(balanceamount);
                                    },
                                  ));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                child: Text(
                                  'Send Withdraw Request',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColor.theamecolor,
                                      fontSize: 12),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SendWithdrawRequest();
                                    },
                                  )).then(
                                    (value) {
                                      Networkcallforreferandearn();
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                child: Text(
                                  'Transfer Earn Amount',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColor.theamecolor,
                                      fontSize: 12),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return TransferEarnAmount();
                                    },
                                  )).then(
                                    (value) {
                                      Networkcallforreferandearn();
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(' ${earnamount.inRupeesFormat()}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          InkWell(
                            child: Row(
                              children: [
                                Text(
                                  'Earn History',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColor.theamecolor,
                                      fontSize: 12),
                                ),
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  color: AppColor.bordercolor,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return EarnHistory();
                                },
                              ));
                            },
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColor.bordercolor,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Earn Amount',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColor.bordercolor,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${earnamount.inRupeesFormat()}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.bordercolor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Withdraw Amount',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColor.bordercolor,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${deductamount.inRupeesFormat()}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.bordercolor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Balance Amount',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColor.bordercolor,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${balanceamount.inRupeesFormat()}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.bordercolor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Center(
                //   child: Image.asset(
                //     'assets/images/refer_img.png',
                //   ),
                // ),
                Center(
                    child: Lottie.asset('assets/images/referandearn.json',
                        height: 300)),
                // SizedBox(
                //   height: 20,
                // ),
                Text(
                  "Notation-Your registered mobile number is your reference number.",
                  style: TextStyle(color: AppColor.bordercolor, fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "To refer your reference member please click on below button and share URL to referral and earn money accordingly.",
                  style: TextStyle(color: AppColor.bordercolor, fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      ButtonDesign(
                          onPressed: () async {
                            // await FlutterShare.share(
                            //     title: 'Share App',
                            //     //text:
                            //     //    'To refer your reference member please share URL to referral and earn money accordingly.',
                            //     linkUrl: link);
                          },
                          child: 'Earn More'.buttoText()),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 14, color: AppColor.bordercolor),
                      ),
                      ButtonDesign(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignUp(
                                    MobileNumber, AppUtility.NAME, false);
                              },
                            )).then((value) {
                              // Navigator.pop(context);
                            });
                          },
                          child: 'Register Referral'.buttoText()),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ).marginOnly(left: 10, right: 10),
          ),
        ),
      ),
    );
  }
}
