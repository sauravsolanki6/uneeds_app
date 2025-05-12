import 'dart:io';

import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/get_kyc_response.dart';
import 'package:UNGolds/screens/bankdetailpage/kyc_detail_page.dart';
import 'package:UNGolds/screens/gold_order/buy_gold.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_on_emi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_color.dart';
import '../../constant/camerabuttonpage.dart';
import '../../constant/textdesign.dart';

class KYCDoneStepper extends StatefulWidget {
  String kycstatus;

  KYCDoneStepper(this.kycstatus);

  @override
  State<KYCDoneStepper> createState() => _KYCDoneStepperState();
}

class _KYCDoneStepperState extends State<KYCDoneStepper> {
  int _index = 0;
  bool isCheck = false;
  bool isUploadDocument = true, isKYCForm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforgetkycdetail();
  }

  Future<void> Networkcallforgetkycdetail() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(NetworkUtility.get_kyc,
          NetworkUtility.get_kyc_api, createjson, context);
      if (list != null) {
        Navigator.pop(context);
        List<Getkycresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            aadharfrontphoto = response[0].data!.aadharFront!;
            aadharbackphoto = response[0].data!.aadharBack!;
            pancardphoto = response[0].data!.panFront!;
            passportphoto = response[0].data!.passportSize!;
            setState(() {});
            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        // SnackBarDesign("Something went wrong!", context, AppColor.errorcolor,
        //     Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforgetkycdetail()', 'KYC Done', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // primarySwatch: AppColor.greencolor,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: AppColor.greencolor)),
      child: Stepper(
          elevation: 0.0,
          type: StepperType.vertical,
          currentStep: _index,
          controlsBuilder: (context, details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: details.onStepContinue,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColor.theamecolor,
                        borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return BuyGoldOnEMI();
                          },
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy Gold',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          steps: <Step>[
            Step(
              title: const Text(
                'Uploaded Document',
              ),
              isActive: isUploadDocument,
              label: Text(
                'Upload Document',
                style: TextStyle(
                    color: isUploadDocument
                        ? AppColor.greencolor
                        : AppColor.greycolor,
                    fontSize: 12),
              ),
              content: Container(
                  alignment: Alignment.centerLeft, child: stepUploadDocument()),
            ),
            Step(
              title: const Text(
                'KYC Agreement',
              ),
              isActive: isUploadDocument,
              label: Text(
                'KYC Agreement',
                style: TextStyle(
                    color: isUploadDocument
                        ? AppColor.greencolor
                        : AppColor.greycolor,
                    fontSize: 12),
              ),
              content: Container(
                  alignment: Alignment.centerLeft, child: Container()),
            ),
          ]),
    );
  }

  String aadharfrontphoto = "",
      aadharbackphoto = "",
      pancardphoto = "",
      passportphoto = "";
  Widget _FirstCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aadhaar Front',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            height: 120,
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  aadharfrontphoto != ""
                      ? _aadharfrontimageCardWidget(
                          NetworkUtility.base_api + aadharfrontphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _aadharfrontimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          // width: 50,
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(image: NetworkImage(imag))),
        ),
      ],
    );
  }

  Widget _SecondCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aadhaar Back',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Container(
            height: 120,
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  aadharbackphoto != ""
                      ? _aadharbackimageCardWidget(
                          NetworkUtility.base_api + aadharbackphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _aadharbackimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(imag), fit: BoxFit.contain)),
        ),
      ],
    );
  }

  Widget _ThirdCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pan Card',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Container(
            height: 120,
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pancardphoto != ""
                      ? _pancardimageCardWidget(
                          NetworkUtility.base_api + pancardphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _pancardimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(imag), fit: BoxFit.contain)),
        ),
      ],
    );
  }

  Widget _FourthCardWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passport Size Photo',
          style: TextStyle(
              color: AppColor.lablecolor,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        const SizedBox(
          height: 3,
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
              // gradient: LinearGradient(colors: List.filled(length, fill)),
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(3))),
          child: Container(
            height: 120,
            child: DottedBorder(
              color: AppColor.bordercolor,
              strokeWidth: 1,
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  passportphoto != ""
                      ? _passportimageCardWidget(
                          NetworkUtility.base_api + passportphoto)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _passportimageCardWidget(String imag) {
    return Stack(
      children: [
        Container(
          height: 110,
          decoration: BoxDecoration(
              // shape: BoxShape.rectangle,
              border: Border.all(width: 0, color: Colors.white),
              image: DecorationImage(image: NetworkImage(imag))),
        ),
      ],
    );
  }

  Widget stepUploadDocument() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
              color: widget.kycstatus == "3"
                  ? Color(0xffd4edda)
                  : Colors.green.withOpacity(0.7)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.kycstatus == "3"
                  ? 'Your document has been successfully submitted. While we verify it, feel free to proceed with your gold purchase. '
                  : "KYC Verified! You can now make secure gold purchases with confidence.",
              style: TextStyle(
                  color: kycstatus == "3" ? AppColor.bordercolor : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        _FirstCardWidget(),
        SizedBox(
          height: 3,
        ),
        _SecondCardWidget(),
        SizedBox(
          height: 3,
        ),
        _ThirdCardWidget(),
        SizedBox(
          height: 3,
        ),
        _FourthCardWidget(),
        SizedBox(
          height: 3,
        ),
      ],
    );
  }
}
