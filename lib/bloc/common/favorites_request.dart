
import 'package:customer/data/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesRequest extends Equatable {
  const FavoritesRequest._(this.product);

  factory FavoritesRequest.add(Product product) = AddToFavoritesRequest;
  factory FavoritesRequest.remove(Product product) = RemoveFromFavoritesRequest;

  final Product product;

  @override
  List<Object> get props => [product];
}

class AddToFavoritesRequest extends FavoritesRequest {
  AddToFavoritesRequest(Product product) : super._(product);
}

class RemoveFromFavoritesRequest extends FavoritesRequest {
  RemoveFromFavoritesRequest(Product product) : super._(product);
}