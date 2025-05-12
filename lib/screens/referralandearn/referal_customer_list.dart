import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/referal_customer_list.dart';
import 'package:UNGolds/network/response/send_request_response.dart';
import 'package:UNGolds/screens/referralandearn/purchase_history.dart';
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
List<ReferalcustomerlistDatum> _searchlist = [];
List<ReferalcustomerlistDatum> _referallist = [];

class ReferalCustomerList extends StatefulWidget {
  State createState() => ReferalCustomerListState();
}

class ReferalCustomerListState extends State<ReferalCustomerList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforreferalcustomerlist();
  }

  Future<void> Networkcallforreferalcustomerlist() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.referal_customer_list,
          NetworkUtility.referal_customer_list_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Referalcustomerlistresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            _referallist = response[0].data!;
            if (_referallist.isEmpty) {
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
                  'Referral Customer List'.introTitleText(context),
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
                    child: Column(
                      children: [
                        Lottie.asset('assets/images/payal.json'),
                        Text(
                          ' No referral customer found ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Looks like you haven't referral customer ",
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

                            for (var i in _referallist) {
                              if (i.name!
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  i.purchaseGram!.contains(val.toLowerCase()) ||
                                  DateFormat('dd-MM-yyyy')
                                      .format(i.purchaseDate!)
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
      itemCount: _isSearching ? _searchlist.length : _referallist.length,
      itemBuilder: (context, index) {
        int totalEMIOrder = 0;
        totalEMIOrder = _isSearching
            ? _searchlist[index].totalOrder!
            : _referallist[index].totalOrder!;
        String abc =
            _isSearching ? _searchlist[index].name! : _referallist[index].name!;
        final abcd = abc.split(" ");
        String name = "";
        for (int i = 0; i < abcd.length; i++) {
          if (abcd[i] != "") {
            name = name + abcd[i].trim() + " ";
          }
        }

        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.bordercolor),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: _isSearching
                            ? (_searchlist[index].isActive!) == "1"
                                ? Colors.green
                                : Colors.red
                            : (_referallist[index].isActive!) == "1"
                                ? Colors.green
                                : Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          _isSearching
                              ? (_searchlist[index].isActive!) == "1"
                                  ? 'Active'
                                  : 'In-Active'
                              : (_referallist[index].isActive!) == "1"
                                  ? 'Active'
                                  : 'In-Active',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
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
                          'Purchase Gram:',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                        Text(
                          _isSearching
                              ? (_searchlist[index].purchaseGram!)
                              : (_referallist[index].purchaseGram!),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                      ],
                    ),
                    _isSearching
                        ? (_searchlist[index].isActive!) == "1"
                            ? Row(
                                children: [
                                  Text(
                                    'Purchase Date:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.bordercolor),
                                  ),
                                  Text(
                                    _isSearching
                                        ? DateFormat('dd-MM-yyyy').format(
                                            _searchlist[index].purchaseDate!)
                                        : DateFormat('dd-MM-yyyy').format(
                                            _referallist[index].purchaseDate!),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.bordercolor),
                                  ),
                                ],
                              )
                            : Container()
                        : (_referallist[index].isActive!) == "1"
                            ? Row(
                                children: [
                                  Text(
                                    'Purchase Date:',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.bordercolor),
                                  ),
                                  Text(
                                    _isSearching
                                        ? DateFormat('dd-MM-yyyy').format(
                                            _searchlist[index].purchaseDate!)
                                        : DateFormat('dd-MM-yyyy').format(
                                            _referallist[index].purchaseDate!),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.bordercolor),
                                  ),
                                ],
                              )
                            : Container()
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total EMI Order:',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                        Text(
                          totalEMIOrder! > 1 ? "1+" : totalEMIOrder.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.bordercolor),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PurchaseHistory(_isSearching
                                ? _searchlist[index].id!
                                : _referallist[index].id!);
                          },
                        ));
                      },
                      child: Text(
                        totalEMIOrder! > 1 ? "Show Order" : "",
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                            color: AppColor.theamecolor),
                      ),
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
