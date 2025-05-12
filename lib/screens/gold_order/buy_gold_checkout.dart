import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/deliveryaddress.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/response/buy_gold_place_order_response.dart';
import 'package:UNGolds/screens/gold_order/buygoldonemipayment.dart';
import 'package:UNGolds/screens/login_page/forgotpassword_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_color.dart';
import '../../constant/progressdialog.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/get_address_response.dart';
import '../login_page/login_page.dart';
import '../profile_page/profile_details.dart';
import 'buy_gold_payment.dart';

bool isCheck = false, islogin = true, showbutton = true;
String address = "", MobileNumber = "", addressid = "";
bool _hasResumed = false;

class BuyGoldCheckOut extends StatefulWidget {
  String productname, productimg, cardId;
  double producyingrm,
      productprice,
      gstonpurchace,
      makingcharges,
      gstonmaking,
      totalammount;
  String productid, productgst, makingchargesgst;

  BuyGoldCheckOut(
      this.productname,
      this.productimg,
      this.producyingrm,
      this.productprice,
      this.gstonpurchace,
      this.makingcharges,
      this.gstonmaking,
      this.totalammount,
      this.productid,
      this.cardId,
      this.productgst,
      this.makingchargesgst);
  State createState() => BuyGoldCheckOutState();
}

class BuyGoldCheckOutState extends State<BuyGoldCheckOut>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Networkcallforgetaddress();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This method is called when the dependencies of the state change.
    // It will be called when the page is resumed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        if (!_hasResumed) {
          _handlePageResume();
          _hasResumed = true;
        }
      }
    });
  }

  void _handlePageResume() {
    // Your logic when the page resumes
    Networkcallforgetaddress();
    Networkcallforupdatecustomerid();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _hasResumed = false; // Reset the flag when leaving the page
    WidgetsBinding.instance.removeObserver(this);
    isCheck = false;
    showbutton = true;
  }

  Future<void> Networkcallforgetaddress() async {
    try {
      showbutton = true;
      setState(() {});
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.get_address,
          NetworkUtility.get_address_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Getaddressresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            islogin = true;
            addressid = response[0].data!.id!;
            address = response[0].data!.address! +
                " , " +
                response[0].data!.taluka! +
                " , " +
                response[0].data!.cityName! +
                " , " +
                response[0].data!.stateName! +
                "-" +
                response[0].data!.pincode! +
                " , " +
                response[0].data!.countryName!;
            MobileNumber = response[0].data!.mobile!;

            setState(() {});
            break;
          case "false":
            showbutton = false;
            islogin = false;
            setState(() {});
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforgetaddress', 'CheckOutEMI', context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Check Out'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showbutton ? _placeOrder() : _inactiveplaceOrder(),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              islogin ? _checkboxForAddress() : Container(),
              islogin ? Container() : showwarning(),
              // islogin
              //     ? Container()
              //     : Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Text(
              //           textAlign: TextAlign.left,
              //           'Please add address',
              //           style: TextDesign.errortext,
              //         ),
              //       ),
              _billWidget(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _billWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xffcbc7c7))),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                  color: Color.fromARGB(255, 221, 221, 221)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Your Order Summary',
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            _1st(),
            _divider(),
            _2nd(),
            _divider(),
            _3rd(),
            _divider(),
            _4th(),
            _divider(),
            _5th(),
            _divider(),
            _6th(),
            _divider(),
            _7th(),
            _divider(),
            _8th(),
            // _divider(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Color(0xffcbc7c7),
      thickness: 1,
    );
  }

  Widget _1st() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Product Name:',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            ' ${widget.productname.toString()}',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _2nd() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Product Image:',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Container(
              height: 40,
              width: 40,
              // decoration: BoxDecoration(
              //     image:
              //         DecorationImage(image: AssetImage(AppAssets.chairImage))),
              child: CachedNetworkImage(
                imageUrl: NetworkUtility.base_api + widget.productimg,
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
              )).marginOnly(top: 15),
        ],
      ),
    );
  }

  Widget _3rd() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Product in gram:',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            '${widget.producyingrm} (gm) ',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _4th() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Product Price:',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            widget.productprice!.inRupeesFormat(),
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _5th() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'GST On Purchase Gold (${widget.productgst} %):',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            widget.gstonpurchace.inRupeesFormat(),
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _6th() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Making Charges:',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            '${widget.makingcharges.inRupeesFormat()} ',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _7th() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'GST On Making Charge (${widget.makingchargesgst} %):',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            ' ${widget.gstonmaking.inRupeesFormat()}  ',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _8th() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Amount:',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            ' ${widget.totalammount.inRupeesFormat()} ',
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w700,
                fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget _checkboxForAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
                  color: Color.fromARGB(255, 221, 221, 221)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                          color: AppColor.bordercolor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 0.8,
                        child: Checkbox(
                            focusColor: AppColor.bordercolor,
                            shape: CircleBorder(),
                            value: isCheck,
                            checkColor: AppColor.theamecolor,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value!;
                              });
                              if (isCheck) {
                                showbutton = true;
                                setState(() {});
                              }
                            }),
                      ),
                      Text(
                        AppUtility.NAME,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColor.bordercolor),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, right: 8, bottom: 8),
                    child: Text(
                      address,
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColor.bordercolor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 8),
                    child: Text(
                      'Mobile Number: ${MobileNumber}',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColor.bordercolor,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            showbutton
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Please select address',
                      style: TextDesign.errortext,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget showwarning() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 221, 221, 221)),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfffff3cd)),
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0xfffff3cd)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  "To ensure a smooth delivery process, please click on the 'Add' button below to provide your complete address details. ",
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColor.bordercolor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' Please add address to continue? ',
                      style: TextStyle(
                          color: islogin
                              ? AppColor.bordercolor
                              : AppColor.errorcolor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(CupertinoIcons.arrow_right),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.buttoncolor,
                          borderRadius: BorderRadius.circular(8)),
                      child: InkWell(
                        onTap: () {
                          if (AppUtility.ID != "") {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Deliveryaddress();
                              },
                            )).then(
                              (value) {
                                Networkcallforgetaddress();
                                Networkcallforupdatecustomerid();
                              },
                            );
                          } else {
                            _hasResumed = false;
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  settings: RouteSettings(name: 'login'),
                                  builder: (context) {
                                    return LoginPage(true);
                                  },
                                )).then(
                              (value) {
                                Networkcallforgetaddress();
                                Networkcallforupdatecustomerid();
                              },
                            );
                          }
                        },
                        child: Text('Add',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12)),
                      ),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  Future<void> Networkcallforupdatecustomerid() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson()
          .createjsonupdatecustomerid(AppUtility.ID, widget.cardId, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.update_customer_id,
          NetworkUtility.update_customer_id_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Getaddressresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            break;
          case "false":
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _placeOrder() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
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
            if (isCheck) {
              showbutton = true;
              showConfirmationDialog();
            } else {
              showbutton = false;

              setState(() {});
            }
          },
          child: 'Place Order'.buttoText()),
    );
  }

  showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? You want place order?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              NetworkCallForBuyGoldOnEMI();
            },
            title: "Confirmation",
          );
        });
  }

  Widget _inactiveplaceOrder() {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColor.greycolor,
              borderRadius: BorderRadius.circular(5)),
          child: InkWell(
            onTap: () {
              isCheck = false;
              setState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Place Order',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 17)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> NetworkCallForBuyGoldOnEMI() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().craetejosnforbuygoldplaceorder(
          AppUtility.ID, widget.productid, context, widget.cardId, addressid);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.place_gold_order,
          NetworkUtility.place_gold_order_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Buygoldplaceorderresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            String tableinvoiceId = response[0].data!.tblInvoiceId!;
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return BuyGoldPayment(
                    double.parse(response[0].data!.amount!).toPrecision(2),
                    tableinvoiceId);
              },
            ));
            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkCallForPlaceOrder',
          'Buy Gold Check Out', context);
    }
  }
}
