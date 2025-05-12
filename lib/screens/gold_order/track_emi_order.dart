import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/trackemiorderesponse.dart';
import 'package:UNGolds/network/response/trackorderresponse.dart';
import 'package:UNGolds/network/response/viewemiorderresponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';

bool placeorder = true,
    confirmorder = false,
    shipedorder = false,
    deliverdorder = false;
String placeorderremark = "",
    confirmremark = "",
    shipedremark = "",
    deliverremark = "";
String placeorderdate = "", confirmdate = "", shipeddate = "", deliveddate = "";

class TrackEMIOrder extends StatefulWidget {
  String orderid;
  String invoiceNumber;
  TrackEMIOrder(this.orderid, this.invoiceNumber);
  State createState() => TrackEMIOrderState();
}

class TrackEMIOrderState extends State<TrackEMIOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforviewemiorder();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    placeorder = true;
    confirmorder = false;
    shipedorder = false;
    deliverdorder = false;
    placeorderremark = "";
    confirmremark = "";
    shipedremark = "";
    deliverremark = "";
    placeorderdate = "";
    confirmdate = "";
    shipeddate = "";
    deliveddate = "";
    _activeCurrentStep = 0;
  }

  Future<void> Networkcallforviewemiorder() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforviewemiorder(widget.orderid, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.view_emi_order,
          NetworkUtility.api_view_emi_order,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Viewemiorderresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            placeorderdate = DateFormat('dd/MM/yyyy hh:mm a')
                .format(response[0].data!.paymentDate!);
            Networkcallforplaceorder(
                "1", NetworkUtility.api_check_emi_order_placed);

            setState(() {});
            break;
          case "false":
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        setState(() {});
        Navigator.pop(context);
        // SnackBarDesign(
        //     'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforemichagehistory',
          'EMIChargeHistory', context);
    }
  }

  Future<void> Networkcallforplaceorder(String status1, String api) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforemitrackorder(widget.orderid, status1, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.check_emi_order_placed, api, createjson, context);
      if (list != null) {
        Navigator.pop(context);
        List<Trackemiorderresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            placeorder = true;
            placeorderremark = response[0].data!.remark!;
            placeorderdate = DateFormat('dd/MM/yyyy hh:mm a')
                .format(response[0].data!.orderStatusUpdateDate!);
            Networkcallforconfirm(
                "2", NetworkUtility.api_check_emi_order_confirmed);

            setState(() {});
            break;
          case "false":
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        setState(() {});
        Navigator.pop(context);
        // SnackBarDesign(
        //     'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforemichagehistory',
          'EMIChargeHistory', context);
    }
  }

  Future<void> Networkcallforconfirm(String status1, String api) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforemitrackorder(widget.orderid, status1, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.check_emi_order_placed, api, createjson, context);
      if (list != null) {
        Navigator.pop(context);
        List<Trackemiorderresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            confirmremark = response[0].data!.remark!;
            confirmdate = DateFormat('dd/MM/yyyy hh:mm a')
                .format(response[0].data!.orderStatusUpdateDate!);
            confirmorder = true;
            _activeCurrentStep = 1;
            Networkcallforshiped(
                "3", NetworkUtility.api_check_emi_order_shipped);
            setState(() {});
            break;
          case "false":
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        setState(() {});
        Navigator.pop(context);
        // SnackBarDesign(
        //     'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforemichagehistory',
          'EMIChargeHistory', context);
    }
  }

  Future<void> Networkcallforshiped(String status1, String api) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforemitrackorder(widget.orderid, status1, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.check_emi_order_placed, api, createjson, context);
      if (list != null) {
        Navigator.pop(context);
        List<Trackemiorderresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            shipedorder = true;
            shipedremark = response[0].data!.remark!;
            shipeddate = DateFormat('dd/MM/yyyy hh:mm a')
                .format(response[0].data!.orderStatusUpdateDate!);

            _activeCurrentStep = 2;
            Networkcallfordeliverd(
                "4", NetworkUtility.api_check_emi_order_delivered);

            setState(() {});
            break;
          case "false":
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        setState(() {});
        Navigator.pop(context);
        // SnackBarDesign(
        //     'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforemichagehistory',
          'EMIChargeHistory', context);
    }
  }

  Future<void> Networkcallfordeliverd(String status1, String api) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforemitrackorder(widget.orderid, status1, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.check_emi_order_placed, api, createjson, context);
      if (list != null) {
        Navigator.pop(context);
        List<Trackemiorderresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            deliverdorder = true;
            deliverremark = response[0].data!.remark!;
            deliveddate = DateFormat('dd/MM/yyyy hh:mm a')
                .format(response[0].data!.orderStatusUpdateDate!);

            _activeCurrentStep = 3;

            setState(() {});
            break;
          case "false":
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        setState(() {});
        Navigator.pop(context);
        // SnackBarDesign(
        //     'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforemichagehistory',
          'EMIChargeHistory', context);
    }
  }

  int _activeCurrentStep = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                    'Track Order'.introTitleText(context),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Placed On ${placeorderdate}",
                    style: TextStyle(
                        color: AppColor.buttoncolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Order ID: ${widget.invoiceNumber}",
                    style: TextStyle(
                        color: AppColor.buttoncolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Theme(
                    data: ThemeData(
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(primary: AppColor.buttoncolor)),
                    child: Stepper(
                        type: StepperType.vertical,
                        currentStep: _activeCurrentStep,
                        controlsBuilder: (context, controller) {
                          return const SizedBox.shrink();
                        },
                        steps: [
                          Step(
                            isActive: placeorder,
                            state: StepState.complete,
                            title: Text(
                              'Placed',
                              style: TextStyle(
                                  color: AppColor.buttoncolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: widgetplaceorder(),
                            content: Container(
                              alignment: Alignment.centerLeft,
                              // child: Text(
                              //   placeorderremark,
                              //   style: TextStyle(color: AppColor.bordercolor),
                              // ),
                            ),
                          ),
                          Step(
                            state: StepState.complete,
                            isActive: confirmorder,
                            title: Text(
                              'Confirmed & Pack',
                              style: TextStyle(
                                  color: AppColor.buttoncolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: widgetconfirmorder(),
                            content: Container(
                              alignment: Alignment.centerLeft,
                              // child: Text(
                              //   confirmremark,
                              //   style: TextStyle(color: AppColor.bordercolor),
                              // ),
                            ),
                          ),
                          Step(
                            state: StepState.complete,
                            isActive: shipedorder,
                            title: Text(
                              'Shipped',
                              style: TextStyle(
                                  color: AppColor.buttoncolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: widgetshiporder(),
                            content: Container(
                              alignment: Alignment.centerLeft,
                              // child: Text(
                              //   shipedremark,
                              //   style: TextStyle(color: AppColor.bordercolor),
                              // ),
                            ),
                          ),
                          Step(
                            state: StepState.complete,
                            isActive: deliverdorder,
                            title: Text(
                              'Delivered',
                              style: TextStyle(
                                  color: AppColor.buttoncolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: widgetdeliverorder(),
                            content: Container(
                              alignment: Alignment.centerLeft,
                              // child: Text(
                              //   deliverremark,
                              //   style: TextStyle(color: AppColor.bordercolor),
                              // ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget widgetplaceorder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          placeorderdate,
          style: TextStyle(color: AppColor.bordercolor),
        ),
        Text(
          placeorderremark,
          style: TextStyle(color: AppColor.bordercolor),
        )
      ],
    );
  }

  Widget widgetconfirmorder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          confirmdate,
          style: TextStyle(color: AppColor.bordercolor),
        ),
        Text(
          confirmremark,
          style: TextStyle(color: AppColor.bordercolor),
        )
      ],
    );
  }

  Widget widgetshiporder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shipeddate,
          style: TextStyle(color: AppColor.bordercolor),
        ),
        Text(
          shipedremark,
          style: TextStyle(color: AppColor.bordercolor),
        )
      ],
    );
  }

  Widget widgetdeliverorder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          deliveddate,
          style: TextStyle(color: AppColor.bordercolor),
        ),
        Text(
          deliverremark,
          style: TextStyle(color: AppColor.bordercolor),
        )
      ],
    );
  }
}
