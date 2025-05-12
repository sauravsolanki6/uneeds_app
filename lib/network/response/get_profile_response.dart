// // To parse this JSON data, do
// //
// //     final getprofileresponse = getprofileresponseFromJson(jsonString);

// import 'dart:convert';

// List<Getprofileresponse> getprofileresponseFromJson(String str) =>
//     List<Getprofileresponse>.from(
//         json.decode(str).map((x) => Getprofileresponse.fromJson(x)));

// String getprofileresponseToJson(List<Getprofileresponse> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Getprofileresponse {
//   String? status;
//   String? message;
//   Data? data;

//   Getprofileresponse({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory Getprofileresponse.fromJson(Map<String, dynamic> json) =>
//       Getprofileresponse(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   String? id;
//   String? name;
//   String? firstName;
//   String? lastName;
//   String? mobile;
//   String? email;
//   String? password;
//   String? address;
//   String? isType;
//   dynamic salt;
//   String? isApproved;
//   DateTime? lastLogin;
//   dynamic referralCode;
//   dynamic referralCustomerId;
//   String? kyc;
//   String? ownReferralCode;
//   String? membershipStatus;
//   String? country;
//   String? state;
//   dynamic district;
//   String? taluka;
//   String? pincode;
//   dynamic birthDate;
//   dynamic annivarsary;
//   String? image;
//   dynamic aadharNo;
//   dynamic panNo;
//   dynamic bankName;
//   dynamic branchName;
//   dynamic accountNumber;
//   dynamic accountType;
//   dynamic ifscCode;
//   dynamic micrNumber;
//   String? firstLogin;
//   String? isAutoDeduct;
//   DateTime? createdOn;
//   String? isDeleted;
//   String? status;
//   DateTime? updatedOn;
//   String? sname;
//   dynamic cname;
//   String? imagePath;
//   dynamic gst_no;

//   Data({
//     this.id,
//     this.name,
//     this.firstName,
//     this.lastName,
//     this.mobile,
//     this.email,
//     this.password,
//     this.address,
//     this.isType,
//     this.salt,
//     this.isApproved,
//     this.lastLogin,
//     this.referralCode,
//     this.referralCustomerId,
//     this.kyc,
//     this.ownReferralCode,
//     this.membershipStatus,
//     this.country,
//     this.state,
//     this.district,
//     this.taluka,
//     this.pincode,
//     this.birthDate,
//     this.annivarsary,
//     this.image,
//     this.aadharNo,
//     this.panNo,
//     this.bankName,
//     this.branchName,
//     this.accountNumber,
//     this.accountType,
//     this.ifscCode,
//     this.micrNumber,
//     this.firstLogin,
//     this.isAutoDeduct,
//     this.createdOn,
//     this.isDeleted,
//     this.status,
//     this.updatedOn,
//     this.sname,
//     this.cname,
//     this.imagePath,
//     this.gst_no,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         name: json["name"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         mobile: json["mobile"],
//         email: json["email"],
//         password: json["password"],
//         address: json["address"],
//         isType: json["is_type"],
//         salt: json["salt"],
//         isApproved: json["is_approved"],
//         lastLogin: json["last_login"] == null
//             ? null
//             : DateTime.parse(json["last_login"]),
//         referralCode: json["referral_code"],
//         referralCustomerId: json["referral_customer_id"],
//         kyc: json["kyc"],
//         ownReferralCode: json["own_referral_code"],
//         membershipStatus: json["membership_status"],
//         country: json["country"],
//         state: json["state"],
//         district: json["district"],
//         taluka: json["taluka"],
//         pincode: json["pincode"],
//         birthDate: json["birth_date"],
//         annivarsary: json["annivarsary"],
//         image: json["image"],
//         aadharNo: json["aadhar_no"],
//         panNo: json["pan_no"],
//         bankName: json["bank_name"],
//         branchName: json["branch_name"],
//         accountNumber: json["account_number"],
//         accountType: json["account_type"],
//         ifscCode: json["ifsc_code"],
//         micrNumber: json["micr_number"],
//         firstLogin: json["first_login"],
//         isAutoDeduct: json["is_auto_deduct"],
//         gst_no: json["gst_no"],
//         createdOn: json["created_on"] == null
//             ? null
//             : DateTime.parse(json["created_on"]),
//         isDeleted: json["is_deleted"],
//         status: json["status"],
//         updatedOn: json["updated_on"] == null
//             ? null
//             : DateTime.parse(json["updated_on"]),
//         sname: json["sname"],
//         cname: json["cname"],
//         imagePath: json["image_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "first_name": firstName,
//         "last_name": lastName,
//         "mobile": mobile,
//         "email": email,
//         "password": password,
//         "address": address,
//         "is_type": isType,
//         "salt": salt,
//         "is_approved": isApproved,
//         "last_login": lastLogin?.toIso8601String(),
//         "referral_code": referralCode,
//         "referral_customer_id": referralCustomerId,
//         "kyc": kyc,
//         "own_referral_code": ownReferralCode,
//         "membership_status": membershipStatus,
//         "country": country,
//         "state": state,
//         "district": district,
//         "taluka": taluka,
//         "pincode": pincode,
//         "birth_date": birthDate,
//         "annivarsary": annivarsary,
//         "image": image,
//         "aadhar_no": aadharNo,
//         "pan_no": panNo,
//         "bank_name": bankName,
//         "branch_name": branchName,
//         "account_number": accountNumber,
//         "account_type": accountType,
//         "ifsc_code": ifscCode,
//         "micr_number": micrNumber,
//         "first_login": firstLogin,
//         "is_auto_deduct": isAutoDeduct,
//         "created_on": createdOn?.toIso8601String(),
//         "is_deleted": isDeleted,
//         "status": status,
//         "updated_on": updatedOn?.toIso8601String(),
//         "sname": sname,
//         "cname": cname,
//         "image_path": imagePath,
//         "gst_no": gst_no,
//       };
// }
// To parse this JSON data, do
//
//     final getprofileresponse = getprofileresponseFromJson(jsonString);

import 'dart:convert';

List<Getprofileresponse> getprofileresponseFromJson(String str) =>
    List<Getprofileresponse>.from(
        json.decode(str).map((x) => Getprofileresponse.fromJson(x)));

String getprofileresponseToJson(List<Getprofileresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getprofileresponse {
  String? status;
  String? message;
  List<Datum>? data;

  Getprofileresponse({
    this.status,
    this.message,
    this.data,
  });

  factory Getprofileresponse.fromJson(Map<String, dynamic> json) =>
      Getprofileresponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? name;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? password;
  String? address;
  String? isType;
  dynamic salt;
  String? isApproved;
  DateTime? lastLogin;
  String? referralCode;
  String? referralCustomerId;
  String? kyc;
  String? ownReferralCode;
  String? membershipStatus;
  String? country;
  String? state;
  String? district;
  String? taluka;
  String? pincode;
  String? birthDate;
  String? annivarsary;
  String? image;
  String? aadharNo;
  String? panNo;
  dynamic bankName;
  dynamic branchName;
  dynamic accountNumber;
  dynamic accountType;
  dynamic ifscCode;
  dynamic micrNumber;
  String? gstNo;
  String? firstLogin;
  String? isAutoDeduct;
  String? walletBalance;
  String? uneedsWalletId;
  String? nomineeName;
  String? nomineeContact;
  String? nomineeAge;
  String? relationWithCustomer;
  String? nomineeAddress;
  DateTime? createdOn;
  String? isDeleted;
  String? status;
  DateTime? updatedOn;
  String? sname;
  String? cname;
  String? image_path;
  Datum({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.password,
    this.address,
    this.isType,
    this.salt,
    this.isApproved,
    this.lastLogin,
    this.referralCode,
    this.referralCustomerId,
    this.kyc,
    this.ownReferralCode,
    this.membershipStatus,
    this.country,
    this.state,
    this.district,
    this.taluka,
    this.pincode,
    this.birthDate,
    this.annivarsary,
    this.image,
    this.aadharNo,
    this.panNo,
    this.bankName,
    this.branchName,
    this.accountNumber,
    this.accountType,
    this.ifscCode,
    this.micrNumber,
    this.gstNo,
    this.firstLogin,
    this.isAutoDeduct,
    this.walletBalance,
    this.uneedsWalletId,
    this.nomineeName,
    this.nomineeContact,
    this.nomineeAge,
    this.relationWithCustomer,
    this.nomineeAddress,
    this.createdOn,
    this.isDeleted,
    this.status,
    this.updatedOn,
    this.sname,
    this.cname,
    this.image_path,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        isType: json["is_type"],
        salt: json["salt"],
        isApproved: json["is_approved"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        referralCode: json["referral_code"],
        referralCustomerId: json["referral_customer_id"],
        kyc: json["kyc"],
        ownReferralCode: json["own_referral_code"],
        membershipStatus: json["membership_status"],
        country: json["country"],
        state: json["state"],
        district: json["district"],
        taluka: json["taluka"],
        pincode: json["pincode"],
        birthDate: json["birth_date"],
        annivarsary: json["annivarsary"],
        image: json["image"],
        aadharNo: json["aadhar_no"],
        panNo: json["pan_no"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
        accountNumber: json["account_number"],
        accountType: json["account_type"],
        ifscCode: json["ifsc_code"],
        micrNumber: json["micr_number"],
        gstNo: json["gst_no"],
        firstLogin: json["first_login"],
        isAutoDeduct: json["is_auto_deduct"],
        walletBalance: json["wallet_balance"],
        uneedsWalletId: json["uneeds_wallet_id"],
        nomineeName: json["nominee_name"],
        nomineeContact: json["nominee_contact"],
        nomineeAge: json["nominee_age"],
        relationWithCustomer: json["relation_with_customer"],
        nomineeAddress: json["nominee_address"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        isDeleted: json["is_deleted"],
        status: json["status"],
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        sname: json["sname"],
        cname: json["cname"],
        image_path: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "password": password,
        "address": address,
        "is_type": isType,
        "salt": salt,
        "is_approved": isApproved,
        "last_login": lastLogin?.toIso8601String(),
        "referral_code": referralCode,
        "referral_customer_id": referralCustomerId,
        "kyc": kyc,
        "own_referral_code": ownReferralCode,
        "membership_status": membershipStatus,
        "country": country,
        "state": state,
        "district": district,
        "taluka": taluka,
        "pincode": pincode,
        "birth_date": birthDate,
        "annivarsary": annivarsary,
        "image": image,
        "aadhar_no": aadharNo,
        "pan_no": panNo,
        "bank_name": bankName,
        "branch_name": branchName,
        "account_number": accountNumber,
        "account_type": accountType,
        "ifsc_code": ifscCode,
        "micr_number": micrNumber,
        "gst_no": gstNo,
        "first_login": firstLogin,
        "is_auto_deduct": isAutoDeduct,
        "wallet_balance": walletBalance,
        "uneeds_wallet_id": uneedsWalletId,
        "nominee_name": nomineeName,
        "nominee_contact": nomineeContact,
        "nominee_age": nomineeAge,
        "relation_with_customer": relationWithCustomer,
        "nominee_address": nomineeAddress,
        "created_on": createdOn?.toIso8601String(),
        "is_deleted": isDeleted,
        "status": status,
        "updated_on": updatedOn?.toIso8601String(),
        "sname": sname,
        "cname": cname,
        "image_path": image_path
      };
}
