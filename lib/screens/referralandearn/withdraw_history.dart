import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:UNGolds/screens/referralandearn/tds_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/textdesign.dart';
import '../../network/response/withdraw_history_response.dart';

bool nodata = false, _isSearching = false;
List<WithdrawhistoryresponseDatum> _searchlist = [];
List<WithdrawhistoryresponseDatum> _withdrawlist = [];
double tds_deduct = 0;

class WithdrawHistory extends StatefulWidget {
  double balanceamount;
  WithdrawHistory(this.balanceamount);

  State createState() => WithdrawHistoryState();
}

class WithdrawHistoryState extends State<WithdrawHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforearnhistory();
  }

  Future<void> Networkcallforearnhistory() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.withdraw_history,
          NetworkUtility.withdraw_history_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Withdrawhistoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            tds_deduct = double.parse(response[0].totalTdsDeduct!);
            _withdrawlist = response[0].data!;
            if (_withdrawlist.isEmpty) {
              nodata = false;
            } else {
              nodata = true;
            }
            setState(() {});
            break;
          case "false":
            nodata = false;
            setState(() {});
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
        iconTheme: const IconThemeData(color: Colors.black),
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
                  'Withdraw History'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            const CircleAvatar(
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
                        _buttonCardWidget(),
                        _firstCardWidget(),
                        Expanded(child: listview()),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                : Center(
                    heightFactor: double.infinity,
                    widthFactor: double.infinity,
                    child: Column(
                      children: [
                        Lottie.asset('assets/images/payal.json'),
                        Text(
                          ' No withdraw history found ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Looks like you haven't withdraw yet ",
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

  Widget _buttonCardWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Total TDS Deduct:' + tds_deduct.inRupeesFormat(),
          style: TextStyle(
              color: AppColor.bordercolor,
              fontWeight: FontWeight.w600,
              fontSize: 14),
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return TDSHistory(widget.balanceamount);
              },
            ));
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'TDS Deduct History',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColor.theamecolor,
                    fontSize: 12),
              )),
        ),
      ],
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
                    offset: const Offset(1, 1),
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
                          decoration: const InputDecoration(
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

                            for (var i in _withdrawlist) {
                              if (double.parse(i.deductAmount!)
                                      .toString()
                                      .contains(val) ||
                                  DateFormat('dd-MM-yyyy')
                                      .format(i.updatedOn!)
                                      .contains(val) ||
                                  (i.deductVia!
                                      .toLowerCase()
                                      .contains(val.toLowerCase()))) {
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
                    : const Text(
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
      itemCount: _isSearching ? _searchlist.length : _withdrawlist.length,
      itemBuilder: (context, index) {
        //  String withdraw = "";
        // String withdrawvia1 = _isSearching
        //     ? _searchlist[index].deductVia!
        //     : _withdrawlist[index].deductVia!;
        // if (withdrawvia1 == "1") {
        //   withdraw = _isSearching
        //       ? _searchlist[index].emiMonth! + " EMI"
        //       : _withdrawlist[index].emiMonth! + " EMI ";
        // } else if (withdrawvia1 == "2") {
        //   withdraw = "Account Transfer";
        // } else {
        //   withdraw = "Transferred In Wallet";
        // }
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Withdraw Amount : ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                        Text(
                          _isSearching
                              ? double.parse(_searchlist[index].deductAmount!)
                                  .inRupeesFormat()
                              : double.parse(_withdrawlist[index].deductAmount!)
                                  .inRupeesFormat(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Withdraw Date ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                        Text(
                          _isSearching
                              ? DateFormat('dd-MM-yyyy')
                                  .format(_searchlist[index].updatedOn!)
                              : DateFormat('dd-MM-yyyy')
                                  .format(_withdrawlist[index].updatedOn!),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      'Withdraw By/On : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Text(
                      _isSearching
                          ? _searchlist[index].deductVia!
                          : _withdrawlist[index].deductVia!,
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
