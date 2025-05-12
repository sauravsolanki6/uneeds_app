import 'dart:io';

import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/main.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/emi_invoice_response.dart';
import 'package:UNGolds/network/response/my_order_invoice_response.dart';
import 'package:UNGolds/network/response/my_order_list_without_emi.dart';
import 'package:UNGolds/screens/gold_order/buy_gold.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_checkout.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_on_emi.dart';
import 'package:UNGolds/screens/gold_order/buy_now.dart';
import 'package:UNGolds/screens/gold_order/myorderwihoutemi.dart';
import 'package:UNGolds/screens/gold_order/myorderwithemi.dart';
import 'package:UNGolds/screens/gold_order/repayment_schedule.dart';
import 'package:UNGolds/screens/gold_order/pay_emi_payment.dart';
import 'package:UNGolds/screens/gold_order/track_emi_order.dart';
import 'package:UNGolds/screens/gold_order/track_my_order.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import '../../annimation/blinking_annimation.dart';
import '../../constant/drawer_design.dart';
import '../../network/response/my_order_list_response.dart';
import '../bottom_navigation_bar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyGoldOrder extends StatefulWidget {
  State createState() => MyGoldOrderState();
}

bool visibleProductswithemi = true, visiblelive = true;
List<Tab> _tabs = [];
TabController? _tabController;

class MyGoldOrderState extends State<MyGoldOrder>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialindex = 0;
    _tabs = [const Tab(text: 'Products With EMI'), const Tab(text: 'Products')];
    //  NetworkcallforOrderlistwithemi();
    _tabController = TabController(vsync: this, length: _tabs.length);

    _tabController?.addListener(() {
      initialindex = _tabController!.index;
    });
  }

  bool nodatawithemi = true, nodata = true;

  int initialindex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodatawithemi = false;
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        initialIndex: initialindex,
        child: Scaffold(
          endDrawer: CommonDrawer(),
          backgroundColor: Colors.white,
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
                        'My Gold / Pay EMI'.introTitleText(context),
                      ],
                    ).marginOnly(top: 10),
                  ),
                ],
              ),
              bottom: TabBar(
                // isScrollable: true,
                indicatorColor: AppColor.theamecolor,
                indicatorPadding: EdgeInsets.only(left: 20, right: 20),
                labelColor: AppColor.theamecolor,
                unselectedLabelColor: AppColor.bordercolor,
                tabs: _tabs,
              )),
          body: TabBarView(children: [
            Myorderwithemi(),
            Myorderwithoutemi(),
          ]),
        ));
  }
}
