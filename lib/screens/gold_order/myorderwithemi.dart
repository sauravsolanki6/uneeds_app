import 'dart:io';

import 'package:UNGolds/constant/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import '../../constant/app_color.dart';
import '../../constant/button_design.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/emi_invoice_response.dart';
import '../../network/response/my_order_list_response.dart';
import 'buy_gold_on_emi.dart';
import 'package:pdf/widgets.dart' as pw;

import 'repayment_schedule.dart';
import 'track_emi_order.dart';

class Myorderwithemi extends StatefulWidget {
  State createState() => MyorderwithemiState();
}

class MyorderwithemiState extends State<Myorderwithemi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkcallforOrderlistwithemi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myorderlistwithemi.clear();

    nodatawithemi = false;
  }

  bool nodatawithemi = true, nodata = true;
  List<MyorderlistresponseDatum> myorderlistwithemi = [];

  Future<void> NetworkcallforOrderlistwithemi() async {
    try {
      myorderlistwithemi.clear();
      ProgressDialog.showProgressDialog(context, "Loading...");

      String createjson =
          CreateJson().createjsonformyorderwithemi(AppUtility.ID, "1", context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.my_gold_order_with_emi,
          NetworkUtility.my_gold_order_with_emi_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Myorderlistresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            myorderlistwithemi = response[0].data!;
            if (myorderlistwithemi.isNotEmpty) {
              nodatawithemi = true;
            } else {
              nodatawithemi = false;
            }
            setState(() {});
            break;
          case "false":
            nodatawithemi = false;
            setState(() {});
            break;
        }
      } else {
        nodatawithemi = false;
        setState(() {});
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'NetworkcallforOrderlist', 'My Gold Order', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final height = MediaQuery.of(context).size.height;
    return Container(
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
        child: nodatawithemi
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: listview(height),
                ),
              )
            : Column(
                children: [
                  Lottie.asset('assets/images/payal.json'),
                  SizedBox(
                    height: height / 30,
                  ),
                  Text(
                    ' No order found ',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.bordercolor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Looks like you haven't made your order yet ",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.bordercolor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ButtonDesign(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return BuyGoldOnEMI();
                            },
                          ));
                        },
                        child: 'BUY GOLD ON EMI'.buttoText()),
                  )
                ],
              ),
        //show list of my order
      ),
    );
  }

  Widget listview(double height) {
    return myorderlistwithemi.isNotEmpty
        ? ListView.builder(
            itemCount: myorderlistwithemi.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            totalammount(index),
                            orderId(index),
                          ]),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          emitenure(index),
                          emimonth(index),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      bookingdate(index),
                      goldweight(index),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          goldrate(index),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColor.theamecolor,
                                borderRadius: BorderRadius.circular(5)),
                            child: InkWell(
                              onTap: () async {
                                Networkcallforinvoice(
                                    myorderlistwithemi[index].id!);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Invoice',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: AppColor.theamecolor,
                                )),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return RepaymetSchedulepage(
                                        myorderlistwithemi[index].id!);
                                    //  return SequreEMIPayment(100.0, "1", false, false);
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Repayment Schedule / Pay EMI ',
                                  style: TextStyle(
                                      color: AppColor.theamecolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      myorderlistwithemi[index].showOrderCard == "1"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.theamecolor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return TrackEMIOrder(
                                              myorderlistwithemi[index].id!,
                                              myorderlistwithemi[index]
                                                  .invoiceNumber!);
                                        },
                                      ));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Track Order',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            },
          )
        : Column(
            children: [
              Lottie.asset('assets/images/payal.json'),
              SizedBox(
                height: height / 30,
              ),
              Text(
                ' No order found ',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.bordercolor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Looks like you haven't made your order yet ",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.bordercolor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ButtonDesign(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return BuyGoldOnEMI();
                        },
                      ));
                    },
                    child: 'BUY GOLD ON EMI'.buttoText()),
              )
            ],
          );
  }

  Widget totalammount(int index) {
    return Row(
      children: [
        Text(
          'Total Amount: ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          '${double.parse(myorderlistwithemi[index].totalAmount!).inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget orderId(int index) {
    return Row(
      children: [
        Text(
          'Order ID: ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          '${myorderlistwithemi[index].invoiceNumber}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget emitenure(int index) {
    return Row(
      children: [
        Text(
          'EMI TENURE: ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          '${myorderlistwithemi[index].emiMonth} months',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget emimonth(index) {
    return Row(
      children: [
        Text(
          'EMI/ Month: ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          '${double.parse(myorderlistwithemi[index].emiAmtPerMonth!).inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget bookingdate(int index) {
    return Row(
      children: [
        Text(
          'E- Booking Date:',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          DateFormat('dd-MM-yyyy')
              .format(myorderlistwithemi[index].paymentDate!),
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget goldrate(int index) {
    return Row(
      children: [
        Text(
          'Gold Rate/ Gram:',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          ' ${double.parse(myorderlistwithemi[index].purchaseLiveRate!).inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget goldweight(int index) {
    return Row(
      children: [
        Text(
          'Weight In Grams: ',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          '${myorderlistwithemi[index].purchaseGram}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  List<EmiinvoiceresponseDatum> invoicelist = [];
  Future<void> Networkcallforinvoice(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforemiinvoice(AppUtility.ID, orderid, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.order_emi_invoice,
          NetworkUtility.order_emi_invoice_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Emiinvoiceresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            invoicelist = response[0].data!;
            setState(() {});
            final pdf = pw.Document();
            await writeOnPdf(
                pdf,
                invoicelist[0].invoiceNumber!,
                DateFormat('dd-MM-yyyy').format(invoicelist[0].paymentDate!),
                invoicelist[0].name!,
                invoicelist[0].address! +
                    ',' +
                    invoicelist[0].cities! +
                    ',' +
                    invoicelist[0].state! +
                    ',' +
                    invoicelist[0].country!,
                invoicelist[0].pincode!,
                invoicelist[0].mobile!,
                invoicelist[0].purchaseLiveRate!,
                invoicelist[0].purchaseGram!,
                invoicelist[0].bookingAmt!,
                invoicelist[0].processingFee!,
                invoicelist[0].proceessGst!,
                invoicelist[0].emiAmtPerMonth!,
                invoicelist[0].emiMonth!,
                invoicelist[0].membershipFee == null ||
                        invoicelist[0].membershipFee == "0"
                    ? '0.0'
                    : invoicelist[0].membershipFee,
                invoicelist[0].nextDueDate!,
                invoicelist[0].state!);
            await savePdf(pdf, orderid);

            Directory documentDirectory =
                await getApplicationDocumentsDirectory();

            String documentPath = documentDirectory.path;

            String fullPath = "$documentPath/$orderid.pdf";
            print(fullPath);
            final result = await OpenFilex.open(fullPath);
            setState(() {
              var _openResult =
                  "type=${result.type}  message=${result.message}";
              print(_openResult);
            });
            break;
          case "false":
            SnackBarDesign('Not able to get invoice', context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "Networkcallforinvoice", "My Gold Order", context);
    }
  }

  writeOnPdf(
      pw.Document pdf,
      String invoicenumber,
      String date,
      String name,
      String Address,
      String pincode,
      String MobileNumber,
      String ratepergram,
      String gramqty,
      String bookingamount,
      String processingfee,
      String processinggst,
      String EmiPerMonth,
      String emiMonth,
      String membershipamount,
      String nextduedate,
      String state) async {
    String bullet = "\u2022";
    final imageByteData =
        await rootBundle.load('assets/images/ic_launcher.png');
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    final image = pw.MemoryImage(imageUint8List);
    final imageByteData2 = await rootBundle.load('assets/images/stamp.png');
    final imageUint8List2 = imageByteData2.buffer.asUint8List(
        imageByteData2.offsetInBytes, imageByteData2.lengthInBytes);

    final image2 = pw.MemoryImage(imageUint8List2);

    double totalgst =
        ((double.parse(processingfee) * double.parse(processinggst)) *
                double.parse(gramqty)) /
            100;

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          // pw.Header(
          // level: 0,
          // child:
          pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: <pw.Widget>[
                  pw.Text('Invoice Number : ${invoicenumber} ',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      textScaleFactor: 1),
                  pw.Text('Invoice Date : ${date} ',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      textScaleFactor: 1),
                ]),
            pw.SizedBox(height: 5),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(image, height: 100),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text('Bank Account Details : ',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            textScaleFactor: 1),
                        pw.Text('Name:Uneeds Gold (OPC) PVT.LTD',
                            textScaleFactor: 1),
                        pw.Text('Bank: IDFC FIRST BANK', textScaleFactor: 1),
                        pw.Text('Account No: 95169595953', textScaleFactor: 1),
                        pw.Text('IFSC: IDFB 0041431 ', textScaleFactor: 1),
                      ]),
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
                          child: pw.Text('Address: ${Address}-${pincode}',
                              textScaleFactor: 1, maxLines: 5)),
                      pw.Text('Mobile Number: ${MobileNumber} ',
                          textScaleFactor: 1),
                    ]),
              ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Text('Invoice Details',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),

          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          state == "Maharashtra"
              ? pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Sr. No',
                    'Item',
                    'Rate Per / Gram (Rs.)',
                    'Gram',
                    'CGST(Rs.)',
                    'SGST(Rs.)',
                    'Total(Rs.)'
                  ],
                  <String>[
                    '1',
                    'E-Gold Booking',
                    'Rs.' +
                        double.parse(ratepergram).toStringAsFixed(2).toString(),
                    gramqty + ' (GM)',
                    '0.00',
                    '0.00',
                    'Rs.' +
                        ((double.parse(ratepergram) * double.parse(gramqty)))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  <String>[
                    '2',
                    'Booking Amount',
                    'Rs.' + double.parse(bookingamount).toStringAsFixed(2),
                    gramqty + ' (GM)',
                    '0.00',
                    '0.00',
                    'Rs.' +
                        ((double.parse(bookingamount) * double.parse(gramqty)))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  <String>[
                    '3',
                    'Processing Fees',
                    'Rs.' + double.parse(processingfee).toStringAsFixed(2),
                    gramqty + ' (GM)',
                    (totalgst / 2).toStringAsFixed(2).toString(),
                    (totalgst / 2).toStringAsFixed(2).toString(),
                    'Rs.' +
                        ((double.parse(processingfee) * double.parse(gramqty) +
                                totalgst))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  membershipamount != "0.0"
                      ? <String>[
                          '4',
                          'Membership fees',
                          'Rs.' +
                              double.parse(bookingamount).toStringAsFixed(2),
                          gramqty + ' (GM)',
                          '0.00',
                          '0.00',
                          'Rs.' +
                              ((double.parse(bookingamount) *
                                      double.parse(gramqty)))
                                  .toStringAsFixed(2)
                                  .toString()
                        ]
                      : <String>[]
                ])
              : pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[
                    'Sr. No',
                    'Item',
                    'Rate Per /Gram (Rs.)',
                    'Gram',
                    'IGST (Rs.)',
                    'Total (Rs.)'
                  ],
                  <String>[
                    '1',
                    'E-Gold Booking',
                    'Rs. ' + double.parse(ratepergram).toStringAsFixed(2),
                    gramqty + ' (GM)',
                    '00.00',
                    'Rs.' +
                        ((double.parse(ratepergram) * double.parse(gramqty)))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  <String>[
                    '2',
                    'Booking Amount',
                    'Rs.' + double.parse(bookingamount).toStringAsFixed(2),
                    gramqty + ' (GM)',
                    '0.00',
                    'Rs.' +
                        ((double.parse(bookingamount) * double.parse(gramqty)))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  <String>[
                    '3',
                    'Processing Fees',
                    'Rs.' + double.parse(processingfee).toStringAsFixed(2),
                    gramqty + ' (GM)',
                    totalgst.toString(),
                    'Rs.' +
                        ((double.parse(processingfee) * double.parse(gramqty) +
                                totalgst))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  membershipamount != "0.0"
                      ? <String>[
                          '4',
                          'Membership fees',
                          'Rs.' +
                              double.parse(bookingamount).toStringAsFixed(2),
                          gramqty + ' (GM)',
                          '0.00',
                          'Rs.' +
                              ((double.parse(bookingamount) *
                                      double.parse(gramqty)))
                                  .toStringAsFixed(2)
                                  .toString()
                        ]
                      : <String>[]
                ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Table.fromTextArray(context: context, data: <List<String>>[
                  <String>[],
                  <String>[
                    'Paid Amount: ',
                    'Rs. ' +
                        ((double.parse(bookingamount) * double.parse(gramqty)) +
                                double.parse(membershipamount) +
                                ((double.parse(processingfee) *
                                        double.parse(gramqty)) +
                                    totalgst))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                  <String>[
                    'Pending Amount: ',
                    'Rs. ' +
                        (double.parse(ratepergram) * double.parse(gramqty) -
                                (double.parse(bookingamount) *
                                    double.parse(gramqty)))
                            .toStringAsFixed(2)
                            .toString(),
                  ],
                  <String>[
                    'Duration: ',
                    emiMonth + ' Month',
                  ],
                  <String>[
                    'EMI Amount: ',
                    'Rs. ' + double.parse(EmiPerMonth).toStringAsFixed(2),
                  ],
                  <String>[
                    'Next Due Date: ',
                    nextduedate,
                  ],
                  <String>[
                    'Invoice Total: ',
                    'Rs.' +
                        (double.parse(ratepergram) * double.parse(gramqty) +
                                ((double.parse(processingfee) *
                                        double.parse(gramqty)) +
                                    totalgst) +
                                double.parse(membershipamount))
                            .toStringAsFixed(2)
                            .toString()
                  ],
                ]),
                pw.Image(image2, height: 100, width: 100),
              ]),
          pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 10),
                  child: pw.Text('Director',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
          pw.Text('Terms And Condition:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),

          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        '  That present Gold Booking Scheme is only in respect of 99.95% Purity Gold and the rate prevalent at the time of actual booking shall be made applicable.',
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  The Applicant Customer shall pay Rs. $bookingamount/- per 1 grams at the time of booking and remaining amount shall be payable in Minimum Monthly Installment (MMI).",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  Rs. ${double.parse(processingfee) + (totalgst / double.parse(gramqty))}/- per 1 Gram will be charged as the processing fee/ Booking Charges (Non-Refundable).",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  The rate of 99.5% Purity Gold as prevalent at the time of actual booking shall be final and the same shall always remain binding.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  Each month the customer shall pay his/her Minimum Monthly Installment (MMI) without any delay. In case of delay in payment of MMI within stipulated period, the late fee @ Rs. 10/- Per Grams for each month shall be imposed. All the payment shall be made by RTGS/IMPS/NEFT/online payment only.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  KYC to be Fulfilled at the time of Registration.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  EMI Paid Amount to be Circulated to the Said Scheme E-Gold Only (No Cash/Refund Amount to be Paid).",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  That present gold account is non-transferable. EMI Date Will Not be Change at any Point of time.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  Advance Booking and Processing Fee to be Calculated as per Increment Booking Per Gram Gold.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  If Any EMI/Monthly Booking Amount Discontinued before Maturity Period Applicant Shall not be allowed Skip/Exit before maturity of Scheme Tenure .(T&C)",
                        maxLines: 5,
                      )),
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  E-Gold Rate Calculated as per the maturity day/time(Booking vs E-Gold Physical Disbursement eligible 24crt/99.95 gold only)",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  Gold Purchase Choice as Per Customer's Preferable Retail Outlet Point , GST and Making Charges (Making Charges May defer as per Ornaments) to be Paid by Applicants",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  In Case E-Gold Booking Rate Decreases/Reduces at the time of Maturity E-Gold Delivery ,then Booking rate shall be always Binding.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  In Case E-Gold Booking Rate Increases at the time of Maturity E-Gold Delivery ,then Booking rate shall be Calculated On the day of E-Gold Maturity Delivery.   ",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  All the Payment shall be made by RTGS/NEFT/IMPS/UPI/EMIs. Cheques and Cash are not acceptable for Booking and EMIs.",
                        maxLines: 5,
                      ))
                ],
              )),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 5,
                    height: 5,
                    decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle, color: PdfColors.black),
                  ),
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                        "  All Rights are reserved to the Company , Subject to Pune City Jurisdiction only.",
                        maxLines: 5,
                      ))
                ],
              )),
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
