import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:UNGolds/network/response/tds_history_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/textdesign.dart';
import '../../network/response/withdraw_history_response.dart';

bool nodata = false, _isSearching = false;
List<TdshistoryDatum> _searchlist = [];
List<TdshistoryDatum> _tdshistory = [];

class TDSHistory extends StatefulWidget {
  double balanceamount;
  TDSHistory(this.balanceamount);

  State createState() => TDSHistoryState();
}

class TDSHistoryState extends State<TDSHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallfortdshistory();
  }

  Future<void> Networkcallfortdshistory() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.tds_history,
          NetworkUtility.tds_history_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Tdshistoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            _tdshistory = response[0].data!;
            if (_tdshistory.isEmpty) {
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
                  'TDS Deduct History'.introTitleText(context),
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
                          ' No TDS Deduct history found ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Looks like you haven't TDS deduct yet ",
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

                            for (var i in _tdshistory) {
                              double tdcrecive =
                                  (double.parse(i.withdrawAmount!)
                                          .toPrecision(2)) -
                                      (double.parse(i.tdsDeductAmount!)
                                          .toPrecision(2));
                              if (i.withdrawAmount!.contains(val) ||
                                  i.tdsDeductAmount!.contains(val) ||
                                  tdcrecive.toString().contains(val) ||
                                  DateFormat('dd-MM-yyyy')
                                      .format(i.statusChangeDate!)
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
    ).marginOnly(left: 10, right: 10);
  }

  Widget listview() {
    return ListView.builder(
      itemCount: _isSearching ? _searchlist.length : _tdshistory.length,
      itemBuilder: (context, index) {
        double receivedammount = _isSearching
            ? double.parse(_searchlist[index].withdrawAmount!).toPrecision(2) -
                double.parse(_searchlist[index].tdsDeductAmount!).toPrecision(2)
            : double.parse(_tdshistory[index].withdrawAmount!).toPrecision(2) -
                double.parse(_tdshistory[index].tdsDeductAmount!)
                    .toPrecision(2);
        print(receivedammount);
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Request Amount : ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                        Text(
                          _isSearching
                              ? double.parse(_searchlist[index].withdrawAmount!)
                                  .inRupeesFormat()
                              : double.parse(_tdshistory[index].withdrawAmount!)
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
                          'Received Date ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                        Text(
                          _isSearching
                              ? DateFormat('dd-MM-yyyy')
                                  .format(_searchlist[index].statusChangeDate!)
                              : DateFormat('dd-MM-yyyy')
                                  .format(_tdshistory[index].statusChangeDate!),
                          style: TextStyle(
                              fontSize: 12,
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
                  children: [
                    Text(
                      'TDS Deduct Amount : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? double.parse(_searchlist[index].tdsDeductAmount!)
                              .inRupeesFormat()
                          : double.parse(_tdshistory[index].tdsDeductAmount!)
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
                      'TDS Received Amount : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? receivedammount.inRupeesFormat()
                          : receivedammount.inRupeesFormat(),
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
    ).marginOnly(left: 10, right: 10);
  }
}
