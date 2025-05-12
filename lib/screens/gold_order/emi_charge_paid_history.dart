import 'dart:math';

import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/emi_charge_paid_history_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';

bool nodata = true, _isSearching = false;
List<EmichargepaidhistoryresponseDatum> emichargepaidhistorylist = [];
List<EmichargepaidhistoryresponseDatum> _searchlist = [];

class EMIChargePaidHistory extends StatefulWidget {
  State createState() => EMIChargePaidHistoryState();
}

class EMIChargePaidHistoryState extends State<EMIChargePaidHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforemichagepaidhistory();
  }

  Future<void> Networkcallforemichagepaidhistory() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.emi_charge_paid_history,
          NetworkUtility.emi_charge_paid_history_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Emichargepaidhistoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            emichargepaidhistorylist = response[0].data!;
            if (emichargepaidhistorylist.isEmpty) {
              nodata = false;
            } else {
              nodata = true;
            }
            setState(() {});
            break;
          case "false":
            nodata = false;
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        nodata = false;
        setState(() {});
        Navigator.pop(context);
        SnackBarDesign(
            'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(),
          'Networkcallforemichagepaidhistory', 'EMIChargePaidHistory', context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodata = true;
    _isSearching = false;
    _searchlist.clear();
    emichargepaidhistorylist.clear();
  }

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
                  'EMI Charge Paid History'.introTitleText(context),
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
          child: nodata
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_firstCardWidget(), Expanded(child: listview())],
                )
              : Center(
                  heightFactor: double.infinity,
                  widthFactor: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Lottie.asset('assets/images/payal.json')),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' No emi charge paid history found ',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.darkcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Looks like you haven't paid emi charge yet",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.darkcolor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _firstCardWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
                height: 50,
              ),
              _isSearching
                  ? Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search here...',
                            hintStyle: TextDesign.hinttext),
                        autofocus: true,
                        style: const TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            color: Colors.black),
                        onChanged: (val) {
                          _searchlist.clear();

                          for (var i in emichargepaidhistorylist) {
                            if (i.paidAmount!
                                    .toLowerCase()
                                    .contains(val.toLowerCase()) ||
                                (i.installmentMonth! + 'EMI'.toLowerCase())
                                    .contains(val) ||
                                DateFormat('dd-MM-yyyy')
                                    .format(i.updatedOn!)
                                    .contains(val)) {
                              _searchlist.add(i);
                              setState(() {
                                _searchlist;
                              });
                            } else {
                              setState(() {
                                _searchlist;
                              });
                            }
                          }
                        },
                      ),
                    )
                  : Text(
                      'Search Here...',
                      style: TextDesign.hinttext,
                    ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      _searchlist.clear();
                    });
                  },
                  icon: Icon(
                    _isSearching
                        ? CupertinoIcons.clear_circled_solid
                        : Icons.search,
                    color: AppColor.bordercolor,
                  )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listview() {
    return ListView.builder(
      itemCount:
          _isSearching ? _searchlist.length : emichargepaidhistorylist.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Amount : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? double.parse(_searchlist[index].paidAmount!)
                              .inRupeesFormat()
                          : double.parse(
                                  emichargepaidhistorylist[index].paidAmount!)
                              .inRupeesFormat(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Paid With EMI: ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? _searchlist[index].installmentMonth! + 'EMI'
                          : emichargepaidhistorylist[index].installmentMonth! +
                              'EMI',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Paid Date:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? DateFormat('dd-MM-yyyy')
                              .format(_searchlist[index].updatedOn!)
                          : DateFormat('dd-MM-yyyy').format(
                              emichargepaidhistorylist[index].updatedOn!),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
