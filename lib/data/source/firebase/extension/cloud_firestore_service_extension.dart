import 'package:customer/data/model/product.dart';
import 'package:customer/data/model/product_category.dart';
import 'package:customer/data/model/product_details.dart';
import 'package:customer/data/source/firebase/cloud_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/data/source/firebase/exception/cloud_firestore_parse_exception.dart';

extension CloudFirestoreServiceExtension on CloudFirestoreService {
  Future<List<ProductCategory>> parseProductCategorySnapshots(List<DocumentSnapshot> snapshots) => Stream
      .fromIterable(snapshots)
      .asyncMap(parseProductCategorySnapshot)
      .toList();

  Future<ProductCategory> parseProductCategorySnapshot(DocumentSnapshot snapshot) async {
    try {
      String id = snapshot.documentID;
      String title = snapshot['title'];
      int productCount = snapshot['productCount'];

      return ProductCategory(id: id, title: title, productCount: productCount);
    } catch (error) {
      throw CloudFirestoreParseProductCategoryException();
    }
  }

  Future<List<Product>> parseProductSnapshots(List<DocumentSnapshot> snapshots) => Stream
      .fromIterable(snapshots)
      .asyncMap(parseProductSnapshot)
      .toList();

  Future<Product> parseProductSnapshot(DocumentSnapshot snapshot) async {
    try {
      String id = snapshot.documentID;
      String image = snapshot['image'];
      String title = snapshot['title'];
      String supplierTitle = snapshot['supplierTitle'];
      double price = snapshot['price'];

      return Product(
          id: id,
          image: image,
          title: title,
          supplierTitle: supplierTitle,
          price: price);
    } catch (error) {
      throw CloudFirestoreParseProductException();
    }
  }

  Future<ProductDetails> parseSingleProductDetailsFromQuerySnapshotFuture(QuerySnapshot querySnapshot) async {
    DocumentSnapshot documentSnapshot = (querySnapshot.documents.length == 1)
        ? querySnapshot.documents[0]
        : throw CloudFirestoreInvalidSingleProductDetailsFromQuerySnapshotException();

    try {
      String id = documentSnapshot.documentID;
      String image = documentSnapshot['image'];
      String title = documentSnapshot['title'];
      double price = documentSnapshot['price'];
      String description = documentSnapshot['description'];
      String supplierTitle = documentSnapshot['supplierTitle'];
      DocumentSnapshot categorySnapshot = await documentSnapshot.reference.parent().parent().get();
      String categoryId = categorySnapshot.documentID;
      String categoryTitle = categorySnapshot['title'];

      return ProductDetails(
          id: id,
          image: image,
          title: title,
          price: price,
          description: description,
          supplierTitle: supplierTitle,
          categoryId: categoryId,
          categoryTitle: categoryTitle,
      );
    } catch (error) {
      throw CloudFirestoreParseProductException();
    }
  }

  Map<String, dynamic> buildFavoritedProduct(Product product) => {
    'id' : product.id,
    'image' : product.image,
    'title' : product.title,
    'supplierTitle' : product.supplierTitle,
    'price' : product.price,
    'favoritedAt': FieldValue.serverTimestamp(),
  };
}