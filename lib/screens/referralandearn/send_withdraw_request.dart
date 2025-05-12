import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:UNGolds/screens/bankdetailpage/bank_detail_list.dart';
import 'package:UNGolds/screens/referralandearn/tds_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/button_design.dart';
import '../../constant/textdesign.dart';
import '../../network/response/referandearn_response.dart';
import '../../network/response/withdraw_history_response.dart';
import '../bankdetailpage/kyc_detail_page.dart';

bool nodata = false, _isSearching = false;
List<WithdrawhistoryresponseDatum> _searchlist = [];
List<WithdrawhistoryresponseDatum> _withdrawlist = [];
double tds_deduct = 0;
bool validatewithdrawammount = true;
String errormsg = "Please enter withdraw amount";
final withdrawammountcontroller = TextEditingController();
double tdsdeductAmmount = 0.0;
double balanceamount = 0.0;
String tdsPercentage = "", kycstatus = "";
int bank_details = 0, isrequestpending = 0;

class SendWithdrawRequest extends StatefulWidget {
  SendWithdrawRequest();

  State createState() => SendWithdrawRequestState();
}

class SendWithdrawRequestState extends State<SendWithdrawRequest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforreferandearn();
  }

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
            double earnamount = response[0].earnAmount!;
            double deductamount = response[0].deductAmount!;
            balanceamount = earnamount - deductamount;

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
    super.dispose();
    validatewithdrawammount = true;
    withdrawammountcontroller.text = "";
    tdsdeductAmmount = 0.0;
    tdsdeductAmmount = 0.0;
    balanceamount = 0.0;
    tdsPercentage = "";
    kycstatus = "";
    bank_details = 0;
    isrequestpending = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Send Withdraw Request'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            // CircleAvatar(
            //   backgroundColor: Colors.transparent,
            //   radius: 25,
            // ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Balance Amount: ${balanceamount.inRupeesFormat()}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.bordercolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // balanceamount > 2000 &&
                  //         (kycstatus == "1" || kycstatus == "3") &&
                  //         isrequestpending == 0
                  //     ? _middleWidget()
                  //     : Container(),
                  balanceamount >= 2000
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bank_details == 0
                                  ? _buttonCardWidget()
                                  : kycstatus == "0" || kycstatus == "2"
                                      ? Center(
                                          child: Column(
                                          children: [
                                            Lottie.asset(
                                                'assets/images/payal.json'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Complete your KYC First",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColor.bordercolor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return KYCDetailPage("1");
                                                  },
                                                )).then(
                                                  (value) {
                                                    Networkcallforreferandearn();
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Add KYC Details',
                                                    style: TextStyle(
                                                        //decoration: TextDecoration.underline,
                                                        color: AppColor
                                                            .theamecolor,
                                                        fontSize: 16),
                                                  )),
                                            ),
                                          ],
                                        ))
                                      : isrequestpending == 1
                                          ? _middleWidget()
                                          : Center(
                                              child: Column(
                                              children: [
                                                Lottie.asset(
                                                    'assets/images/payal.json'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Your previous request is pending for approval ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor.bordercolor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ))
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   "Wallet Amount: ${balanceamount.inRupeesFormat()}",
                              //   style: TextStyle(
                              //     fontSize: 16,
                              //     color: AppColor.bordercolor,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                              Center(
                                  child: Column(
                                children: [
                                  Lottie.asset('assets/images/payal.json'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "To proceed with withdrawal, you need a minimum of ₹ 2,000.00 in your wallet.  ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.bordercolor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                  // isrequestpending == 0
                  //         ? Center(
                  //             child: Column(
                  //             children: [
                  //               Lottie.asset('assets/images/payal.json'),
                  //               const SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                 "Your previous request is pending for approval ",
                  //                 style: TextStyle(
                  //                   fontSize: 16,
                  //                   color: AppColor.bordercolor,
                  //                 ),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //               const SizedBox(
                  //                 height: 10,
                  //               ),
                  //             ],
                  //           ))
                  //         : isrequestpending == 2
                  //             ? Center(
                  //                 child: Column(
                  //                 children: [
                  //                   Lottie.asset('assets/images/payal.json'),
                  //                   const SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                   Text(
                  //                     "Your previous request is pending for approval ",
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       color: AppColor.bordercolor,
                  //                     ),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 10,
                  //                   ),
                  //                 ],
                  //               ))
                  //             : Container()

                  //_middleWidget()
                ],
              )),
        ),
      ),
    );
  }

  Widget _buttonCardWidget() {
    return Column(
      children: [
        Center(
            child: Column(
          children: [
            Lottie.asset('assets/images/payal.json'),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Bank details are mandatory for withdrawal. Please provide your bank information. ",
              style: TextStyle(
                fontSize: 16,
                color: AppColor.bordercolor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BankDetailList("1");
              },
            )).then(
              (value) {
                Networkcallforreferandearn();
              },
            );
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add Bank Details',
                style: TextStyle(
                    //decoration: TextDecoration.underline,
                    color: AppColor.theamecolor,
                    fontSize: 16),
              )),
        ),
      ],
    );
  }

  Widget _middleWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
              child: Column(
            children: [
              firstWidegt(),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TDS Deduct Amount :",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.bordercolor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    tdsdeductAmmount.inRupeesFormat(),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.bordercolor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note:",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.bordercolor,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "By clicking of the send button, Withdraw Request will be send to admin once it approved by admin amount will be transfer on your account. ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.bordercolor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note:",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.bordercolor,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "TDS deducts automatically from request amount each request at a preset rate of ${tdsPercentage}%, ensuring compliance and streamlining transactions. ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.bordercolor,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ButtonDesign(
                    onPressed: () async {
                      if (withdrawammountcontroller.text.isNotEmpty) {
                        if (double.parse(withdrawammountcontroller.text) >=
                                2000.00 &&
                            double.parse(withdrawammountcontroller.text) <=
                                balanceamount) {
                          validatewithdrawammount = true;
                          errormsg = "";
                          setState(() {});
                          tdsdeductAmmount =
                              (double.parse(withdrawammountcontroller.text) *
                                      double.parse(tdsPercentage)) /
                                  100;
                          Networkcallforsendrequest();
                        } else if (double.parse(
                                withdrawammountcontroller.text) >
                            balanceamount) {
                          validatewithdrawammount = false;
                          errormsg =
                              "The withdrawal amount exceeds the balance amount !";
                          setState(() {});
                        } else if (double.parse(
                                withdrawammountcontroller.text) <
                            2000.00) {
                          validatewithdrawammount = false;
                          errormsg =
                              "Withdrawal request amount must be greater than 2000 !";
                          setState(() {});
                        } else {
                          //       Networkcallforsendrequest();
                        }
                      } else {
                        validatewithdrawammount = false;
                        errormsg = "Please enter withdraw amount";
                        setState(() {});
                      }
                    },
                    child: 'Send Request'.buttoText()),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget firstWidegt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Withdraw Amount',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              '*',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
            )
          ],
        ).marginOnly(top: 20),
        Container(
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            margin: EdgeInsets.only(left: 5),
            child: TextField(
              controller: withdrawammountcontroller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.black, decoration: TextDecoration.none),
              onChanged: (value) {
                tdsdeductAmmount = 0.0;
                if (withdrawammountcontroller.text.isNotEmpty) {
                  if (double.parse(withdrawammountcontroller.text) >= 2000.00 &&
                      double.parse(withdrawammountcontroller.text) <=
                          balanceamount) {
                    validatewithdrawammount = true;
                    errormsg = "";
                    setState(() {});
                    tdsdeductAmmount =
                        (double.parse(withdrawammountcontroller.text) *
                                double.parse(tdsPercentage)) /
                            100;
                  } else if (double.parse(withdrawammountcontroller.text) >
                      balanceamount) {
                    validatewithdrawammount = false;
                    errormsg =
                        "The withdrawal amount exceeds the balance amount !";
                    setState(() {});
                  } else {
                    validatewithdrawammount = false;
                    errormsg =
                        "Withdrawal request amount must be greater than 2000 !";
                    setState(() {});
                  }
                } else {
                  validatewithdrawammount = true;
                  errormsg = "";
                  setState(() {});
                }
              },
              cursorColor: Color(0xff7E7E7E),
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: 'Enter withdraw amount',
                  // errorText: validatewithdrawammount ? null : errormsg,
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
              onSubmitted: (value) {
                if (withdrawammountcontroller.text.isNotEmpty) {
                  if (double.parse(withdrawammountcontroller.text) > 2000.00 &&
                      double.parse(withdrawammountcontroller.text) <=
                          balanceamount) {
                    validatewithdrawammount = true;
                    errormsg = "";
                    setState(() {});
                    tdsdeductAmmount =
                        (double.parse(withdrawammountcontroller.text) *
                                double.parse(tdsPercentage)) /
                            100;
                  } else if (double.parse(withdrawammountcontroller.text) >
                      balanceamount) {
                    validatewithdrawammount = false;
                    errormsg =
                        "The withdrawal amount exceeds the balance amount !";
                    setState(() {});
                  } else {
                    validatewithdrawammount = false;
                    errormsg =
                        "Withdrawal request amount must be greater than 2000 !";
                    setState(() {});
                  }
                } else {
                  validatewithdrawammount = true;
                  errormsg = "";
                  setState(() {});
                }
              },
            ),
          ),
        ).marginOnly(top: 10, bottom: 5),
        validatewithdrawammount
            ? Container()
            : Text(
                errormsg,
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
      ],
    );
  }

  Future<void> Networkcallforsendrequest() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().createjsonforsendrequest(
          AppUtility.ID, withdrawammountcontroller.text.toString(), context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.send_request,
          NetworkUtility.send_request_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Sendrequestresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign("Withdraw request sent successfully!", context,
                AppColor.sucesscolor, Colors.white);
            Navigator.pop(context);
            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforsendrequest',
          'Withdraw History', context);
    }
  }
}
