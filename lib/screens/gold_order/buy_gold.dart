import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/network/response/product_list_response.dart';
import 'package:UNGolds/screens/gold_order/buy_now.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_color.dart';
import '../../constant/login_drawer.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/textdesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/get_fees_response.dart';
import 'buy_gold_checkout.dart';

bool _isSearching = false,
    nodata = true,
    _isFirstloading = false,
    _hashnextpage = true,
    isloadingmore = false;
List<ProductlistresponseDatum> _searchList = [];
List<ProductlistresponseDatum> productlist = [];
List<ProductlistresponseDatum> originalproductlist = [];
int page = 0, limit = 10;
late ScrollController _controller;
int AllProductCount = 0;
String selectedSortOption = 'All';

class BuyGold extends StatefulWidget {
  State createState() => BuyGoldState();
}

class BuyGoldState extends State<BuyGold> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = 0;
    nodata = true;
    _searchList.clear();
    productlist.clear();
    _isSearching = false;

    _isFirstloading = false;
    _hashnextpage = true;
    isloadingmore = false;

    Networkcallforproductlist(page, true);
    _controller = ScrollController()..addListener(loadMore);
  }

  Future<void> Networkcallforproductlist(int index, bool showprogress) async {
    try {
      setState(() {
        _isFirstloading = true;
        selectedSortOption = "All";
      });
      if (showprogress) ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforproductlist(index, context, limit, "all", "");
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.product_list,
          NetworkUtility.product_list_api,
          createjson,
          context);
      if (list != null) {
        if (showprogress) Navigator.pop(context);
        setState(() {
          _isFirstloading = false;
        });
        List<Productlistresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            productlist = response[0].data!;
            originalproductlist = response[0].data!;
            AllProductCount = response[0].allcount!;
            if (productlist.isEmpty) {
              nodata = false;
            } else {
              nodata = true;
              //  applySort();
            }
            setState(() {});
            break;
          case "false":
            setState(() {
              isloadingmore = false;
            });

            break;
        }
      } else {
        setState(() {
          isloadingmore = false;
        });
        if (showprogress) Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforproductlist', "Buy Gold ", context);
    }
  }

  loadMore() async {
    if (_hashnextpage == true &&
        _isFirstloading == false &&
        isloadingmore == false) {
      setState(() {
        isloadingmore = true;
      });
      page = page + 10;
      try {
        // ProgressDialog.showProgressDialog(context, "Loading");
        String createjson = CreateJson()
            .createjsonforproductlist(page, context, limit, "all", "");
        Networkcall networkcall = Networkcall();
        List<Object?>? list = await networkcall.postMethod(
            NetworkUtility.product_list,
            NetworkUtility.product_list_api,
            createjson,
            context);
        if (list != null) {
          List<Productlistresponse> response = List.from(list!);
          String status = response[0].status.toString();
          switch (status) {
            case "true":
              List<ProductlistresponseDatum> productlist1 = response[0].data!;
              if (productlist1.isEmpty) {
                _hashnextpage = false;
                setState(() {});
              } else {
                productlist.addAll(productlist1);
                originalproductlist.addAll(productlist1);
                setState(() {});
                // if (selectedSortOption == 'Low to High') {
                //   sortByPriceLowToHigh();
                // } else if (selectedSortOption == 'High to Low') {
                //   sortByPriceHighToLow();
                // }
                applySort();
              }

              break;
            case "false":
              _hashnextpage = false;
              setState(() {});
              // SnackBarDesign('No more products available', context,
              //     AppColor.sucesscolor, Colors.white);
              break;
          }
        } else {}
        setState(() {
          isloadingmore = false;
        });
      } catch (e) {
        setState(() {
          isloadingmore = false;
        });

        PrintMessage.printmessage(
            e.toString(), 'Load More', "Buy Gold ", context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodata = true;
    _searchList.clear();
    productlist.clear();
    originalproductlist.clear();
    selectedSortOption = "All";
    _isSearching = false;
    _isFirstloading = false;
    _hashnextpage = true;
    isloadingmore = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      endDrawer: AppUtility.ID != "" ? CommonDrawer() : LoginDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: AppColor.bgcolor.withOpacity(0.2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Buy Gold'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      body: nodata
          ? Container(
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
                filter:
                    const ColorFilter.mode(Colors.white, BlendMode.softLight),
                child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(
                              'Products - ${AllProductCount} items',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.only(left: 5, right: 10),
                            decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedSortOption,
                                  items: [
                                    DropdownMenuItem(
                                        value: 'All',
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.bordercolor),
                                        )),
                                    DropdownMenuItem(
                                        value: 'Low to High',
                                        child: Text(
                                          'Low to High',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.bordercolor),
                                        )),
                                    DropdownMenuItem(
                                        value: 'High to Low',
                                        child: Text(
                                          'High to Low',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.bordercolor),
                                        )),
                                  ],
                                  onChanged: (value) {
                                    selectedSortOption = value!;

                                    applySort();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _firstCardWidget(),
                    _isSearching
                        ? _searchList.isEmpty
                            ? Column(
                                children: [
                                  Center(
                                    child: Lottie.asset(
                                        'assets/images/payal.json',
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2) -
                                            200),
                                  ),
                                  Text(
                                    ' No product found ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColor.darkcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            : Expanded(child: maingrid())
                        : Expanded(child: maingrid()),
                    SizedBox(
                      height: 5,
                    ),
                    isloadingmore
                        ? Padding(
                            padding: EdgeInsets.all(8),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Container(),
                    SizedBox(
                      height: 5,
                    ),
                    _hashnextpage
                        ? Container()
                        : Text(
                            'You have fetched all product',
                            style: TextDesign.hinttext,
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            )
          : Center(
              heightFactor: double.infinity,
              widthFactor: double.infinity,
              child: Lottie.asset('assets/images/payal.json'),
            ),
    );
  }

  void applySort() {
    // Apply the appropriate sort based on the selected option
    if (selectedSortOption == 'Low to High') {
      sortByPriceLowToHigh();
    } else if (selectedSortOption == 'High to Low') {
      sortByPriceHighToLow();
    } else {
      // Restore the original list if 'All' is selected
      productlist = List.from(originalproductlist);
    }
    setState(() {});
  }

  void sortByPriceLowToHigh() {
    setState(() {
      productlist.sort((a, b) {
        double priceA = double.tryParse(a.maxPrice!) ?? 0.0;
        double priceB = double.tryParse(b.maxPrice!) ?? 0.0;
        return priceA.compareTo(priceB);
      });
    });
  }

  void sortByPriceHighToLow() {
    setState(() {
      // productlist.sort((a, b) => b.maxPrice!.compareTo(a.maxPrice!));
      productlist.sort((a, b) {
        double priceA = double.tryParse(a.maxPrice!) ?? 0.0;
        double priceB = double.tryParse(b.maxPrice!) ?? 0.0;
        return priceB.compareTo(priceA);
      });
    });
  }

  Widget _firstCardWidget() {
    return Container(
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
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 15),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
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
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Search here...',
                          hintStyle: TextDesign.hinttext),
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.5,
                          color: Colors.black),
                      onChanged: (val) {
                        _searchList.clear();

                        for (var i in productlist) {
                          if (i.productName!
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              i.maxPrice!.contains(val)) {
                            _searchList.add(i);
                            setState(() {
                              _searchList;
                            });
                          } else {
                            setState(() {
                              _searchList;
                            });
                          }
                        }
                      },
                    ),
                  )
                : Text(
                    'Search Products...',
                    style: TextDesign.hinttext,
                  ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    _searchList.clear();
                  });
                },
                icon: Icon(
                  _isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search,
                  // color: AppColor.intoColor,
                )),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget maingrid() {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          page = 0;
          nodata = true;
          _searchList.clear();
          productlist.clear();
          _isSearching = false;

          _isFirstloading = false;
          _hashnextpage = true;
          isloadingmore = false;
          setState(() {});
          Networkcallforproductlist(0, false);
        });
      },
      child: GridView.builder(
        controller: _controller,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: _isSearching ? _searchList.length : productlist.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.height / 890,
        ),
        itemBuilder: (context, index) {
          return _gridview(index);
        },
      ),
    );
  }

  Widget _gridview(int index) {
    String productcarat = "";
    if (_isSearching
        ? _searchList[index].productType == "0"
        : productlist[index].productType == "0") {
      productcarat = "22k";
    } else if (_isSearching
        ? _searchList[index].productType == "1"
        : productlist[index].productType == "1") {
      productcarat = "24k";
    } else if (_isSearching
        ? _searchList[index].productType == "2"
        : productlist[index].productType == "2") {
      productcarat = "18k";
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BuyNow(
              _isSearching
                  ? _searchList[index].productName!
                  : productlist[index].productName!,
              _isSearching
                  ? _searchList[index].maxPrice!
                  : productlist[index].maxPrice!,
              _isSearching
                  ? _searchList[index].imagePath!
                  : productlist[index].imagePath!,
              productcarat,
              _isSearching ? _searchList[index] : productlist[index],
              _isSearching ? _searchList[index].id! : productlist[index].id!,
            );
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15))),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.bgcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: _isSearching
                            ? NetworkUtility.base_api +
                                _searchList[index].imagePath!
                            : NetworkUtility.base_api +
                                productlist[index].imagePath!,
                        errorWidget: (context, url, error) {
                          return Image.asset("assets/images/ic_launcher.png");
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 140,
                            // width: 90,
                            decoration: BoxDecoration(
                              color: AppColor.bgcolor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider,
                              ),
                            ),
                          );
                        },
                        height: 110,
                        // width: 90,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColor.intoColor,
                            child: productcarat.gramText(),
                          ).marginOnly(right: 8),
                        )
                      ],
                    ),
                  ],
                ),
              ).paddingOnly(top: 5),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      _isSearching
                          ? _searchList[index].productName.toString() +
                              " (${_searchList[index].productInGram.toString()})" +
                              '\n'
                          : productlist[index].productName.toString() +
                              " (${productlist[index].productInGram.toString()})" +
                              '\n',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.greycolor, fontSize: 12),
                    ),
                  )
                ],
              ).marginOnly(top: 2, left: 15),
              Row(
                children: [
                  Text(
                    _isSearching
                        ? double.parse(_searchList[index].maxPrice!)
                            .inRupeesFormat()
                        : double.parse(productlist[index].maxPrice!)
                            .inRupeesFormat(),
                    style: TextStyle(
                        color: Color(0xffF2A666),
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  )
                ],
              ).marginOnly(left: 15, top: 3, bottom: 3),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return BuyNow(
                            _isSearching
                                ? _searchList[index].productName!
                                : productlist[index].productName!,
                            _isSearching
                                ? _searchList[index].maxPrice!
                                : productlist[index].maxPrice!,
                            _isSearching
                                ? _searchList[index].imagePath!
                                : productlist[index].imagePath!,
                            productcarat,
                            _isSearching
                                ? _searchList[index]
                                : productlist[index],
                            _isSearching
                                ? _searchList[index].id!
                                : productlist[index].id!);
                      },
                    ));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.theamecolor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Buy Now',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColor.bgcolor)),
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
}
