import 'dart:convert';

import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/textdesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/deliveryaddress.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/ccavenueapiresponse.dart';
import 'package:UNGolds/network/response/get_address_response.dart';
import 'package:UNGolds/network/response/place_order_emi_response.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_on_emi_check.dart';
import 'package:UNGolds/screens/gold_order/ccavenue_payment.dart';
import 'package:UNGolds/screens/gold_order/CCAvenuepage.dart';
import 'package:UNGolds/screens/gold_order/buygoldonemipayment.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_payment.dart';
import 'package:UNGolds/screens/login_page/login_page.dart';
import 'package:UNGolds/screens/profile_page/profile_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/show_confirmation_dialog.dart';
import 'package:http/http.dart' as http;

bool isCheck = false, islogin = true, showbutton = true;
String address = "", MobileNumber = "", addressid = "";

class CheckOutEMI extends StatefulWidget {
  double pergramrate,
      totalammount,
      remainigammount,
      bookingammount,
      processingfeepergram,
      emipermonth,
      totalpayable,
      bookingamoutpergram,
      pergramprocessingfees,
      membersheepfees,
      total_amount,
      finalemi;
  int gramqty, emimonth;
  String membersheeptype, membersheepstatus;
  String orderid;
  CheckOutEMI(
      this.pergramrate,
      this.gramqty,
      this.totalammount,
      this.remainigammount,
      this.bookingammount,
      this.processingfeepergram,
      this.emimonth,
      this.emipermonth,
      this.totalpayable,
      this.bookingamoutpergram,
      this.pergramprocessingfees,
      this.membersheepfees,
      this.membersheeptype,
      this.membersheepstatus,
      this.orderid,
      this.total_amount,
      this.finalemi);

  State createState() => CheckOutEMIState();
}

class CheckOutEMIState extends State<CheckOutEMI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforgetaddress();
  }

  Future<void> Networkcallforgetaddress() async {
    try {
      showbutton = true;
      setState(() {});
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.get_address,
          NetworkUtility.get_address_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Getaddressresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            islogin = true;
            addressid = response[0].data!.id!;
            address = response[0].data!.address! +
                " , " +
                response[0].data!.taluka! +
                " , " +
                response[0].data!.cityName! +
                " , " +
                response[0].data!.stateName! +
                "-" +
                response[0].data!.pincode! +
                " , " +
                response[0].data!.countryName!;
            MobileNumber = response[0].data!.mobile!;

            setState(() {});
            break;
          case "false":
            showbutton = false;
            islogin = false;
            setState(() {});
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforgetaddress', 'CheckOutEMI', context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isCheck = false;
    showbutton = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
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
                  'Check Out'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showbutton ? _placeOrder() : _inactiveplaceOrder(),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              islogin ? _checkboxForAddress() : Container(),
              islogin ? Container() : showwarning(),
              // islogin
              //     ? Container()
              //     : Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Text(
              //           textAlign: TextAlign.left,
              //           'Please add address',
              //           style: TextDesign.errortext,
              //         ),
              //       ),
              _billWidget(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _billWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Color(0xffcbc7c7))),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                  color: Color.fromARGB(255, 221, 221, 221)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Billing Details',
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            _1st(),
            // _divider(),
            _2nd(),
            // _divider(),
            _3rd(),
            // _divider(),
            _4th(),
            // _divider(),
            _5th(),
            // _divider(),
            _6th(),
            // _divider(),
            _7th(),
            // _divider(),
            _8th(),
            // _divider(),
            _10th(),
            // _divider(),
            _9th()
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.zero, // Remove the default margin
      child: Divider(
        color: Color.fromARGB(255, 255, 255, 255),
        thickness: 1,
      ),
    );
  }

  Widget _1st() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gold Rate / Gram :',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              ' ${widget.pergramrate.inRupeesFormat()}',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _2nd() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Weight In Grams:',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              '${widget.gramqty} (gm)',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _3rd() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount: ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              ' ${widget.totalammount.inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _4th() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Balance Amount:',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              '${widget.remainigammount.inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _5th() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking Amount(${widget.bookingamoutpergram.inRupeesFormat()}/Gram):',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              '${widget.bookingammount.inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _6th() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Processing Fees(${widget.pergramprocessingfees.inRupeesFormat()}/gram):',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              '${widget.processingfeepergram.inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _7th() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EMI Tenure:',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              ' ${widget.emimonth} Month ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _8th() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border(bottom: BorderSide(width: 0.5))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EMI/Month:',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              '${widget.emipermonth.inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _9th() {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Payable Amount:',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            Text(
              '${widget.totalpayable.inRupeesFormat()} ',
              style: TextStyle(
                  color: AppColor.bordercolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  Widget _10th() {
    return widget.membersheepstatus == "0"
        ? Container(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 0.5))),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Membership Fees: ",
                        style: TextStyle(
                            color: AppColor.bordercolor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      widget.membersheeptype == "0"
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  border: Border.all(color: Color(0xff28a745)),
                                  color: Color(0xff28a745)),
                              child: Text(
                                " Free ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  border: Border.all(color: AppColor.redcolor),
                                  color: AppColor.redcolor),
                              child: Text(
                                " Paid ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                    ],
                  ),
                  Text(
                    '' + widget.membersheepfees.inRupeesFormat(),
                    style: TextStyle(
                        color: AppColor.bordercolor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _checkboxForAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                  color: Color.fromARGB(255, 221, 221, 221)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 0.5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Checkbox(
                            focusColor: AppColor.bordercolor,
                            shape: CircleBorder(),
                            value: isCheck,
                            checkColor: AppColor.theamecolor,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value!;
                              });
                              if (isCheck) {
                                showbutton = true;
                                setState(() {});
                              }
                            }),
                      ),
                      Text(
                        AppUtility.NAME,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColor.bordercolor),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 8, bottom: 8),
                    child: Text(
                      address,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColor.bordercolor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 8),
                    child: Text(
                      'Mobile Number: ${MobileNumber}',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColor.bordercolor,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            showbutton
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Please select address',
                      style: TextDesign.errortext,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget showwarning() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfffff3cd)),
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0xfffff3cd)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  "To ensure a smooth delivery process, please click on the 'Add' button below to provide your complete address details. ",
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColor.bordercolor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' Please add address to continue? ',
                      style: TextStyle(
                          color: islogin
                              ? AppColor.bordercolor
                              : AppColor.errorcolor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(CupertinoIcons.arrow_right),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.buttoncolor,
                          borderRadius: BorderRadius.circular(8)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Deliveryaddress();
                            },
                          )).then(
                            (value) {
                              Networkcallforgetaddress();
                            },
                          );
                        },
                        child: Text('Add',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12)),
                      ),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  Widget _placeOrder() {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonDesign(
            onPressed: () {
              if (isCheck) {
                showbutton = true;
                showConfirmationDialog();
              } else {
                showbutton = false;

                setState(() {});
              }
            },
            child: 'Place Order'.buttoText()),
      ),
    );
  }

  Widget _inactiveplaceOrder() {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColor.greycolor,
              borderRadius: BorderRadius.circular(5)),
          child: InkWell(
            onTap: () {
              isCheck = false;
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Place Order',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 17)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You want place order?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              Networkcallforplaceorderwithemi();
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> Networkcallforplaceorderwithemi() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String creatjson = CreateJson().createjsonforplaceorder(
          AppUtility.ID,
          widget.orderid,
          addressid,
          context,
          widget.total_amount,
          widget.finalemi);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.place_order_with_emi,
          NetworkUtility.place_order_with_emi_api,
          creatjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Placeorderemiresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            print("Same page");
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return BuyGoldOnEmiPayment(
                    double.parse(response[0].data!.payableAmount!),
                    response[0].data!.tblEmiInnvoiceId!.toString());
              },
            ));

            break;
          case "false":
            SnackBarDesign('Unable to place order!', context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforplaceorderwithemi',
          'Check Out EMI', context);
    }
  }

  void _launchURL(String url) async {
    //  url = NetworkUtility.base_api + "aboutus-page";
    await launchUrl(Uri.parse(url));
  }
}
