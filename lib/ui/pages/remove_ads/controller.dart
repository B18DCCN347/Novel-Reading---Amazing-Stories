import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:love_novel/app/global/controller.dart';
import 'package:love_novel/data/models/public/app_config.dart';
import 'package:love_novel/data/repositories/book.dart';
import 'package:love_novel/data/repositories/customer.dart';
import 'package:love_novel/ui/components/app_theme.dart';
import 'package:love_novel/ui/components/remove_ads_item.dart';
import 'package:love_novel/ui/pages/ads/controller.dart';
import 'consumable_store.dart';

class RemoveAdsController extends GetxController {
  static RemoveAdsController get instance =>
      Get.isRegistered<RemoveAdsController>()
          ? Get.find()
          : Get.put(RemoveAdsController());

  // 1 Month No Ads :
  // com.lightnovel.novelreaderromancestories.remove.ads.1m
  // 3 Monthe No Ads:
  // com.lightnovel.novelreaderromancestories.remove.ads.3m
  // 6 Monthe No Ads:
  // com.lightnovel.novelreaderromancestories.remove.ads.6m
  // 1 Year No Ads      :
  // com.lightnovel.novelreaderromancestories.remove.ads.1m
  static const String oneMonthProductId = 'package_one_month';
  // static const String threeMonthProductId =
  //     'com.lightnovel.novelreaderromancestories.remove.ads.3m';
  // static const String sixMonthProductId =
  //     'com.lightnovel.novelreaderromancestories.remove.ads.6m';
  static const String foreverProductId = 'package_one_year';

  static const allProductIds = [
    oneMonthProductId,
    // threeMonthProductId,
    // sixMonthProductId,
    foreverProductId
  ];

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  var _notFoundIds = Rx<List<String>>([]);
  static var _products = Rx<List<ProductDetails>>([]);
  var _purchases = Rx<List<PurchaseDetails>>([]);
  var _consumables = Rx<List<String>>([]);
  static var _isAvailable = false.obs;
  var _purchasePending = false.obs;
  var _loading = false.obs;
  var errorMessage = Rxn<String>();
  static var needToShowAds = false;
  @override
  void onInit() {
    super.onInit();
  }

  init() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });
    await initStoreInfo();
  }

  static checkToShowAds(AppConfig? config) async {
    if (config?.apiSettings != null) {
      var setting = config!.apiSettings!;
      if (setting.bannerAdsOrder != null &&
          setting.bannerAdsOrder!.isNotEmpty) {
        AppController.isPriority =
            config.apiSettings!.bannerAdsOrder![0] == "is";
      }
      if (setting.fullscreenAdsCap != null) {
        AppController.adConfig = setting.fullscreenAdsCap!;
      }
      needToShowAds = !(setting.noAds ?? false);
      if (needToShowAds && (setting.noAdsFirstNDays ?? 0) > 0) {
        var firstTime =
            DateTime.fromMillisecondsSinceEpoch(AppController.firstTimestamp);
        var lastTime = firstTime.add(Duration(days: setting.noAdsFirstNDays!));
        if (DateTime.now().isBefore(lastTime)) {
          needToShowAds = false;
        }
      }
    } else {
      needToShowAds = true;
    }
    if (needToShowAds) {
      var fResponse = await CustomerRepository().fetchFeatures();
      if (fResponse?.data != null && fResponse!.data!.isNotEmpty) {
        needToShowAds = false;
      } else {
        needToShowAds = true;
      }
    }
    if (needToShowAds) {
      await AdsController.instance.init();
    }
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _isAvailable.value = isAvailable;
      _products.value = <ProductDetails>[];
      _purchases.value = <PurchaseDetails>[];
      _notFoundIds.value = <String>[];
      _consumables.value = <String>[];
      _purchasePending.value = false;
      _loading.value = false;
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(AppPaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(allProductIds.toSet());
    if (productDetailResponse.error != null) {
      errorMessage.value = productDetailResponse.error!.message;
      _isAvailable.value = isAvailable;
      _products.value = productDetailResponse.productDetails;
      _purchases.value = <PurchaseDetails>[];
      _notFoundIds.value = productDetailResponse.notFoundIDs;
      _consumables.value = <String>[];
      _purchasePending.value = false;
      _loading.value = false;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      errorMessage.value = null;
      _isAvailable.value = isAvailable;
      _products.value = productDetailResponse.productDetails;
      _purchases.value = [];
      _notFoundIds.value = productDetailResponse.notFoundIDs;
      _consumables.value = [];
      _purchasePending.value = false;
      _loading.value = false;
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    _isAvailable.value = isAvailable;
    _products.value = productDetailResponse.productDetails;
    _notFoundIds.value = productDetailResponse.notFoundIDs;
    _consumables.value = consumables;
    _purchasePending.value = false;
    _loading.value = false;
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              _inAppPurchase
                  .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
        var response = await BookRepository().configInfo();
        await RemoveAdsController.checkToShowAds(response);
      }
    }
  }

  void showPendingUI() {
    _purchasePending.value = true;
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    await ConsumableStore.save(purchaseDetails.purchaseID!);
    final List<String> consumables = await ConsumableStore.load();
    _purchasePending.value = false;
    _consumables.value = consumables;
  }

  void handleError(IAPError error) {
    _purchasePending.value = false;
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    var response = await CustomerRepository().buyFeature(
        purchaseDetails.productID,
        purchaseDetails.verificationData.localVerificationData);
    return response?.success ?? false;
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    //Dialogs.alert(message: "Giao dịch không hợp lệ!");
  }

  Future<void> confirmPriceChange() async {
    var context = Get.context!;
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      final BillingResultWrapper priceChangeConfirmationResult =
          await androidAddition.launchPriceChangeConfirmationFlow(
        sku: 'purchaseId',
      );
      if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Price change accepted'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            priceChangeConfirmationResult.debugMessage ??
                'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
          ),
        ));
      }
    }
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    if (purchases[productDetails.id] != null) {
      GooglePlayPurchaseDetails? oldSubscription =
          purchases[productDetails.id] as GooglePlayPurchaseDetails;
      return oldSubscription;
    }
    // if (productDetails.id == _kSilverSubscriptionId &&
    //     purchases[_kGoldSubscriptionId] != null) {
    //   oldSubscription =
    //       purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    // } else if (productDetails.id == _kGoldSubscriptionId &&
    //     purchases[_kSilverSubscriptionId] != null) {
    //   oldSubscription =
    //       purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    // }
    return null;
  }

  String getProductTitle(ProductDetails productDetails) {
    switch (productDetails.id) {
      case oneMonthProductId:
        return "Subscribe VIP Now ! ";
      // case threeMonthProductId:
      //   return "Remove Ads For 3 Months";
      // case sixMonthProductId:
      //   return "Remove Ads For 6 Months";
      case foreverProductId:
        return "FORERVER PLAN";
      default:
        return productDetails.title;
    }
  }

  Column buildProductList() {
    if (_loading.value) {
      return Column(
        children: [
          const Card(
              child: ListTile(
                  leading: CircularProgressIndicator(),
                  title: Text('Fetching products...'))),
        ],
      );
    }
    if (!_isAvailable.value) {
      return Column(
        children: [
          const Card(),
        ],
      );
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<Widget> productList = [];
    if (_notFoundIds.value.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.value.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
            _purchases.value.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    _products.value.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
    productList.addAll(
      _products.value.map(
        (ProductDetails productDetails) {
          final PurchaseDetails? previousPurchase =
              purchases[productDetails.id];
          return RemoveAdsItem(
            color: productDetails.id ==
                    "com.goldendragon.webnovelr  omancenovel.remove.ads.1y"
                ? AppTheme.goldColor
                : Colors.black,
            text: getProductTitle(productDetails),
            price: productDetails.price,
            purchased: previousPurchase != null,
            onTap: () async {
              if (previousPurchase != null) {
                confirmPriceChange();
              } else {
                late PurchaseParam purchaseParam;

                if (Platform.isAndroid) {
                  // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                  // verify the latest status of you your subscription by using server side receipt validation
                  // and update the UI accordingly. The subscription purchase status shown
                  // inside the app may not be accurate.
                  final GooglePlayPurchaseDetails? oldSubscription =
                      _getOldSubscription(productDetails, purchases);

                  purchaseParam = GooglePlayPurchaseParam(
                      productDetails: productDetails,
                      applicationUserName: null,
                      changeSubscriptionParam: (oldSubscription != null)
                          ? ChangeSubscriptionParam(
                              oldPurchaseDetails: oldSubscription,
                              prorationMode:
                                  ProrationMode.immediateWithTimeProration,
                            )
                          : null);
                } else {
                  purchaseParam = PurchaseParam(
                    productDetails: productDetails,
                    applicationUserName: null,
                  );
                }
                var paid = await _inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam);
              }
            },
          );
        },
      ),
    );
    _products.value.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

    log(_products.value[0].price);
    return Column(
      children: [
        CircleAvatar(
          child: Text(
            "VIP",
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 31,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppTheme.goldColor,
          radius: 35,
        ),
        SizedBox(
          height: 43,
        ),
        Text(
          "Novel Vip",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${_products.value[0].price}/Month  VIP Menber",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 14,
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'Or ${_products.value[1].price} for Lifetime VIP menber',
            style: TextStyle(
              fontSize: 14,
              // color: Color(0xffC9C9C9),
              fontWeight: FontWeight.w400,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.goldColor),
          ),
        ),
        SizedBox(
          height: 38,
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Remove All Ads.\nUnlimited reading.\nUnlimited download chapters',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textColor,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.goldColor),
            color: Color(0xffC9C9C9),
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Column(
          children:
              // <Widget>[
              //       productHeader,
              //       const Divider(),
              //     ] +
              //

              //
              productList,
        ),
      ],
    );
  }
}

class AppPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
