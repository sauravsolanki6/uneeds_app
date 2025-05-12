import 'dart:async';

import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/buy_gold_checkout_response.dart';
import 'package:UNGolds/network/response/product_list_response.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_checkout.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_on_emi_check.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_color.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/buy_gold_on_emi_response.dart';

String makingchargesgst = "0.0",
    productgst = "0.0",
    productweight = "",
    maxprice = "0.0",
    makingprice = "0.0";

double totalmakingst = 0.0, totalpricegst = 0.0, total = 0.0;

class BuyNow extends StatefulWidget {
  String productname, maxprice, productimage, productcarat, productId;
  ProductlistresponseDatum productlist;
  BuyNow(this.productname, this.maxprice, this.productimage, this.productcarat,
      this.productlist, this.productId);

  State createState() => BuyNowState();
}

class BuyNowState extends State<BuyNow> {
  @override
  void initState() {
    // TODO: implement initState
    ProgressDialog.showProgressDialog(context, "Loading");
    Timer(const Duration(seconds: 2), () {
      setvalue();
    });
    super.initState();
  }

  setvalue() {
    setState(() {
      if (widget.productlist.productGst == null) {
        productgst = "0.0";
      } else {
        productgst = widget.productlist.productGst!;
      }
      if (widget.productlist.makingGst == null) {
        makingchargesgst = "0.0";
      } else {
        makingchargesgst = widget.productlist.makingGst!;
      }

      productweight = widget.productlist.productInGram!;
      makingprice = widget.productlist.makingCharge!;
      makingprice = makingprice != "0"
          ? (double.parse(makingprice) * (double.parse(productweight)))
              .toString()
          : makingprice;
      maxprice = widget.maxprice;
      totalmakingst = makingprice != "0"
          ? (double.parse(makingprice) * double.parse(makingchargesgst)) / 100
          : 0.0;
      totalpricegst = (double.parse(maxprice) * double.parse(productgst)) / 100;
      total = double.parse(maxprice) +
          totalpricegst +
          totalmakingst +
          (makingprice != "0" ? double.parse(makingprice) : 0.0);
      secondrowname = [
        productweight,
        "-",
        " ${double.parse(maxprice).inRupeesFormat()} ",
      ];
      thirdrowname = [
        "-",
        "${productgst}",
        maxprice != "" && productgst != ""
            ? " ${totalpricegst.inRupeesFormat()} "
            : "${0.0.inRupeesFormat()}",
      ];
      forthrowname = [
        "-",
        "-",
        " ${double.parse(makingprice).inRupeesFormat()} ",
      ];
      fifthrowname = [
        "-",
        "$makingchargesgst",
        maxprice != "" && makingchargesgst != ""
            ? " ${totalmakingst.inRupeesFormat()} "
            : "${0.0.inRupeesFormat()}",
      ];
      sixrowname = [
        "-",
        "-",
        "${total.inRupeesFormat()}",
      ];
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstrowname.clear();
    secondrowname.clear();
    thirdrowname.clear();
    forthrowname.clear();
    fifthrowname.clear();
    sixrowname.clear();
    makingchargesgst = "0.0";
    productgst = "0.0";
    productweight = "";
    maxprice = "0.0";
    makingprice = "0.0";
    totalmakingst = 0.0;
    totalpricegst = 0.0;
    total = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Buy Now'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buynowbutton(),
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
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _imageWidget(height, width),
                  _productnameWidget(),
                  _priceWidget(),
                  Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
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
                      child: heading(height, width)),
                  _sevenWidget(),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _imageWidget(double height, double width) {
    return Container(
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
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColor.intoColor,
                    child: Text(
                      widget.productcarat,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ).marginOnly(right: 10))
            ],
          ).paddingOnly(top: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 250,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: NetworkUtility.base_api + widget.productimage,
                      errorWidget: (context, url, error) {
                        return Image.asset("assets/images/ic_launcher.png");
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ).marginOnly(top: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productnameWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              widget.productname + " (${productweight} gm) ",
              style: TextStyle(
                color: const Color.fromARGB(255, 49, 49, 49),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              // textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _priceWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            double.parse(widget.maxprice!).inRupeesFormat(),
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: AppColor.intoColor),
          ),
        ],
      ),
    );
  }

  Widget _divider(Color color) {
    return Divider(
      color: color,
      height: 1,
    );
  }

  List<String> firstrowname = [
    "Gram",
    "GST%",
    "Total ",
  ];

  List<String> secondrowname = [
    productweight,
    "-",
    "Rs. ${maxprice} ",
  ];
  List<String> thirdcolumnname = [
    "GST On Purchase Gold (${productgst}} %)",
  ];
  List<String> thirdrowname = [
    "-",
    "${productgst}",
    maxprice != "" && productgst != "" ? "Rs. ${totalpricegst} " : "Rs. 0.0",
  ];
  List<String> forthcolumnname = [
    "Making Charges",
  ];
  List<String> forthrowname = [
    "-",
    "-",
    "Rs. ${makingprice} ",
  ];
  List<String> fifthcolumnname = [
    "GST On Making Charge ($makingchargesgst %)",
  ];
  List<String> fifthrowname = [
    "-",
    "$makingchargesgst",
    maxprice != "" && makingchargesgst != ""
        ? "Rs. ${totalmakingst} "
        : "Rs. 0.0",
  ];
  List<String> sixcolumnname = [
    "Total",
  ];
  List<String> sixrowname = [
    "-",
    "-",
    "Rs. ${total}",
  ];

  Widget heading(double height, double width) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _buildCells(
                    6, height, width, "Component", AppColor.theamecolor, 14.0),
                Divider(
                  height: 2,
                  color: AppColor.bordercolor,
                ),
                _buildCells(6, height, width, widget.productname,
                    AppColor.greycolor, 12.0),
                _buildCells(
                    6,
                    height,
                    width,
                    "GST On Purchase Gold ($productgst %)",
                    AppColor.greycolor,
                    12.0),
                _buildCells(6, height, width, "Making Charges",
                    AppColor.greycolor, 12.0),
                _buildCells(
                    6,
                    height,
                    width,
                    "GST On Making Charge ($makingchargesgst %)",
                    AppColor.greycolor,
                    12.0),
                _buildCells(
                    6, height, width, "Total", AppColor.greycolor, 12.0),
              ]),
              VerticalDivider(
                color: AppColor.greycolor.withOpacity(0.2),
                thickness: 0.5,
              ),
              Flexible(
                child: RawScrollbar(
                  thumbColor: AppColor.bordercolor,
                  // isAlwaysShown: _isAlwaysShown,
                  thickness: 3,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRowsStart(1, height, width, firstrowname,
                            AppColor.theamecolor, 14),
                        _buildRows(
                            1, height, width, secondrowname, Colors.black, 12),
                        _buildRows(
                            1, height, width, thirdrowname, Colors.black, 12),
                        _buildRows(
                            1, height, width, forthrowname, Colors.black, 12),
                        _buildRows(
                            1, height, width, fifthrowname, Colors.black, 12),
                        _buildRows(
                            1, height, width, sixrowname, Colors.black, 12),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCells(int count, double height, double width, String columnname,
      Color color, double fontsize) {
    return Container(
      alignment: Alignment.center,
      width: width / 3,
      height: 40,
      decoration: BoxDecoration(
          border: BorderDirectional(
        bottom: BorderSide(color: AppColor.theamecolor, width: 0.3),
      )),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
          "${columnname}",
          key: Key(columnname),
          style: TextStyle(
              color: color, fontSize: fontsize, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<Widget> _buildCells1(int count, double height, double width,
      List<String> columnname, Color color, double fontsize) {
    return List.generate(
      count,
      (index) {
        return Container(
          alignment: Alignment.center,
          width: width / 3,
          height: 40,
          decoration: BoxDecoration(
              border: BorderDirectional(
            bottom: BorderSide(color: AppColor.bordercolor, width: 0.3),
          )),
          child: Text(
            "${columnname[index]}",
            key: Key(columnname[index]),
            style: TextStyle(
                color: color, fontSize: fontsize, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _buildRows(int count, double height, double width,
      List<String> rowname, Color color, double fontsize) {
    return Row(
      children: _buildCells1(3, height, width, rowname, color, fontsize),
    );
  }

  Widget _buildRowsStart(int count, double height, double width,
      List<String> rowname, Color color, double fontsize) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        children: _buildCells1(3, height, width, rowname, color, fontsize),
      ),
    );
  }

  Widget buynowbutton() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
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
      child: ButtonDesign(
          onPressed: () {
            NetworkCallForBuyGoldOnEMI(
                widget.productlist.productInGram!,
                0.0,
                0.0,
                0,
                0.0,
                (widget.productlist.productGst == null
                    ? "0.0"
                    : widget.productlist.productGst!),
                totalpricegst,
                (widget.productlist.makingCharge == null
                    ? "0.0"
                    : widget.productlist.makingCharge!),
                (widget.productlist.makingGst == null
                    ? "0.0"
                    : widget.productlist.makingGst!),
                "0",
                "0");
          },
          child: 'Buy Now'.buttoText()),
    );
  }

  Widget _sevenWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/new/hallmark.png',
                        width: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "BIS Hallmarked",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 68, 67, 67)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/fast.png',
                        width: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Fastest Delivery",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 68, 67, 67)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/new/guarantee.png',
                        width: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Purity Guarantee",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 68, 67, 67)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/new/100-per.png',
                        width: 50,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "100% Verify",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 68, 67, 67)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> NetworkCallForBuyGoldOnEMI(
      String gramqty,
      double bookingAmount,
      double emiAmount,
      int emimonth,
      double actualprocessingfees,
      String processingfeesgst,
      double totalprocessingfees,
      String makingcharge,
      String makinggst,
      String membersheeptype,
      String membersheepstatus) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().craetejosnforbuygoldcheckout(
        AppUtility.ID,
        widget.productId,
        context,
      );
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.buy_gold_checkout,
          NetworkUtility.buy_gold_checkout_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldcheckoutresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            String cardid = response[0].tblAddToCartId.toString();
            Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: 'checkout'),
                  builder: (context) {
                    return BuyGoldCheckOut(
                        widget.productname,
                        widget.productimage,
                        double.parse(productweight),
                        double.parse(maxprice),
                        totalpricegst,
                        double.parse(makingprice),
                        totalmakingst,
                        total,
                        widget.productId,
                        cardid,
                        productgst,
                        makingchargesgst);
                  },
                ));

            break;
          case "false":
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkCallForCheckOut',
          'Buy Gold Check Out', context);
    }
  }
}
