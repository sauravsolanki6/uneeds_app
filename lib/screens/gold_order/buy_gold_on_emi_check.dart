import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/textdesign.dart';
import 'package:UNGolds/network/response/buy_gold_on_emi_response.dart';
import 'package:UNGolds/screens/bankdetailpage/kyc_detail_page.dart';
import 'package:UNGolds/screens/gold_order/buy_now.dart';
import 'package:UNGolds/screens/gold_order/checkout_emi.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/get_kyc_status_response.dart';
import '../login_page/login_page.dart';

class BuyGoldOnEMICheck extends StatefulWidget {
  double pergramrate, bookingAmount, processingfees, membersheepfees;
  String membersheeptype,
      membersheepstatus,
      processingfeesgst,
      makingcharge,
      makinggst;
  BuyGoldOnEMICheck(
      this.pergramrate,
      this.bookingAmount,
      this.processingfees,
      this.membersheepfees,
      this.membersheeptype,
      this.membersheepstatus,
      this.processingfeesgst,
      this.makingcharge,
      this.makinggst);
  State createState() => BuyGoldOnEMICheckState();
}

int gramqty = 10, emimonth = 0;
double totalammount = 0.00,
    bookingammount = 0.00,
    remainigammount = totalammount - bookingammount,
    processingfee = 0.00,
    actualprocessingfee = 0.00;

bool is12monthCheck = false,
    is18monthCheck = false,
    is24monthCheck = false,
    is30monthCheck = false,
    is36monthCheck = false,
    isCheck = true;
double processingfeepergram = (processingfee * gramqty).toPrecision(2);

class BuyGoldOnEMICheckState extends State<BuyGoldOnEMICheck> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalammount = widget.pergramrate * gramqty;
    bookingammount = widget.bookingAmount * gramqty;
    remainigammount = totalammount - bookingammount;
    actualprocessingfee = widget.processingfees;
    double processingfeewithgst =
        (widget.processingfees * double.parse(widget.processingfeesgst)) / 100;
    processingfee = widget.processingfees + processingfeewithgst;
    _gramqtyController.text = "10";
    // _gramqtyController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: _gramqtyController.text.length));
    _gramqtyController.selection =
        TextSelection.collapsed(offset: _gramqtyController.text.length);
    Networkcallforkycstatus();
  }

  String KYCStatus = "";
  Future<void> Networkcallforkycstatus() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_kyc_status,
          NetworkUtility.get_kyc_status_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getkycstatusresponse> profileresponse = List.from(signup!);
        String status = profileresponse[0].status.toString();
        switch (status) {
          case "true":
            KYCStatus = profileresponse[0].data!.kyc!;
            setState(() {});

            break;
          case "false":
            SnackBar(content: Text(profileresponse[0].message!));
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforkycstatus', "KYC Detail", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    totalammount = 0.0;
    bookingammount = 0.00;
    remainigammount = totalammount - bookingammount;
    gramqty = 10;
    emimonth = 0;
    processingfeepergram = 0.0;
    is12monthCheck = false;
    is18monthCheck = false;
    is24monthCheck = false;
    is30monthCheck = false;
    is36monthCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                  'Buy Gold On EMI'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _twentytwoWidget(),
      body: Container(
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
        child: SingleChildScrollView(
          child: BackdropFilter(
            filter: const ColorFilter.mode(Colors.white, BlendMode.softLight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _firstWidget(),
                    _secondWidget(),
                    Row(
                      children: [
                        Expanded(child: _thirdWidget()),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: _fourthWidget()),
                      ],
                    ),
                    _fifthWidget(),
                    _sixWidget(),
                    _sevenWidget(),
                    _eightWidget(),
                    _nineWidget(),
                    _tenWidget(),
                    _elevenWidget(),
                    !isCheck ? _errorText() : Container(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstWidget() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          KYCStatus == "0"
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColor.intoColor,
                        border: Border.all(color: AppColor.intoColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return KYCDetailPage("1");
                          },
                        ));
                      },
                      child: Text('Start KYC Process',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ),
                )
              : Container(),
          KYCStatus == "1"
              ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.green.withOpacity(0.7)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "KYC Verified! You can now make secure gold purchases with confidence.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              : Container(),
          KYCStatus == "2"
              ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "We regret to inform you that your KYC verification has been rejected due to issues with the provided document.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColor.intoColor,
                              border: Border.all(color: AppColor.intoColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return KYCDetailPage("1");
                                },
                              ));
                            },
                            child: Text('Start KYC Process',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          KYCStatus == "3"
              ? Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Color(0xffd4edda)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your document has been successfully submitted. While we verify it, feel free to proceed with your gold purchase. ",
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _secondWidget() {
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter Product In Gram (Atleast 10 Gram)",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff444444)),
          ),
          SizedBox(
            height: 10,
          ),
          second(),
        ],
      ),
    );
  }

  final _gramqtyController = TextEditingController();
  Widget second() {
    return Container(
      child: TextField(
        controller: _gramqtyController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        style: TextStyle(color: AppColor.bordercolor),
        decoration: InputDecoration(
          hintText: 'Atleast you have to buy 10 grams',
          hintStyle: TextDesign.hinttext,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.all(8),
        ),
        onChanged: (value) {
          gramqty = int.parse(_gramqtyController.text);
          if (gramqty < 10) {
            SnackBarDesign("Atleast you have to buy 10 grams ", context,
                AppColor.errorcolor, Colors.white);
          } else {
            totalammount = AppUtility.pergramrate * gramqty;
            bookingammount = widget.bookingAmount * gramqty;
            remainigammount = totalammount - bookingammount;
            processingfeepergram = (processingfee * gramqty).toPrecision(2);
            _gramqtyController.text = gramqty.toString();
            _gramqtyController.selection =
                TextSelection.collapsed(offset: _gramqtyController.text.length);
            setState(() {});
          }
        },
      ),
    );
  }

  Widget _thirdWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColor.intoColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                ' ${totalammount.inRupeesFormat()}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fourthWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColor.intoColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Booking Amount',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                ' ${bookingammount.inRupeesFormat()}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fifthWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: RichText(
          text: TextSpan(
              text: 'Notation: ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
              children: [
            TextSpan(
                text:
                    ' Ensure a seamless start to your installment plan as the booking amount is deducted from the gold price. Your first payment covers the booking amount, first EMI, and processing fee!',
                style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400))
          ])),
    );
  }

  Widget _sixWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Balance Amount",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.bordercolor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffdaa835),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ' ${remainigammount.inRupeesFormat()}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sevenWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        child: Container(
          // decoration: BoxDecoration(
          //     border: Border.all(color: AppColor.intoColor, width: 0.5),
          //     borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '12 \n Month',
                    style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  VerticalDivider(
                    color: AppColor.bordercolor,
                    thickness: 0.5,
                  ),
                  Text(
                    '${(remainigammount / 12).toPrecision(2).inRupeesFormat()} \n EMI',
                    style: TextStyle(
                        color: Color(0xffdaa835),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                        value: is12monthCheck,
                        checkColor: Color(0xff9c27b0),
                        activeColor: Colors.white,
                        onChanged: (value) {
                          emimonth = 12;
                          // is12monthCheck = false;
                          is18monthCheck = false;
                          is24monthCheck = false;
                          is30monthCheck = false;
                          is36monthCheck = false;
                          setState(() {
                            is12monthCheck = value!;
                            isCheck = true;
                          });
                          if (is12monthCheck == false) {
                            emimonth = 0;
                            isCheck = false;
                            setState(() {});
                          }
                        }).marginOnly(left: 5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _eightWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: AppColor.intoColor,
        //     ),
        //     borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '18 \n Month',
                  style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalDivider(
                  color: AppColor.bordercolor,
                  thickness: 0.5,
                ),
                Text(
                  ' ${(remainigammount / 18).toPrecision(2).inRupeesFormat()} \n EMI',
                  style: TextStyle(
                      color: Color(0xffdaa835),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                      value: is18monthCheck,
                      checkColor: Color(0xff9c27b0),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        emimonth = 18;
                        is12monthCheck = false;
                        // is18monthCheck = false;
                        is24monthCheck = false;
                        is30monthCheck = false;
                        is36monthCheck = false;
                        setState(() {
                          is18monthCheck = value!;
                          isCheck = true;
                        });
                        if (is18monthCheck == false) {
                          emimonth = 0;
                          isCheck = false;
                          setState(() {});
                        }
                      }).marginOnly(left: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nineWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: AppColor.intoColor,
        //     ),
        //     borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '24 \n Month',
                  style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalDivider(
                  color: AppColor.bordercolor,
                  thickness: 0.5,
                ),
                Text(
                  '${(remainigammount / 24).toPrecision(2).inRupeesFormat()} \n EMI',
                  style: TextStyle(
                      color: Color(0xffdaa835),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                      value: is24monthCheck,
                      checkColor: Color(0xff9c27b0),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        is12monthCheck = false;
                        is18monthCheck = false;
                        // is24monthCheck = false;
                        is30monthCheck = false;
                        is36monthCheck = false;
                        emimonth = 24;
                        setState(() {
                          is24monthCheck = value!;
                          isCheck = true;
                        });
                        if (is24monthCheck == false) {
                          emimonth = 0;
                          isCheck = false;
                          setState(() {});
                        }
                      }).marginOnly(left: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tenWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: AppColor.intoColor,
        //     ),
        //     borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '30 \n Month',
                  style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalDivider(
                  color: AppColor.intoColor,
                  thickness: 0.5,
                ),
                Text(
                  '${(remainigammount / 30).toPrecision(2).inRupeesFormat()} \n EMI',
                  style: TextStyle(
                      color: Color(0xffdaa835),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                      value: is30monthCheck,
                      checkColor: Color(0xff9c27b0),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        is12monthCheck = false;
                        is18monthCheck = false;
                        is24monthCheck = false;
                        // is30monthCheck = false;
                        is36monthCheck = false;
                        emimonth = 30;
                        setState(() {
                          is30monthCheck = value!;
                          isCheck = true;
                        });
                        if (is30monthCheck == false) {
                          isCheck = false;
                          emimonth = 0;
                          setState(() {});
                        }
                      }).marginOnly(left: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _elevenWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: AppColor.intoColor,
        //     ),
        //     borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '36 \n Month',
                  style: TextStyle(
                    color: AppColor.bordercolor,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                VerticalDivider(
                  color: AppColor.intoColor,
                  thickness: 0.5,
                ),
                Text(
                  '${(remainigammount / 36).toPrecision(2).inRupeesFormat()} \n EMI',
                  style: TextStyle(
                      color: Color(0xffdaa835),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                      value: is36monthCheck,
                      checkColor: Color(0xff9c27b0),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        is12monthCheck = false;
                        is18monthCheck = false;
                        is24monthCheck = false;
                        is30monthCheck = false;
                        // is36monthCheck = false;
                        emimonth = 36;
                        setState(() {
                          is36monthCheck = value!;
                          isCheck = true;
                        });
                        if (is36monthCheck == false) {
                          isCheck = false;
                          emimonth = 0;
                          setState(() {});
                        }
                      }).marginOnly(left: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tweleWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Gold Rate/ gram :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              widget.pergramrate.inRupeesFormat(),
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _thirteenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Weight in grams :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              ' ${(gramqty)} gm',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _fourteenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Amount :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              ' ${(totalammount.inRupeesFormat())} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _fifteenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Balance Amount :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              ' ${(remainigammount.inRupeesFormat())} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _sixteenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Booking Amount(${widget.bookingAmount.inRupeesFormat()}/Gram) :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '${(bookingammount).inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _seventeenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EMI Tenure :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '${emimonth} Month',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _eightteenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EMI / Month :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            emimonth != 0
                ? Text(
                    ' ${(remainigammount / emimonth).inRupeesFormat()} ',
                    style: TextStyle(
                        color: AppColor.bordercolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
                : Text(
                    '${0.0.inRupeesFormat()}}',
                    style: TextStyle(
                        color: AppColor.bordercolor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )
          ],
        ),
      ),
    );
  }

  Widget _nineteenWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Processing Fees (${processingfee.inRupeesFormat()}/Gram) :",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              '  ${processingfeepergram.inRupeesFormat()}',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _twentyWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Membership Fees: ",
                  style: TextStyle(
                      color: AppColor.bordercolor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                widget.membersheeptype == "0"
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: Color(0xff28a745)),
                            color: Color(0xff28a745)),
                        child: Text(
                          " Free ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            border: Border.all(color: AppColor.redcolor),
                            color: AppColor.redcolor),
                        child: Text(
                          " Paid ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
              ],
            ),
            widget.membersheeptype == "0"
                ? Text(
                    widget.membersheepfees.inRupeesFormat(),
                    style: TextStyle(
                        color: AppColor.bordercolor,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColor.bordercolor,
                        decorationThickness: 2,
                        fontWeight: FontWeight.w600),
                  )
                : Text(
                    widget.membersheepfees.inRupeesFormat(),
                    style: TextStyle(
                        color: AppColor.bordercolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )
          ],
        ),
      ),
    );
  }

  Widget _twentyoneWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Payable Amount: ",
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              widget.membersheepstatus == "0"
                  ? widget.membersheeptype == "0"
                      ? '  ${(processingfeepergram + bookingammount).inRupeesFormat()}'
                      : ' ${(processingfeepergram + bookingammount + widget.membersheepfees).inRupeesFormat()}'
                  : '${(processingfeepergram + bookingammount).inRupeesFormat()}',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _twentytwoWidget() {
    return is12monthCheck == false &&
            is18monthCheck == false &&
            is24monthCheck == false &&
            is30monthCheck == false &&
            is36monthCheck == false
        ? Container(
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
            child: Container(
              margin: EdgeInsets.all(8.0),
              // margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              gramqty = int.parse(_gramqtyController.text);
              if (gramqty < 10) {
                SnackBarDesign("Atleast you have to buy 10 grams ", context,
                    AppColor.errorcolor, Colors.white);
              } else {
                processingfeepergram = (processingfee * gramqty).toPrecision(2);
                setState(() {});
                _showDetailBottomSheet(context);
              }
            },
            child: Container(
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
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: AppColor.theamecolor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _errorText() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Text(
        'To proceed, please select at least one EMI option.',
        style: TextStyle(
            fontSize: 10,
            // fontWeight: FontWeight.w400,
            color: Color(0xffdc3545)),
      ),
    );
  }

  void _showDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // elevation: 0.0,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _tweleWidget(),
                _thirteenWidget(),
                _fourteenWidget(),
                _fifteenWidget(),
                _sixteenWidget(),
                _seventeenWidget(),
                _eightteenWidget(),
                _nineteenWidget(),
                widget.membersheepstatus == "0" ? _twentyWidget() : Container(),
                _twentyoneWidget(),
                GestureDetector(
                  onTap: () {
                    double total_ammount = (widget.pergramrate * gramqty) +
                        (processingfee * gramqty) +
                        (widget.membersheepstatus == "0"
                            ? widget.membersheeptype == "0"
                                ? 0.0
                                : widget.membersheepfees
                            : 0.0);
                    double finalemi = (processingfee * gramqty) +
                        (widget.membersheepstatus == "0"
                            ? widget.membersheeptype == "0"
                                ? 0.0
                                : widget.membersheepfees
                            : 0.0) +
                        bookingammount;

                    NetworkCallForBuyGoldOnEMI(
                        gramqty.toString(),
                        widget.bookingAmount,
                        (remainigammount / emimonth).toPrecision(2),
                        emimonth,
                        actualprocessingfee,
                        widget.processingfeesgst,
                        processingfee * gramqty,
                        widget.makingcharge,
                        widget.makinggst,
                        widget.membersheeptype,
                        widget.membersheepstatus,
                        total_ammount,
                        finalemi,
                        widget.membersheepfees);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: AppColor.theamecolor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Buy Now',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> NetworkCallForBuyGoldOnEMI(
      String gramqty,
      double bookingAmount,
      double emiAmount,
      int emimonth,
      double actualprocessingfees,
      String processingfeesgst,
      double totalprocessingfees,
      String makingcharge,
      String makinggst,
      String membersheeptype,
      String membersheepstatus,
      double total_amount,
      double finalemi,
      double membersheepfees) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().createjsonforgoldonemi(
          context,
          gramqty,
          AppUtility.pergramrate,
          bookingAmount,
          emimonth,
          emiAmount,
          actualprocessingfees,
          processingfeesgst,
          totalprocessingfees,
          makingcharge,
          makinggst,
          membersheeptype,
          membersheepstatus,
          membersheeptype == "1" ? membersheepfees.toString() : "0");
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.buy_gold_emi,
          NetworkUtility.buy_gold_emi_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldonemiresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            String orderid = response[0].data!.orderId.toString();
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CheckOutEMI(
                    widget.pergramrate,
                    int.parse(gramqty),
                    totalammount,
                    remainigammount,
                    bookingammount,
                    processingfeepergram,
                    emimonth,
                    (remainigammount / emimonth).toPrecision(2),
                    widget.membersheepstatus == "0"
                        ? widget.membersheeptype == "0"
                            ? processingfeepergram + bookingammount
                            : processingfeepergram +
                                bookingammount +
                                widget.membersheepfees
                        : processingfeepergram + bookingammount,
                    widget.bookingAmount,
                    processingfee,
                    widget.membersheepfees,
                    widget.membersheeptype,
                    widget.membersheepstatus,
                    orderid,
                    total_amount,
                    finalemi);
              },
            ));
            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);

            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkCallForCheckOut',
          'Buy Gold Check Out', context);
    }
  }
}
