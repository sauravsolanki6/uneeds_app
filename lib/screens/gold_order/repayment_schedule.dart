import 'dart:io';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/all_amount_response.dart';
import 'package:UNGolds/network/response/emi_receipt_response.dart';
import 'package:UNGolds/network/response/repayment_schedule_response.dart';
import 'package:UNGolds/screens/gold_order/eNachsetuppage.dart';
import 'package:UNGolds/screens/gold_order/emi_charge_history.dart';
import 'package:UNGolds/screens/gold_order/emi_charge_paid_history.dart';
import 'package:UNGolds/screens/gold_order/pay_emi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

bool nodata = false;
double earnamount = 0.0, walletAmount = 0.0, lateamount = 0.0;

class RepaymetSchedulepage extends StatefulWidget {
  String orderId;
  RepaymetSchedulepage(this.orderId);

  State createState() => RepaymetSchedulepagestate();
}

class RepaymetSchedulepagestate extends State<RepaymetSchedulepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforrepaymentschedule();
  }

  List<RepaymentscheduleresponseDatum> repaymentlist = [];
  double lateemicharge = 0.0,
      lateemichargepaid = 0.0,
      lateemichargepending = 0.0;
  bool checkforemi = false;
  List<bool> emicheck = [];
  Future<void> Networkcallforrepaymentschedule() async {
    try {
      emicheck.clear();
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforrepaymentschedule(
          AppUtility.ID, widget.orderId, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.repayment_schedule,
          NetworkUtility.repayment_schedule_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Repaymentscheduleresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            repaymentlist = response[0].data!;
            lateemicharge = double.parse(response[0].lateEmiCharge!);
            // lateemicharge = 100.0;
            // lateemichargepaid = 100.0;
            lateemichargepaid = double.parse(response[0].lateEmiChargePaid!);
            lateemichargepending = lateemicharge - lateemichargepaid;
            if (repaymentlist.isEmpty) {
              nodata = false;
            } else {
              nodata = true;
              for (int i = 0; i < repaymentlist.length; i++) {
                emicheck.add(false);
              }
              for (int i = 0; i < repaymentlist.length; i++) {
                if ((repaymentlist[i].paymentDate!.month <=
                            DateTime.now().month &&
                        repaymentlist[i].paymentDate!.year <=
                            DateTime.now().year) &&
                    repaymentlist[i].paymentStatus == "0") {
                  emicheck[i] = true;
                  break;
                }
              }
            }
            setState(() {});
            break;
          case "false":
            setState(() {
              nodata = false;
            });

            break;
        }
      } else {
        setState(() {
          nodata = false;
        });

        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforrepaymentschedule',
          "Repayment Schedule ", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodata = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //endDrawer: CommonDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
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
                  'Repayment Schedule'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
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
        child: BackdropFilter(
            filter: const ColorFilter.mode(Colors.white, BlendMode.softLight),
            child:
                //  nodata
                //     ?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Late EMI Charge: ${lateemicharge.inRupeesFormat()}',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.bordercolor,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              'Late EMI Charge Paid: ${lateemichargepaid.inRupeesFormat()}',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.bordercolor,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              'Late EMI Charge Pending: ${lateemichargepending.inRupeesFormat()}',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.bordercolor,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //     color: AppColor.theamecolor,
                            //     borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: AppColor.theamecolor)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return EMIChargePaidHistory();
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'EMI Charge Paid History',
                                  style: TextStyle(
                                      color: AppColor.theamecolor, fontSize: 8),
                                ),
                              ),
                            ),
                          ).marginOnly(bottom: 10),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: AppColor.theamecolor)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return EMIChargeHistory();
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  'EMI Charge History',
                                  style: TextStyle(
                                      color: AppColor.theamecolor, fontSize: 8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColor.bordercolor,
                thickness: 0.5,
              ),
              Expanded(child: listview())
            ])
            // : Center(
            //     heightFactor: double.infinity,
            //     widthFactor: double.infinity,
            //     child: Image.asset(
            //       'assets/images/no_data_found.png',
            //     ),
            //   ),
            ),
      ),
    );
  }

  int showenachbutton = 0;
  Widget listview() {
    return ListView.builder(
      shrinkWrap: true, // Ensures the ListView takes only the space it needs
      physics:
          const AlwaysScrollableScrollPhysics(), // Ensures consistent scrolling behavior
      itemCount: repaymentlist.length,
      itemBuilder: (context, index) {
        if (repaymentlist[index].paymentMethod == null &&
            repaymentlist[index].paymentStatus == "0") {
          if (showenachbutton == 0) {
            showenachbutton = 1;
          } else {
            showenachbutton = 2;
          }
        }
        return Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 8),
          child: ListTile(
            title: Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // Wrap the first Row child in Expanded to constrain its width
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (index + 1).toString() + '.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.bordercolor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              // Wrap the Column in Expanded to constrain its width
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Payment Date: ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.bordercolor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Flexible(
                                        // Wrap the Text in Flexible to prevent overflow
                                        child: Text(
                                          DateFormat('dd-MM-yyyy').format(
                                            repaymentlist[index].paymentDate!,
                                          ),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.bordercolor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // Handle long text gracefully
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Payment Amount:  ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.bordercolor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Flexible(
                                        // Wrap the Text in Flexible to prevent overflow
                                        child: Text(
                                          "${double.parse(repaymentlist[index].paymentAmount!).inRupeesFormat()}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.bordercolor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // Handle long text gracefully
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          repaymentlist[index].paymentStatus == "0"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    emicheck[index] == false
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: AppColor.redcolor),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Text(
                                                  'Pending',
                                                  style: TextStyle(
                                                    color: AppColor.redcolor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                color: const Color(0xff9c27b0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Networkcallforallamount(
                                                    double.parse(
                                                        repaymentlist[index]
                                                            .paymentAmount!),
                                                    repaymentlist[index].id!,
                                                  );
                                                },
                                                child: const Text(
                                                  'Pay EMI',
                                                  style: TextStyle(
                                                    color: Color(0xff9c27b0),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                    const SizedBox(height: 5),
                                    showenachbutton == 1 &&
                                            repaymentlist[index]
                                                    .paymentMethod ==
                                                null
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                color: AppColor.buttoncolor,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return eNachsetuppage(
                                                          widget.orderId,
                                                          'repayment',
                                                        );
                                                      },
                                                    ),
                                                  ).then(
                                                    (value) {
                                                      Networkcallforrepaymentschedule();
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  'eNach Setup',
                                                  style: TextStyle(
                                                    color: AppColor.buttoncolor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                      color: AppColor.greencolor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        'Success',
                                        style: TextStyle(
                                          color: AppColor.greencolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                          repaymentlist[index].paymentStatus == "1"
                              ? IconButton(
                                  onPressed: () {
                                    Networkcallforemireceipt(
                                      repaymentlist[index].id!,
                                      index,
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.doc,
                                    size: 20,
                                    color: Color(0xff007bff),
                                  ),
                                )
                              : const SizedBox(
                                  height: 20,
                                  width: 50,
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> Networkcallforallamount(double emiamount, String orderId) async {
    try {
      ProgressDialog.showProgressDialog(context, "");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.all_amount,
          NetworkUtility.all_amount_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Allamountresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            earnamount = double.parse(response[0].earnAmount!.toString());
            double deductamount = double.parse(response[0].deductAmount!);
            walletAmount = double.parse(response[0].walletBalance!.toString());

            double lateemicharge1 = response[0].lateEmiCharge == null
                ? 0.0
                : double.parse(response[0].lateEmiCharge!);
            double lateemichargepaid = response[0].lateEmiPaidCharge == null
                ? 0.0
                : double.parse(response[0].lateEmiPaidCharge!);
            lateemicharge = lateemicharge1 == 0.0
                ? lateemichargepaid - lateemicharge1
                : (lateemicharge1) - (lateemichargepaid);

            setState(() {});
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return PayEMI(
                    walletAmount.toPrecision(2),
                    emiamount.toPrecision(2),
                    lateemicharge.toPrecision(2),
                    orderId);
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
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforallamount',
          'Repayment Schedule', context);
    }
  }

  List<EmireceiptresponseDatum> emireceiptrespose = [];
  Future<void> Networkcallforemireceipt(String table_id, int index) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().craetejosnforemireceipt(table_id, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.emi_recepit,
          NetworkUtility.emi_recepit_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Emireceiptresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            emireceiptrespose = response[0].data!;
            setState(() {});
            final pdf = pw.Document();
            await writeOnPdf(
              pdf,
              emireceiptrespose[0].id!,
              DateFormat('dd-MM-yyyy')
                  .format(emireceiptrespose[0].paymentDate!),
              emireceiptrespose[0].name!,
              emireceiptrespose[0].address! +
                  ',' +
                  emireceiptrespose[0].cities! +
                  ',' +
                  emireceiptrespose[0].state! +
                  ',' +
                  emireceiptrespose[0].country!,
              emireceiptrespose[0].pincode!,
              emireceiptrespose[0].mobile!,
              "E-Gold Booking EMI Payment For ${index + 1} EMI",
              'Rs. ' + emireceiptrespose[0].paymentAmount!,
              'Rs. ' + emireceiptrespose[0].paymentAmount!,
              double.parse(emireceiptrespose[0].paymentAmount!),
              emireceiptrespose[0].payVia!,
              DateFormat('dd-MM-yyyy').format(emireceiptrespose[0].paidDate!),
            );
            await savePdf(pdf, table_id);

            Directory documentDirectory =
                await getApplicationDocumentsDirectory();

            String documentPath = documentDirectory.path;

            String fullPath = "$documentPath/$table_id.pdf";
            print(fullPath);
            final result = await OpenFilex.open(fullPath);
            setState(() {
              var _openResult =
                  "type=${result.type}  message=${result.message}";
              print(_openResult);
            });
            break;
          case "false":
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign("Something went wrong!", context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), "Networkcallforemireceipt",
          "Repayment Schedule", context);
    }
  }

  writeOnPdf(
      pw.Document pdf,
      String receiptnumber,
      String date,
      String name,
      String Address,
      String pincode,
      String MobileNumber,
      String description,
      String unitprice,
      String amount,
      double totalpaid,
      String payvia,
      String paiddate) async {
    final imageByteData =
        await rootBundle.load('assets/images/ic_launcher.png');
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    final image = pw.MemoryImage(imageUint8List);
    final imageByteData2 = await rootBundle.load('assets/images/stamp.png');
    final imageUint8List2 = imageByteData2.buffer.asUint8List(
        imageByteData2.offsetInBytes, imageByteData2.lengthInBytes);

    final image2 = pw.MemoryImage(imageUint8List2);
    String payviastatus = "";
    if (payvia == "0") {
      payviastatus = "Payment done through CCAvenue.";
    }
    if (payvia == "1") {
      payviastatus = "Payment done through eNach.";
    } else if (payvia == "2") {
      payviastatus = "Payment done through PhonePe.";
    } else if (payvia == "3") {
      payviastatus = "Payment done through Scanner Pay.";
    } else if (payvia == "5") {
      payviastatus = "Payment done through Uneeds Wallet.";
    } else if (payvia == "6") {
      payviastatus = "Payment done through My Wallet.";
    }
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          // pw.Header(
          // level: 0,
          // child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text('Receipt Number : ${receiptnumber} ',
                      textScaleFactor: 1),
                  pw.Text('EMI Date : ${date} ', textScaleFactor: 1),
                  pw.Text('Paid Date : ${paiddate} ', textScaleFactor: 1),
                ]),
            pw.SizedBox(height: 5),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Image(image, height: 100),
            ]),
          ]
              // )
              ),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('From:',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(
                        width: 200,
                        child: pw.Divider(height: 2),
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 5, bottom: 5)),
                      pw.Text('Uneeds Gold (OPC) PVT.LTD, ',
                          textScaleFactor: 1,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Address:S NO-63/2B, MANALI ARCADE,',
                          textScaleFactor: 1),
                      pw.Text('FLAT-E204 NEAR D-MART, Parvati,Pune City, ',
                          textScaleFactor: 1),
                      pw.Text('Maharashtra, India- 411009 ',
                          textScaleFactor: 1),
                      pw.Text('GST No: 27AADCU4492Q1ZI ', textScaleFactor: 1),
                      pw.Text('Email: uneedsgold25@gmail.com ',
                          textScaleFactor: 1),
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('To:',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(
                        width: 200,
                        child: pw.Divider(height: 2),
                      ),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 5, bottom: 5)),
                      pw.Text('${name} ',
                          textScaleFactor: 1,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Container(
                          width: 200,
                          child: pw.Text('Address: ${Address}',
                              textScaleFactor: 1, maxLines: 5)),
                      pw.Text('Pincode: ${pincode} ', textScaleFactor: 1),
                      pw.Text('Mobile Number: ${MobileNumber} ',
                          textScaleFactor: 1),
                    ]),
              ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Text('Receipt Details',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Table.fromTextArray(context: context, data: <List<String>>[
            <String>['Sr. No', 'Description', 'Unit Price', 'Amount'],
            <String>['1', description + '\n' + payviastatus, unitprice, amount],
          ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),

          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: <pw.Widget>[
                pw.Text('Total Paid Amount:  '),
                pw.Text('Rs. ${totalpaid}')
              ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Padding(
                padding: const pw.EdgeInsets.only(right: 30),
                child: pw.Image(image2, height: 100, width: 100)),
          ),
          pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 30),
                  child: pw.Text('Director',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: <pw
              .Widget>[
            pw.Text('© 2024 Uneeds Gold (OPC) Pvt Ltd | All Rights Reserved'),
          ]),
        ];
      },
    ));
  }

  Future savePdf(pw.Document pdf, String orderid) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/$orderid.pdf");
    file.writeAsBytesSync(await pdf.save());
  }
}
