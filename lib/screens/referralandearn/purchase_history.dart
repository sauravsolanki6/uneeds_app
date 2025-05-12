import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/purchase_history_response.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/textdesign.dart';
import '../../network/response/withdraw_history_response.dart';

bool nodata = false, _isSearching = false;
List<PurchasehistoryDatum> _searchlist = [];
List<PurchasehistoryDatum> _purchasehistorylist = [];

class PurchaseHistory extends StatefulWidget {
  String customerid;
  PurchaseHistory(this.customerid);

  State createState() => PurchaseHistoryState();
}

class PurchaseHistoryState extends State<PurchaseHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforpurchasehistory();
  }

  Future<void> Networkcallforpurchasehistory() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforpurchasehistory(widget.customerid, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.purchase_history,
          NetworkUtility.purchase_history_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Purchasehistoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            _purchasehistorylist = response[0].data!;
            if (_purchasehistorylist.isEmpty) {
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
        Navigator.pop(context);
        nodata = false;
        setState(() {});
        SnackBarDesign(
            'Something went wrong', context, AppColor.errorcolor, Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforearnhistory', 'Earn History', context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  'EMI Order List'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
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
            child: nodata
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _firstCardWidget(),
                        Expanded(child: listview())
                      ],
                    ),
                  )
                : Center(
                    heightFactor: double.infinity,
                    widthFactor: double.infinity,
                    // child: Image.asset(
                    //   'assets/images/no_data_found.png',
                    // ),
                    child: Column(
                      children: [
                        Lottie.asset('assets/images/payal.json'),
                        // SizedBox(
                        //   height: height / 30,
                        // ),
                        Text(
                          ' No emi order found ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Looks like you haven't emi order yet ",
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
          ),
        ),
      ),
    );
  }

  Widget _firstCardWidget() {
    return Container(
      //  margin: EdgeInsets.only(left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isSearching = !_isSearching;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
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

                            for (var i in _purchasehistorylist) {
                              if (i.purchaseGram!.contains(val.toLowerCase()) ||
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
                      color: AppColor.intoColor,
                    )),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listview() {
    return ListView.builder(
      itemCount:
          _isSearching ? _searchlist.length : _purchasehistorylist.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Purchase Gram : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? double.parse(_searchlist[index].purchaseGram!)
                              .inRupeesFormat()
                          : double.parse(
                                  _purchasehistorylist[index].purchaseGram!)
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
                      'Purchase Date ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? DateFormat('dd-MM-yyyy')
                              .format(_searchlist[index].paymentDate!)
                          : DateFormat('dd-MM-yyyy')
                              .format(_purchasehistorylist[index].paymentDate!),
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
        );
      },
    );
  }
}
