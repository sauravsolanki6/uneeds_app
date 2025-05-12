import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:UNGolds/network/response/transferamountresponse.dart';
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
String errormsg = "Please enter transfer amount";
final withdrawammountcontroller = TextEditingController();
double tdsdeductAmmount = 0.0;
double balanceamount = 0.0, requestamount = 0.0;
String tdsPercentage = "", kycstatus = "";
int bank_details = 0, isrequestpending = 0;

class TransferEarnAmount extends StatefulWidget {
  State createState() => TransferEarnAmountState();
}

class TransferEarnAmountState extends State<TransferEarnAmount> {
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
            requestamount = response[0].total_withdraw_amount!;
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
    requestamount = 0.0;
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
                  'Transfer Earn Amount To My Wallet'.introTitleText(context),
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
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Balance Amount: ${balanceamount.inRupeesFormat()}",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.bordercolor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    isrequestpending == 0
                        ? Text(
                            "Withdraw Request Amount: ${requestamount.inRupeesFormat()}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.bordercolor,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Container(),
                    balanceamount == 0.0
                        ? _buttonCardWidget()
                        : ((balanceamount >= (balanceamount - requestamount)))
                            ? kycstatus == "1" || kycstatus == "3"
                                ? _middleWidget()
                                : Center(
                                    child: Column(children: [
                                    Lottie.asset('assets/images/payal.json'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      " KYC Pending.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColor.bordercolor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Complete the KYC process to transfer earn amount to wallet. ",
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Add KYC Details',
                                            style: TextStyle(
                                                //decoration: TextDecoration.underline,
                                                color: AppColor.theamecolor,
                                                fontSize: 16),
                                          )),
                                    ),
                                  ]))
                            : Center(
                                child: Column(
                                children: [
                                  Lottie.asset('assets/images/payal.json'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    // isrequestpending == 1
                                    //     ? "Your withdrawal request is pending for approval "
                                    // :
                                    "Check you balance amount you have already send withdraw request of ${requestamount.inRupeesFormat()}",
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
                    //_firstCardWidget(),
                    // Expanded(child: listview())
                  ],
                ),
              )
              //   ],
              // )
              // ),
              ),
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
              "Note : Your current earn amount is insufficient to proceed. ",
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
              isrequestpending == 0
                  ? Text(
                      "Note : You can transfer upto this ${(balanceamount - requestamount).inRupeesFormat()}. ",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.bordercolor,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )
                  : Container(),
              isrequestpending == 0
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(),
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
                      " Entered Amount will be transferred to My Wallet amount by clicking the transfer button.",
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
              Align(
                alignment: Alignment.bottomCenter,
                child: ButtonDesign(
                    onPressed: () async {
                      if (withdrawammountcontroller.text.isNotEmpty) {
                        if (double.parse(withdrawammountcontroller.text) >=
                                1.00 &&
                            double.parse(withdrawammountcontroller.text) <
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
                              "The transfer amount exceeds the balamce amount !";
                          setState(() {});
                        } else if (double.parse(
                                withdrawammountcontroller.text) <
                            1.00) {
                          validatewithdrawammount = false;
                          errormsg = "Transfer amount must be greater than 1 !";
                          setState(() {});
                        } else {
                          // Networkcallforsendrequest();
                        }
                      } else {
                        validatewithdrawammount = false;
                        errormsg = "Please enter transfer amount";
                        setState(() {});
                      }
                    },
                    child: 'Transfer'.buttoText()),
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
              'Transfer Amount',
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
                  if (isrequestpending == 0) {
                    if (double.parse(withdrawammountcontroller.text) >= 1.00 &&
                        double.parse(withdrawammountcontroller.text) <=
                            (balanceamount - requestamount)) {
                      validatewithdrawammount = true;
                      errormsg = "";
                      setState(() {});
                      tdsdeductAmmount =
                          (double.parse(withdrawammountcontroller.text) *
                                  double.parse(tdsPercentage)) /
                              100;
                    } else if (double.parse(withdrawammountcontroller.text) >
                        (balanceamount - requestamount)) {
                      validatewithdrawammount = false;
                      errormsg =
                          "The transfer amount exceeds the balance amount !";
                      setState(() {});
                    }
                  } else {
                    if (double.parse(withdrawammountcontroller.text) >= 1.00 &&
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
                          "The transfer amount exceeds the balance amount !";
                      setState(() {});
                    }
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
                  hintText: 'Enter transfer amount',
                  // errorText: validatewithdrawammount ? null : errormsg,
                  errorStyle: TextDesign.errortext,
                  hintStyle: TextDesign.hinttext),
              onSubmitted: (value) {
                if (withdrawammountcontroller.text.isNotEmpty) {
                  if (isrequestpending == 0) {
                    if (double.parse(withdrawammountcontroller.text) >= 1.00 &&
                        double.parse(withdrawammountcontroller.text) <=
                            (balanceamount - requestamount)) {
                      validatewithdrawammount = true;
                      errormsg = "";
                      setState(() {});
                      tdsdeductAmmount =
                          (double.parse(withdrawammountcontroller.text) *
                                  double.parse(tdsPercentage)) /
                              100;
                    } else if (double.parse(withdrawammountcontroller.text) >
                        (balanceamount - requestamount)) {
                      validatewithdrawammount = false;
                      errormsg =
                          "The transfer amount exceeds the balance amount !";
                      setState(() {});
                    }
                  } else {
                    if (double.parse(withdrawammountcontroller.text) >= 1.00 &&
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
                          "The transfer amount exceeds the balance amount !";
                      setState(() {});
                    }
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
      String createjson = CreateJson().createjsonfortransferamount(
          AppUtility.ID, withdrawammountcontroller.text.toString(), context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_transfer_amount,
          NetworkUtility.api_transfer_amount_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Transferamountresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign("Amount transfer successfully to your wallet!",
                context, AppColor.sucesscolor, Colors.white);
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
