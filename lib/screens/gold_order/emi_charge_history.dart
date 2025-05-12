import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/emi_charge_history_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';

bool nodata = true, _isSearching = false;
List<EmichargehistoryresponseDatum> emichargehistorylist = [];
List<EmichargehistoryresponseDatum> _searchlist = [];

class EMIChargeHistory extends StatefulWidget {
  State createState() => EMIChargeHistoryState();
}

class EMIChargeHistoryState extends State<EMIChargeHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforemichagehistory();
  }

  Future<void> Networkcallforemichagehistory() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.emi_charge_history,
          NetworkUtility.emi_charge_history_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Emichargehistoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            emichargehistorylist = response[0].data!;
            if (emichargehistorylist.isEmpty) {
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
      PrintMessage.printmessage(e.toString(), 'Networkcallforemichagehistory',
          'EMIChargeHistory', context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodata = true;
    _searchlist.clear();
    emichargehistorylist.clear();
    _isSearching = false;
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
                  'EMI Charge  History'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      body: Container(
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
                      Lottie.asset('assets/images/payal.json'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' No emi charge history found ',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.darkcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Looks like you haven't paid emi yet",
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

                          for (var i in emichargehistorylist) {
                            if (i.chargeAmount!.contains(val.toLowerCase()) ||
                                (i.installmentMonth! + ' emi')
                                    .contains(val.toLowerCase()) ||
                                DateFormat('dd-MM-yyyy')
                                    .format(i.paymentDoneOn!)
                                    .contains(val) ||
                                DateFormat('dd-MM-yyyy')
                                    .format(i.paymentDate!)
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
          _isSearching ? _searchlist.length : emichargehistorylist.length,
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Charge Amount : ',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                          Text(
                            _isSearching
                                ? double.parse(_searchlist[index].chargeAmount!)
                                    .inRupeesFormat()
                                : double.parse(emichargehistorylist[index]
                                        .chargeAmount!)
                                    .inRupeesFormat(),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Charge on EMI : ',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                          Text(
                            _isSearching
                                ? _searchlist[index].installmentMonth! + ' EMI'
                                : emichargehistorylist[index]
                                        .installmentMonth! +
                                    ' EMI',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'EMI Payment Date : ',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                          Text(
                            _isSearching
                                ? DateFormat('dd-MM-yyyy')
                                    .format(_searchlist[index].paymentDoneOn!)
                                : DateFormat('dd-MM-yyyy').format(
                                    emichargehistorylist[index].paymentDoneOn!),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'EMI Date:',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                          Text(
                            _isSearching
                                ? DateFormat('dd-MM-yyyy').format(
                                    emichargehistorylist[index].paymentDate!)
                                : DateFormat('dd-MM-yyyy').format(
                                    emichargehistorylist[index].paymentDate!),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
