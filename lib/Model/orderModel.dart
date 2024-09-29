import 'package:deliveryboy_multivendor/Screens/CashCollection/Widget/orderIteamWidget.dart';
import 'package:deliveryboy_multivendor/Widget/parameterString.dart';

class OrderModel {
  String? id;
  String? username;
  String? email;
  String? mobile;
  String? orderId;
  String? name;
  String? longitude;
  String? latitude;
  String? createdDate;
  String? otp;
  String? sellerId;
  String? paymentMethod;
  String? userAddress;
  String? total;
  String? deliveryCharge;
  String? deliveryBoyId;
  String? walletBalance;
  String? discount;
  String? taxPercent;
  String? taxAmount;
  String? promoDiscount;
  String? totalPayable;
  String? finalTotal;
  String? notes;
  String? deliveryDate;
  String? deliveryTime;
  String? isCodCollected;
  String? isShiprocketOrder;
  String? activeStatus;
  List<dynamic>? status;
  List<ConsignmentItems>? consignmentItems;
  SellerDetails? sellerDetails;


  OrderModel({
    this.id,
    this.username,
    this.email,
    this.mobile,
    this.orderId,
    this.name,
    this.longitude,
    this.latitude,
    this.createdDate,
    this.otp,
    this.sellerId,
    this.paymentMethod,
    this.userAddress,
    this.total,
    this.deliveryCharge,
    this.deliveryBoyId,
    this.walletBalance,
    this.discount,
    this.taxPercent,
    this.taxAmount,
    this.promoDiscount,
    this.totalPayable,
    this.finalTotal,
    this.notes,
    this.deliveryDate,
    this.deliveryTime,
    this.isCodCollected,
    this.isShiprocketOrder,
    this.activeStatus,
    this.status,
    this.consignmentItems,
    this.sellerDetails,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    
    id = json['id']?.toString();
    username = json['username']?.toString();
    email = json['email']?.toString();
    mobile = json['mobile']?.toString();
    orderId = json['order_id']?.toString();
    name = json['name']?.toString();
    longitude = json['longitude']?.toString();
    latitude = json['latitude']?.toString();
    createdDate = json['created_date']?.toString();
    otp = json['otp']?.toString();
    sellerId = json['seller_id']?.toString();
    paymentMethod = json['payment_method']?.toString();
    userAddress = json['user_address']?.toString();
    total = json['total']?.toString();
    deliveryCharge = json['delivery_charge']?.toString();
    deliveryBoyId = json['delivery_boy_id']?.toString();
    walletBalance = json['wallet_balance']?.toString();
    discount = json['discount']?.toString();
    taxPercent = json['tax_percent']?.toString();
    taxAmount = json['tax_amount']?.toString();
    promoDiscount = json['promo_discount']?.toString();
    totalPayable = json['total_payable']?.toString();
    finalTotal = json['final_total']?.toString();
    notes = json['notes']?.toString();
    deliveryDate = json['delivery_date']?.toString();
    deliveryTime = json['delivery_time']?.toString();
    isCodCollected = json['is_cod_collected']?.toString();
    isShiprocketOrder = json['is_shiprocket_order']?.toString();
    activeStatus = json['active_status']?.toString();
    status = json['status'] as List<dynamic>?;
    consignmentItems = (json['consignment_items'] as List?)
        ?.map(
            (dynamic e) => ConsignmentItems.fromJson(e as Map<String, dynamic>))
        .toList();
    sellerDetails = json['seller_details'] != null
        ? SellerDetails.fromJson(json['seller_details'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['username'] = username;
    json['email'] = email;
    json['mobile'] = mobile;
    json['order_id'] = orderId;
    json['name'] = name;
    json['longitude'] = longitude;
    json['latitude'] = latitude;
    json['created_date'] = createdDate;
    json['otp'] = otp;
    json['seller_id'] = sellerId;
    json['payment_method'] = paymentMethod;
    json['user_address'] = userAddress;
    json['total'] = total;
    json['delivery_charge'] = deliveryCharge;
    json['delivery_boy_id'] = deliveryBoyId;
    json['wallet_balance'] = walletBalance;
    json['discount'] = discount;
    json['tax_percent'] = taxPercent;
    json['tax_amount'] = taxAmount;
    json['promo_discount'] = promoDiscount;
    json['total_payable'] = totalPayable;
    json['final_total'] = finalTotal;
    json['notes'] = notes;
    json['delivery_date'] = deliveryDate;
    json['delivery_time'] = deliveryTime;
    json['is_cod_collected'] = isCodCollected;
    json['is_shiprocket_order'] = isShiprocketOrder;
    json['active_status'] = activeStatus;
    json['status'] = status;
    json['consignment_items'] =
        consignmentItems?.map((e) => e.toJson()).toList();
    json['seller_details'] = sellerDetails?.toJson();
    return json;
  }
}

class ConsignmentItems {
  String? id;
  String? productVariantId;
  String? orderItemId;
  String? unitPrice;
  String? quantity;
  String? isCredited;
  String? productName;
  String? variantName;
  String? price;
  String? discountedPrice;
  String? taxIds;
  String? taxPercent;
  String? taxAmount;
  String? discount;
  String? subTotal;
  String? deliverBy;
  String? updatedBy;
  String? isSent;
  String? dateAdded;
  String? deliveredQuantity;
  String? isCancelable;
  String? isReturnable;
  String? image;
  String? type;
  String? notes;
  String? deliveryDate;
  String? deliveryTime;
  String? isCodCollected;
  String? isShiprocketOrder;
  String? pickupLocation;
  dynamic sku;
  String? productSlug;
  String? varaintIds;
  String? variantValues;
  String? attrName;
  String? imageSm;
  String? imageMd;
  String? isAlreadyReturned;
  String? isAlreadyCancelled;
  String? returnRequestSubmitted;

  

  ConsignmentItems({
    this.id,
    this.productVariantId,
    this.orderItemId,
    this.unitPrice,
    this.quantity,
    this.isCredited,
    this.productName,
    this.variantName,
    this.price,
    this.discountedPrice,
    this.taxIds,
    this.taxPercent,
    this.taxAmount,
    this.discount,
    this.subTotal,
    this.deliverBy,
    this.updatedBy,
    this.isSent,
    this.dateAdded,
    this.deliveredQuantity,
    this.isCancelable,
    this.isReturnable,
    this.image,
    this.type,
    this.notes,
    this.deliveryDate,
    this.deliveryTime,
    this.isCodCollected,
    this.isShiprocketOrder,
    this.pickupLocation,
    this.sku,
    this.productSlug,
    this.varaintIds,
    this.variantValues,
    this.attrName,
    this.imageSm,
    this.imageMd,
    this.isAlreadyReturned,
    this.isAlreadyCancelled,
    this.returnRequestSubmitted,
  });

  ConsignmentItems.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    productVariantId = json['product_variant_id']?.toString();
    orderItemId = json['order_item_id']?.toString();
    unitPrice = json['unit_price']?.toString();
    quantity = json['quantity']?.toString();
    isCredited = json['is_credited']?.toString();
    productName = json['product_name']?.toString();
    variantName = json['variant_name']?.toString();
    price = json['price']?.toString();
    discountedPrice = json['discounted_price']?.toString();
    taxIds = json['tax_ids']?.toString();
    taxPercent = json['tax_percent']?.toString();
    taxAmount = json['tax_amount']?.toString();
    discount = json['discount']?.toString();
    subTotal = json['sub_total']?.toString();
    deliverBy = json['deliver_by']?.toString();
    updatedBy = json['updated_by']?.toString();
    isSent = json['is_sent']?.toString();
    dateAdded = json['date_added']?.toString();
    deliveredQuantity = json['delivered_quantity']?.toString();
    isCancelable = json['is_cancelable']?.toString();
    isReturnable = json['is_returnable']?.toString();
    image = json['image']?.toString();
    type = json['type']?.toString();
    notes = json['notes']?.toString();
    deliveryDate = json['delivery_date']?.toString();
    deliveryTime = json['delivery_time']?.toString();
    isCodCollected = json['is_cod_collected']?.toString();
    isShiprocketOrder = json['is_shiprocket_order']?.toString();
    pickupLocation = json['pickup_location']?.toString();
    sku = json['sku'];
    productSlug = json['product_slug']?.toString();
    varaintIds = json['varaint_ids']?.toString();
    variantValues = json['variant_values']?.toString();
    attrName = json['attr_name']?.toString();
    imageSm = json['image_sm']?.toString();
    imageMd = json['image_md']?.toString();
    isAlreadyReturned = json['is_already_returned']?.toString();
    isAlreadyCancelled = json['is_already_cancelled']?.toString();
    returnRequestSubmitted = json['return_request_submitted']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['product_variant_id'] = productVariantId;
    json['order_item_id'] = orderItemId;
    json['unit_price'] = unitPrice;
    json['quantity'] = quantity;
    json['is_credited'] = isCredited;
    json['product_name'] = productName;
    json['variant_name'] = variantName;
    json['price'] = price;
    json['discounted_price'] = discountedPrice;
    json['tax_ids'] = taxIds;
    json['tax_percent'] = taxPercent;
    json['tax_amount'] = taxAmount;
    json['discount'] = discount;
    json['sub_total'] = subTotal;
    json['deliver_by'] = deliverBy;
    json['updated_by'] = updatedBy;
    json['is_sent'] = isSent;
    json['date_added'] = dateAdded;
    json['delivered_quantity'] = deliveredQuantity;
    json['is_cancelable'] = isCancelable;
    json['is_returnable'] = isReturnable;
    json['image'] = image;
    json['type'] = type;
    json['notes'] = notes;
    json['delivery_date'] = deliveryDate;
    json['delivery_time'] = deliveryTime;
    json['is_cod_collected'] = isCodCollected;
    json['is_shiprocket_order'] = isShiprocketOrder;
    json['pickup_location'] = pickupLocation;
    json['sku'] = sku;
    json['product_slug'] = productSlug;
    json['varaint_ids'] = varaintIds;
    json['variant_values'] = variantValues;
    json['attr_name'] = attrName;
    json['image_sm'] = imageSm;
    json['image_md'] = imageMd;
    json['is_already_returned'] = isAlreadyReturned;
    json['is_already_cancelled'] = isAlreadyCancelled;
    json['return_request_submitted'] = returnRequestSubmitted;
    return json;
  }
}

class SellerDetails {
  String? storeName;
  String? sellerName;
  String? address;
  String? mobile;
  String? storeImage;
  String? latitude;
  String? longitude;

  SellerDetails({
    this.storeName,
    this.sellerName,
    this.address,
    this.mobile,
    this.storeImage,
    this.latitude,
    this.longitude,
  });

  SellerDetails.fromJson(Map<String, dynamic> json) {
    storeName = json['store_name']?.toString();
    sellerName = json['seller_name']?.toString();
    address = json['address']?.toString();
    mobile = json['mobile']?.toString();
    storeImage = json['store_image']?.toString();
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['store_name'] = storeName;
    json['seller_name'] = sellerName;
    json['address'] = address;
    json['mobile'] = mobile;
    json['store_image'] = storeImage;
    json['latitude'] = latitude;
    json['longitude'] = longitude;
    return json;
  }
}
