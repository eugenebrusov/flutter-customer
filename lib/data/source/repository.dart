
import 'package:customer/data/model/product_details.dart';
import 'package:customer/data/source/firebase/cloud_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:customer/data/model/product.dart';
import 'package:customer/data/model/credentials.dart';
import 'package:customer/data/model/product_category.dart';
import 'package:customer/data/source/ebda/ebda_service.dart';
import 'package:customer/data/source/firebase/cloud_firestore_service.dart';

class Repository {
  Repository._(this._ebdaService, this._cloudFirestoreService, this._firebaseStorageService);

  factory Repository({
    @required EbdaService ebdaService,
    @required CloudFirestoreService cloudFirestoreService,
    @required FirebaseStorageService firebaseStorageService
  }) {
    return Repository._(ebdaService, cloudFirestoreService, firebaseStorageService);
  }

  final EbdaService _ebdaService;
  final CloudFirestoreService _cloudFirestoreService;
  final FirebaseStorageService _firebaseStorageService;

  void dispose() {
    //
  }

  Future<void> login(Credentials credentials) =>
      _ebdaService.authenticate(credentials).then((auth) {
        return null;
      });

  Future<bool> isUserSignedInFuture() => Future.value(true);

  Future<List<ProductCategory>> productCategoriesFuture() =>
      _cloudFirestoreService.productCategoriesFuture();

  Stream<List<Product>> popularCategoryProductsStream(String categoryId) =>
      _cloudFirestoreService.popularCategoryProductsStream(categoryId);

  Future<void> addToFavorites(Product product) =>
      _cloudFirestoreService.addToFavorites(product);

  Future<void> removeFromFavorites(Product product) =>
      _cloudFirestoreService.removeFromFavorites(product);

  Stream<bool> isProductFavoritedStream(String productId) =>
      _cloudFirestoreService.isProductFavoritedStream(productId);

  Stream<List<Product>> favoritedProductsStream() =>
      _cloudFirestoreService.favoritedProductsStream();

  Stream<ProductDetails> productDetailsStream(String productId) =>
      _cloudFirestoreService.productDetailsStream(productId);

  Future<dynamic> productImageUrlFuture(String image) =>
      _firebaseStorageService.productImageUrlFuture(image);
}
