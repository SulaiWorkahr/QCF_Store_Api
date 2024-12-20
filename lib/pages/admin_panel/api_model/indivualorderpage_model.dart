// To parse this JSON data, do
//
//     final individualorderdetailsmodel = individualorderdetailsmodelFromJson(jsonString);

import 'dart:convert';

Individualorderdetailsmodel individualorderdetailsmodelFromJson(String str) =>
    Individualorderdetailsmodel.fromJson(json.decode(str));

String individualorderdetailsmodelToJson(Individualorderdetailsmodel data) =>
    json.encode(data.toJson());

class Individualorderdetailsmodel {
  String status;
  List<IndivualOrders> list;
  String code;
  String message;

  Individualorderdetailsmodel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory Individualorderdetailsmodel.fromJson(Map<String, dynamic> json) =>
      Individualorderdetailsmodel(
        status: json["status"],
        list: List<IndivualOrders>.from(
            json["list"].map((x) => IndivualOrders.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class IndivualOrders {
  String? invoiceNumber;
  int? code;
  int? totalProduct;
  String? totalPrice;
  String? deliveryCharges;
  String? orderStatus;
  String? paymentMethod;
  int? prepareMin;
  DateTime createdDate;
  int? userId;
  String? deliveryPartnerId;
  String? customerName;
  String? customerMobile;
  String? deliveryBoyName;
  String? deliveryBoyMobile;
  List<Item> items;
  CustomerAddress customerAddress;
  StoreAddress storeAddress;

  IndivualOrders({
    this.invoiceNumber,
    this.code,
    this.totalProduct,
    this.totalPrice,
    this.deliveryCharges,
    this.orderStatus,
    this.paymentMethod,
    this.prepareMin,
    required this.createdDate,
    this.userId,
    this.deliveryPartnerId,
    this.customerName,
    this.customerMobile,
    this.deliveryBoyName,
    this.deliveryBoyMobile,
    required this.items,
    required this.customerAddress,
    required this.storeAddress,
  });

  factory IndivualOrders.fromJson(Map<String, dynamic> json) => IndivualOrders(
        invoiceNumber: json["invoice_number"],
        code: json["code"],
        totalProduct: json["total_product"],
        totalPrice: json["total_price"],
        deliveryCharges: json["delivery_charges"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        prepareMin: json["prepare_min"],
        createdDate: DateTime.parse(json["created_date"]),
        userId: json["user_id"],
        deliveryPartnerId: json["delivery_partner_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        deliveryBoyName: json["delivery_boy_name"],
        deliveryBoyMobile: json["delivery_boy_mobile"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        customerAddress: CustomerAddress.fromJson(json["customer_address"]),
        storeAddress: StoreAddress.fromJson(json["store_address"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "code": code,
        "total_product": totalProduct,
        "total_price": totalPrice,
        "delivery_charges": deliveryCharges,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "prepare_min": prepareMin,
        "created_date": createdDate.toIso8601String(),
        "user_id": userId,
        "delivery_partner_id": deliveryPartnerId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "delivery_boy_name": deliveryBoyName,
        "delivery_boy_mobile": deliveryBoyMobile,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "customer_address": customerAddress.toJson(),
        "store_address": storeAddress.toJson(),
      };
}

class CustomerAddress {
  int? id;
  int? orderId;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? addressLine2;
  int? status;
  DateTime createdDate;

  CustomerAddress({
    this.id,
    this.orderId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.addressLine2,
    this.status,
    required this.createdDate,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      CustomerAddress(
        id: json["id"],
        orderId: json["order_id"],
        address: json["address"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        addressLine2: json["address_line_2"],
        status: json["status"],
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "address": address,
        "landmark": landmark,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "address_line_2": addressLine2,
        "status": status,
        "created_date": createdDate.toIso8601String(),
      };
}

class Item {
  int? orderItemId;
  int? storeId;
  int? orderId;
  int? productId;
  String? productName;
  int? userId;
  String? price;
  int? quantity;
  String? totalPrice;
  String? storePrice;
  String? storeTotalPrice;
  String? imageUrl;
  int? status;
  int? createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime updatedDate;

  Item({
    required this.orderItemId,
    this.storeId,
    this.orderId,
    this.productId,
    this.productName,
    this.userId,
    this.price,
    this.quantity,
    this.totalPrice,
    this.storePrice,
    this.storeTotalPrice,
    this.imageUrl,
    this.status,
    this.createdBy,
    required this.createdDate,
    this.updatedBy,
    required this.updatedDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        orderItemId: json["order_item_id"],
        storeId: json["store_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        userId: json["user_id"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        storePrice: json["store_price"],
        storeTotalPrice: json["store_total_price"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "order_item_id": orderItemId,
        "store_id": storeId,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "user_id": userId,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "store_price": storePrice,
        "store_total_price": storeTotalPrice,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate.toIso8601String(),
      };
}

class StoreAddress {
  int? storeId;
  int? userId;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? state;
  String? country;
  String? logo;
  int? gstNo;
  int? panNo;
  String? terms;
  String? zipcode;
  dynamic frontImg;
  String? onlineVisibility;
  String? tags;
  String? status;
  int? createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime updatedDate;
  String? slug;
  int? storeStatus;

  StoreAddress({
    this.storeId,
    this.userId,
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.city,
    this.state,
    this.country,
    this.logo,
    this.gstNo,
    this.panNo,
    this.terms,
    this.zipcode,
    this.frontImg,
    this.onlineVisibility,
    this.tags,
    this.status,
    this.createdBy,
    required this.createdDate,
    this.updatedBy,
    required this.updatedDate,
    this.slug,
    this.storeStatus,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
        storeId: json["store_id"],
        userId: json["user_id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        logo: json["logo"],
        gstNo: json["gst_no"],
        panNo: json["pan_no"],
        terms: json["terms"],
        zipcode: json["zipcode"],
        frontImg: json["front_img"],
        onlineVisibility: json["online_visibility"],
        tags: json["tags"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: DateTime.parse(json["updated_date"]),
        slug: json["slug"],
        storeStatus: json["store_status"],
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "logo": logo,
        "gst_no": gstNo,
        "pan_no": panNo,
        "terms": terms,
        "zipcode": zipcode,
        "front_img": frontImg,
        "online_visibility": onlineVisibility,
        "tags": tags,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate.toIso8601String(),
        "slug": slug,
        "store_status": storeStatus,
      };
}
