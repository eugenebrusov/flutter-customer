
import 'package:customer/data/model/product_details.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/data/model/product.dart';
import 'package:customer/data/model/product_category.dart';
import 'package:customer/data/source/firebase/extension/cloud_firestore_service_extension.dart';

class CloudFirestoreService {
  CloudFirestoreService._(this._firestore);

  factory CloudFirestoreService({@required Firestore firestore}) {
    return CloudFirestoreService._(firestore);
  }

  final Firestore _firestore;

  Future<List<ProductCategory>> productCategoriesFuture() => _firestore
      .collection('product_categories')
      .getDocuments()
      .then((querySnapshot) => parseProductCategorySnapshots(querySnapshot.documents));

  Stream<List<Product>> popularCategoryProductsStream(String categoryId) => _firestore
      .collection('product_categories')
      .document(categoryId)
      .collection('products')
      .limit(10)
      .snapshots()
      .asyncMap((querySnapshot) => parseProductSnapshots(querySnapshot.documents));

  Future<void> addToFavorites(Product product) => _firestore
      .collection('users')
      .document('A1IW0vY7zXuXqufN5eKu')
      .collection('favorites')
      .document(product.id)
      .setData(buildFavoritedProduct(product));

  Future<void> removeFromFavorites(Product product) => _firestore
      .collection('users')
      .document('A1IW0vY7zXuXqufN5eKu')
      .collection('favorites')
      .document(product.id)
      .delete();

  Stream<bool> isProductFavoritedStream(String productId) => _firestore
      .collection('users')
      .document('A1IW0vY7zXuXqufN5eKu')
      .collection('favorites')
      .document(productId)
      .snapshots()
      .map((snapshot) => snapshot.data != null);

  Stream<List<Product>> favoritedProductsStream() => _firestore
      .collection('users')
      .document('A1IW0vY7zXuXqufN5eKu')
      .collection('favorites')
      .orderBy('favoritedAt', descending: true)
      .snapshots()
      .asyncMap((querySnapshot) => parseProductSnapshots(querySnapshot.documents));

  Stream<ProductDetails> productDetailsStream(String productId) => _firestore
      .collectionGroup('products')
      .where('id', isEqualTo: productId)
      .snapshots()
      .asyncMap((querySnapshot) => parseSingleProductDetailsFromQuerySnapshotFuture(querySnapshot));
}