import 'dart:io';

import 'package:UNGolds/constant/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../constant/app_color.dart';
import '../../constant/button_design.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/my_order_invoice_response.dart';
import '../../network/response/my_order_list_response.dart';
import '../../network/response/my_order_list_without_emi.dart';
import 'buy_gold.dart';
import 'package:pdf/widgets.dart' as pw;

import 'track_my_order.dart';

class Myorderwithoutemi extends StatefulWidget {
  State createState() => MyorderwithoutemiState();
}

class MyorderwithoutemiState extends State<Myorderwithoutemi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NetworkcallforOrderlistwithoutemi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    myorder.clear();
    nodatawithemi = false;
  }

  bool nodatawithemi = true, nodata = true;
  List<MyorderwithoutemiDatum> myorder = [];

  Future<void> NetworkcallforOrderlistwithoutemi() async {
    try {
      myorder.clear();

      ProgressDialog.showProgressDialog(context, "Loading...");

      String createjson =
          CreateJson().createjsonformyorderwithemi(AppUtility.ID, "0", context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.my_gold_order_without_emi,
          NetworkUtility.my_gold_order_with_emi_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Myorderwithoutemiresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            myorder = response[0].data!;
            if (myorder.isNotEmpty) {
              nodata = true;
            } else {
              nodata = false;
            }
            setState(() {});
            break;
          case "false":
            nodata = false;
            setState(() {});
            break;
        }
      } else {
        nodata = false;
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
    final height = MediaQuery.of(context).size.height;
    // TODO: implement build
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
          child: nodata
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    child: listviewmyorder(height),
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
                                return BuyGold();
                              },
                            ));
                          },
                          child: 'BUY GOLD'.buttoText()),
                    )
                  ],
                ),
        ));
  }

  Widget listviewmyorder(double height) {
    return myorder.isNotEmpty
        ? ListView.builder(
            itemCount: myorder.length,
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
                        children: [
                          Center(
                            child: CachedNetworkImage(
                              imageUrl: NetworkUtility.base_api +
                                  myorder[index].image_path!,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                    "assets/images/ic_launcher.png");
                              },
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  // height: 120,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: imageProvider,
                                    ),
                                  ),
                                );
                              },
                              height: 80,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Name: ',
                                    style: TextStyle(
                                        color: AppColor.bordercolor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      myorder[index].productSlug!.toUpperCase(),
                                      style: TextStyle(
                                          color: AppColor.bordercolor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    totalammountmyorder(index),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    orderIdmyorder(index),
                                  ]),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bookingdatemyorder(index),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  goldratemyorder(index),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
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
                                Networkcallforinvoicemyorder(
                                    myorder[index].id!);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Invoice',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
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
                                    return TrackMyOrder(myorder[index].id!,
                                        myorder[index].invoiceNumber!);
                                  },
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Track Order',
                                  style: TextStyle(
                                      color: AppColor.theamecolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
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
                          return BuyGold();
                        },
                      ));
                    },
                    child: 'BUY GOLD'.buttoText()),
              )
            ],
          );
  }

  Widget totalammountmyorder(int index) {
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
          '${double.parse(myorder[index].totalPrice!).inRupeesFormat()}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget orderIdmyorder(int index) {
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
          '${myorder[index].invoiceNumber}',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget bookingdatemyorder(int index) {
    return Row(
      children: [
        Text(
          'Purchase Date:',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          DateFormat('dd-MM-yyyy').format(myorder[index].paymentDate!),
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget goldratemyorder(int index) {
    return Row(
      children: [
        Text(
          'Purchase Gram:',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        Text(
          ' ${double.parse(myorder[index].productInGram!)} gm',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  List<MyorderinvoiceDatum> myorderinvoicelist = [];
  Future<void> Networkcallforinvoicemyorder(String orderid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonformyorderinvoice(orderid, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.product_innvoice,
          NetworkUtility.api_product_innvoice,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Myorderinvoiceresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            myorderinvoicelist = response[0].data!;
            setState(() {});
            final pdf = pw.Document();
            await writeOnPdfmyorder(
                pdf,
                myorderinvoicelist[0].invoiceNumber!,
                DateFormat('dd-MM-yyyy')
                    .format(myorderinvoicelist[0].paymentDate!),
                myorderinvoicelist[0].name!,
                myorderinvoicelist[0].address! +
                    ',' +
                    myorderinvoicelist[0].cities! +
                    ',' +
                    myorderinvoicelist[0].state! +
                    ',' +
                    myorderinvoicelist[0].country!,
                myorderinvoicelist[0].pincode!,
                myorderinvoicelist[0].mobile!,
                myorderinvoicelist[0].productPricePerGram!,
                myorderinvoicelist[0].productInGram!,
                myorderinvoicelist[0].productGst!,
                myorderinvoicelist[0].state!,
                myorderinvoicelist[0].productName!,
                myorderinvoicelist[0].makingCharge!,
                myorderinvoicelist[0].makingGst!,
                myorderinvoicelist[0].image_path!);
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
      PrintMessage.printmessage(e.toString(),
          "Networkcallforinvoicemygoldorder", "My Gold Order", context);
    }
  }

  writeOnPdfmyorder(
      pw.Document pdf,
      String invoicenumber,
      String date,
      String name,
      String Address,
      String pincode,
      String MobileNumber,
      String ratepergram,
      String gramqty,
      String totalgst1,
      String state,
      String productname,
      String makingcharge,
      String makingGst,
      String imagePath) async {
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

    double totalgst = double.parse(totalgst1).toPrecision(2);
    double cgst = double.parse(totalgst1) / 2;
    double finalgst =
        (((double.parse(gramqty) * double.parse(ratepergram)) * totalgst) / 100)
            .toPrecision(2);
    double makingchargegst =
        ((double.parse(gramqty) * double.parse(makingcharge)) *
                double.parse(makingGst)) /
            100;
    double finaltotal = ((double.parse(ratepergram) * double.parse(gramqty)) +
            finalgst +
            (double.parse(gramqty) * double.parse(makingcharge)) +
            makingchargegst)
        .toPrecision(2);
    final netImage = await networkImage(NetworkUtility.base_api + imagePath);

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(
                    'Invoice Number : ${invoicenumber} ',
                    textScaleFactor: 1,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Invoice Date : ${date} ',
                    textScaleFactor: 1,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ]),
            pw.SizedBox(height: 5),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Image(image, height: 100),
            ]),
          ]),
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
                      //pw.Text('Pincode:  ', textScaleFactor: 1),
                      pw.Text('Mobile Number: ${MobileNumber} ',
                          textScaleFactor: 1),
                    ]),
              ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Text('Invoice Details',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Padding(padding: const pw.EdgeInsets.all(2)),
          pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
            <dynamic>[
              'Sr. No',
              'Item',
              'Product Image',
              'Rate Per / Gram (Rs.)',
              'Gram',
              'Total (Rs.)'
            ],
            <dynamic>[
              '1',
              productname,
              pw.Image(netImage, height: 50),
              'Rs. ' + double.parse(ratepergram).toStringAsFixed(2).toString(),
              gramqty + ' (GM)',
              'Rs. ' +
                  ((double.parse(ratepergram) * double.parse(gramqty)))
                      .toStringAsFixed(2)
                      .toString()
            ],
          ]),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text('Bank Account Details : ',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          textScaleFactor: 1),
                      pw.Row(children: [
                        pw.Text('Name:',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            textScaleFactor: 1),
                        pw.Text('Uneeds Gold (OPC) PVT.LTD',
                            textScaleFactor: 1),
                      ]),
                      pw.Row(children: [
                        pw.Text(
                          'Bank:',
                          textScaleFactor: 1,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text('IDFC FIRST BANK', textScaleFactor: 1),
                      ]),
                      pw.Row(children: [
                        pw.Text('Account No:',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            textScaleFactor: 1),
                        pw.Text('95169595953', textScaleFactor: 1),
                      ]),
                      pw.Row(children: [
                        pw.Text('IFSC:',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            textScaleFactor: 1),
                        pw.Text('IDFB 0041431 ', textScaleFactor: 1),
                      ]),
                    ]),
                pw.Column(children: <pw.Widget>[
                  pw.Table.fromTextArray(context: context, data: <List<String>>[
                    <String>[],
                    state == "Maharashtra"
                        ? <String>[
                            'CGST (${cgst}) % :',
                            'Rs. ' +
                                (finalgst / 2).toStringAsFixed(2).toString()
                          ]
                        : <String>[
                            'IGST (${double.parse(totalgst1).toStringAsFixed(2)} % :)',
                            'Rs. ' + (finalgst).toStringAsFixed(2).toString()
                          ],
                    state == "Maharashtra"
                        ? <String>[
                            'SGST (${cgst}) % :',
                            'Rs. ' +
                                (finalgst / 2).toStringAsFixed(2).toString()
                          ]
                        : <String>[],
                    // <String>['Making Charge: ', makingchargegst.toString()],
                    <String>[
                      'Invoice Total: ',
                      'Rs. ' + finaltotal.toStringAsFixed(2).toString()
                    ],
                  ]),
                  pw.SizedBox(height: 15),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: <pw.Widget>[
                        pw.Image(image2, height: 100, width: 100),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 30),
                          child: pw.Text(
                            'Director',
                            textAlign: pw.TextAlign.center,
                          ),
                        )
                      ]),
                ]),
              ]),
          pw.Padding(
              padding: const pw.EdgeInsets.only(top: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Container(
                      width: 500,
                      child: pw.Text(
                          "© 2024 Uneeds Gold (OPC) Pvt Ltd | All Rights Reserved ",
                          maxLines: 5,
                          textAlign: pw.TextAlign.center))
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
