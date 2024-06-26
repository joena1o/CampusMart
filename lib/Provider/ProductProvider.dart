import 'dart:convert';
import 'package:campus_mart/Model/AdAlertModel.dart';
import 'package:campus_mart/Model/ErrorModel.dart';
import 'package:campus_mart/Model/NotificationModel.dart';
import 'package:campus_mart/Model/ProductModel.dart';
import 'package:campus_mart/Model/ReviewModel.dart';
import 'package:campus_mart/Model/SuccessMessageModel.dart';
import 'package:campus_mart/Model/WishProductModel.dart';
import 'package:campus_mart/Network/ProductClass/ProductClass.dart';
import 'package:campus_mart/Screens/EditSuccessful/EditSuccessful.dart';
import 'package:campus_mart/Utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProductProvider extends ChangeNotifier{

  BuildContext? ctx;

  List<WishProductModel>? wishProductModel;
  List<ProductModel> productList = [];
  List<ProductModel> pendingAdsList = [];
  List<ProductModel> categoryProductList = [];
  List<NotificationModel> notificationList = [];
  List<AdAlertModel> adAlertList = [];
  List<ProductModel> myProductList = [];

  ReviewModel? reviews;

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshController2 = RefreshController(initialRefresh: false);
  final RefreshController refreshController3 = RefreshController(initialRefresh: false);

  ProductClass product = ProductClass();

  String? currentCategory;

  bool loadingWishList = false;
  bool get isLoadingWishList => loadingWishList;

  bool loadingReviews = false;
  bool get getLoadingReviews => loadingReviews;

  bool isGettingProduct = false;
  bool get getIsGettingProduct => isGettingProduct;

  bool isGettingMyProduct = false;
  bool get getIsGettingMyProduct => isGettingMyProduct;

  bool uploadingReview = false;
  bool get getUploadingReview => uploadingReview;

  bool loadingNotifications = false;
  bool get getLoadingNotifications => loadingNotifications;

  bool uploadingAdAlert = false;
  bool get isUploadingAlert => uploadingAdAlert;

  bool fetchAdAlerts = true;
  bool get isFetchingAdAlerts => fetchAdAlerts;

  bool deleteAdAlertStatus = false;
  bool get deletingAdAlert => deleteAdAlertStatus;

  bool processingPayment = false;
  bool processingPaymentFailed = false;

  bool editingAd = false;

  void setContext(BuildContext context){
    ctx = context;
    notifyListeners();
  }

  void getWishList(username, token){
    loadingWishList = true;
    product.fetchWishList(username, token).then((value){
      loadingWishList = false;
      wishProductModel = value;
      print(wishProductModel?.length);
      notifyListeners();
    }).catchError((onError){
      print(onError);
      loadingWishList = false;
      wishProductModel = [];
      notifyListeners();
    });
  }

  void resetMyAdsItems(){
    myAdsIndex = 1;
    pendingAdsIndex = 1;
    myProductList = [];
    pendingAdsList = [];
  }

  void getMyAds(id, token){
    isGettingMyProduct = true;
    product.getMyProducts(id, myAdsIndex, token).then((value){
      isGettingMyProduct = false;
      if(value.length > 0){
        myProductList += value;
        myAdsIndex += 1;
      }
      refreshController.loadComplete();
      notifyListeners();
    }).catchError((onError){
      refreshController.loadComplete();
      isGettingMyProduct = false;
      notifyListeners();
    });
  }

  void getMyPendingAds(id, token){
    isGettingMyProduct = true;
    product.getMyPendingProducts(id, pendingAdsIndex, token).then((value){
      isGettingMyProduct = false;
      if(value.length > 0){
        pendingAdsList += value;
        pendingAdsIndex += 1;
      }
      refreshController.loadComplete();
      notifyListeners();
    }).catchError((onError){
      refreshController.loadComplete();
      isGettingMyProduct = false;
      notifyListeners();
    });
  }

  void deleteAd(id,context,userId, token){
    isGettingMyProduct = true;
    product.deleteProduct(id, token).then((value){
      getMyAds(userId, token);
      SuccessMessageModel successMessageModel = SuccessMessageModel.fromJson(jsonDecode(value));
      showMessage(successMessageModel.message, context);
    }).catchError((onError){
      isGettingMyProduct = false;
    });
  }


  void addAdAlert(context,data, userId, token){
    uploadingAdAlert = true;
    product.adAlert(data, token).then((value){
      uploadingAdAlert = false;
      ErrorModel errorModel = ErrorModel.fromJson((value));
      Navigator.of(context).pop();
      showMessage(errorModel.message, context);
      getAdAlerts(userId, token);
      notifyListeners();
    }).catchError((onError){
      uploadingAdAlert = false;
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(onError));
      showMessage(errorModel.message, context);
      notifyListeners();
    });
  }


  void getAdAlerts(userId, token){
    adAlertList = [];
    fetchAdAlerts = true;
    product.getAdAlerts(userId, token).then((value){
      fetchAdAlerts = false;
      adAlertList = value;
      notifyListeners();
    }).catchError((onError){
      fetchAdAlerts = false;
      print(onError);
      notifyListeners();
    });
  }


  void deleteAdAlert(id,context,userId,token){
    deleteAdAlertStatus = true;
    product.deleteAdAlert(id, token).then((value){
      deleteAdAlertStatus = false;
      getAdAlerts(userId,token);
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(value));
      showMessage(errorModel.message, context);
      notifyListeners();
    }).catchError((onError){
      deleteAdAlertStatus = false;
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(onError));
      showMessageError(errorModel.message, context);
      notifyListeners();
    });
  }

  void getUserReviews(id, token){
    loadingReviews = true;
    product.getReviews(id, token).then((value){
      loadingReviews = false;
      reviews = value;
      print(reviews!.data?.length);
      notifyListeners();
    }).catchError((onError){
      print(onError);
      loadingReviews = false;
      notifyListeners();
    });
  }

  Future addReview(data, token) async{
    uploadingReview = true;
    product.addReview(data, token).then((value){
      uploadingReview = true;
      notifyListeners();
    }).catchError((onError){
      uploadingReview = false;
      notifyListeners();
    });
  }

  Future getNotifications(userId, token) async{
    loadingNotifications = true;
    product.getNotifications(userId, token).then((value){
      loadingNotifications = false;
      notificationList = value;
      notifyListeners();
    }).catchError((onError){
      loadingNotifications = false;
      notifyListeners();
    });
  }

  int indexAll = 1;
  int indexCat = 1;
  int searchIndex = 1;

  int myAdsIndex = 1;
  int pendingAdsIndex = 1;

  void resetItems(){
    indexCat = 1;
    categoryProductList = [];
    notifyListeners();
  }

  void resetMyProduct(){
    indexAll = 1;
    productList = [];
    notifyListeners();
  }

  void searchProduct(query, token, ctx) async{
    categoryProductList = [];
    isGettingProduct = true;
    try{
      categoryProductList += await product.searchProduct(query, searchIndex, token);;
    }catch(e){
      showMessage(e.toString(), ctx);
    }finally{
      isGettingProduct = false;
    }
    notifyListeners();
  }

  void initProductStatus(){
    processingPayment = true;
    processingPaymentFailed = false;
    notifyListeners();
  }

  void updateProductStatus(bool isSuccess) async{
    if(isSuccess){
      processingPayment = false;
      processingPaymentFailed = false;
    }else{
      processingPayment = false;
      processingPaymentFailed = true;
    }
    notifyListeners();
  }

  void updateProductStatusForEdit(data, token, ctx) async{
    processingPayment = true;
    processingPaymentFailed = false;
    try{
      await product.updatePaymentStatus(data, token);
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(
              builder: (_)=> const EditSuccessful()
          )
      );
    }catch(e){
      showMessage(e.toString(), ctx);
      processingPaymentFailed = true;
    }finally{
      processingPayment = false;
    }
    notifyListeners();
  }

  void editProduct(Map<String, dynamic> data, String token, ctx) async{
    editingAd = true;
    try{
      await product.editProduct(data, token);
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_)=> const EditSuccessful()));
    }catch(e){
      showMessage(e.toString(), ctx);
    }finally{
      editingAd = false;
    }
    notifyListeners();
  }

  void saveSearch(data, token) async{
    try{
      await product.saveSearch(data, token);
    }catch(e){
      print(e.toString());
    }
  }

  void searchProductByCategory(query, token, ctx) async{
    categoryProductList = [];
    isGettingProduct = true;
    try{
      categoryProductList += await product.searchCategoryProduct(query, searchIndex, currentCategory, token);
    }catch(e){
      showMessage(e.toString(), ctx);
    }finally{
      isGettingProduct = false;
    }
    notifyListeners();
  }

  void getProduct(category,val,context,cat,token) async{
    isGettingProduct = true;
    await product.fetchProduct(category, category.toString().isEmpty ? indexAll : indexCat, token).then((value){
      isGettingProduct = false;
      if(category.toString().isEmpty){
          if(value is List<ProductModel> && value.isNotEmpty){
            productList += value;
            indexAll += 1;
          }
      }else{
        if(value is List<ProductModel> && value.isNotEmpty){
          categoryProductList += value;
          indexCat += 1;
        }
      }
      if(val==1){
        refreshController.loadComplete();
      }else{
        refreshController2.loadComplete();
      }
    }).catchError((onError){
      isGettingProduct = false;
      refreshController.loadComplete();
      refreshController2.loadComplete();
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(onError));
      showMessageError(errorModel.message, context);
    });
    notifyListeners();
  }

}