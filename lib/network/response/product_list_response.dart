// To parse this JSON data, do
//
//     final productlistresponse = productlistresponseFromJson(jsonString);

import 'dart:convert';

List<Productlistresponse> productlistresponseFromJson(String str) =>
    List<Productlistresponse>.from(
        json.decode(str).map((x) => Productlistresponse.fromJson(x)));

String productlistresponseToJson(List<Productlistresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productlistresponse {
  String? status;
  String? message;
  int? allcount;
  List<ProductlistresponseDatum>? data;

  Productlistresponse({
    this.status,
    this.message,
    this.data,
    this.allcount,
  });

  factory Productlistresponse.fromJson(Map<String, dynamic> json) =>
      Productlistresponse(
        status: json["status"],
        message: json["message"],
        allcount: json["all_product_count"],
        data: json["data"] == null
            ? []
            : List<ProductlistresponseDatum>.from(
                json["data"]!.map((x) => ProductlistresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "all_product_count": allcount,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductlistresponseDatum {
  String? id;
  dynamic objectId;
  String? categoryId;
  dynamic subCategoryId;
  dynamic materialId;
  dynamic brandId;
  dynamic singleBarcodeId;
  dynamic productId;
  dynamic aromaId;
  String? emiPresent;
  String? productGst;
  String? productName;
  String? productSlug;
  String? productType;
  String? productInGram;
  String? productPricePerGram;
  String? productPrice;
  String? makingCharge;
  String? makingGst;
  dynamic shortDescription;
  dynamic productDescription;
  dynamic productFeature;
  String? image;
  dynamic jpgImage;
  dynamic pngImage;
  dynamic jpegImage;
  dynamic multipleImages;
  dynamic singlePrice;
  String? maxPrice;
  dynamic gst;
  dynamic inStock;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic metaDescription;
  String? counter;
  dynamic hsnLongCode;
  dynamic hsnShortCode;
  String? isFeatured;
  String? visibility;
  String? status;
  String? isVariety;
  String? isDeleted;
  DateTime? createdOn;
  DateTime? updatedOn;
  String? imagePath;

  ProductlistresponseDatum({
    this.id,
    this.objectId,
    this.categoryId,
    this.subCategoryId,
    this.materialId,
    this.brandId,
    this.singleBarcodeId,
    this.productId,
    this.aromaId,
    this.emiPresent,
    this.productGst,
    this.productName,
    this.productSlug,
    this.productType,
    this.productInGram,
    this.productPricePerGram,
    this.productPrice,
    this.makingCharge,
    this.makingGst,
    this.shortDescription,
    this.productDescription,
    this.productFeature,
    this.image,
    this.jpgImage,
    this.pngImage,
    this.jpegImage,
    this.multipleImages,
    this.singlePrice,
    this.maxPrice,
    this.gst,
    this.inStock,
    this.metaTitle,
    this.metaKeyword,
    this.metaDescription,
    this.counter,
    this.hsnLongCode,
    this.hsnShortCode,
    this.isFeatured,
    this.visibility,
    this.status,
    this.isVariety,
    this.isDeleted,
    this.createdOn,
    this.updatedOn,
    this.imagePath,
  });

  factory ProductlistresponseDatum.fromJson(Map<String, dynamic> json) =>
      ProductlistresponseDatum(
        id: json["id"],
        objectId: json["object_id"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        materialId: json["material_id"],
        brandId: json["brand_id"],
        singleBarcodeId: json["single_barcode_id"],
        productId: json["product_id"],
        aromaId: json["aroma_id"],
        emiPresent: json["emi_present"],
        productGst: json["product_gst"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        productType: json["product_type"],
        productInGram: json["product_in_gram"],
        productPricePerGram: json["product_price_per_gram"],
        productPrice: json["product_price"],
        makingCharge: json["making_charge"],
        makingGst: json["making_gst"],
        shortDescription: json["short_description"],
        productDescription: json["product_description"],
        productFeature: json["product_feature"],
        image: json["image"],
        jpgImage: json["jpg_image"],
        pngImage: json["png_image"],
        jpegImage: json["jpeg_image"],
        multipleImages: json["multiple_images"],
        singlePrice: json["single_price"],
        maxPrice: json["max_price"],
        gst: json["gst"],
        inStock: json["in_stock"],
        metaTitle: json["meta_title"],
        metaKeyword: json["meta_keyword"],
        metaDescription: json["meta_description"],
        counter: json["counter"],
        hsnLongCode: json["hsn_long_code"],
        hsnShortCode: json["hsn_short_code"],
        isFeatured: json["is_featured"],
        visibility: json["visibility"],
        status: json["status"],
        isVariety: json["is_variety"],
        isDeleted: json["is_deleted"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        updatedOn: json["updated_on"] == null
            ? null
            : DateTime.parse(json["updated_on"]),
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object_id": objectId,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "material_id": materialId,
        "brand_id": brandId,
        "single_barcode_id": singleBarcodeId,
        "product_id": productId,
        "aroma_id": aromaId,
        "emi_present": emiPresent,
        "product_gst": productGst,
        "product_name": productName,
        "product_slug": productSlug,
        "product_type": productType,
        "product_in_gram": productInGram,
        "product_price_per_gram": productPricePerGram,
        "product_price": productPrice,
        "making_charge": makingCharge,
        "making_gst": makingGst,
        "short_description": shortDescription,
        "product_description": productDescription,
        "product_feature": productFeature,
        "image": image,
        "jpg_image": jpgImage,
        "png_image": pngImage,
        "jpeg_image": jpegImage,
        "multiple_images": multipleImages,
        "single_price": singlePrice,
        "max_price": maxPrice,
        "gst": gst,
        "in_stock": inStock,
        "meta_title": metaTitle,
        "meta_keyword": metaKeyword,
        "meta_description": metaDescription,
        "counter": counter,
        "hsn_long_code": hsnLongCode,
        "hsn_short_code": hsnShortCode,
        "is_featured": isFeatured,
        "visibility": visibility,
        "status": status,
        "is_variety": isVariety,
        "is_deleted": isDeleted,
        "created_on": createdOn?.toIso8601String(),
        "updated_on": updatedOn?.toIso8601String(),
        "image_path": imagePath,
      };
}
