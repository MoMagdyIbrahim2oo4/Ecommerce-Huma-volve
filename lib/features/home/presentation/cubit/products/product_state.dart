part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductCubitInitial extends ProductState {}

final class ProductCubitLoading extends ProductState {}

final class ProductCubitSuccess extends ProductState {
  final List<ProductEntity> data;
  ProductCubitSuccess(this.data);
}

final class ProductCubitFailure extends ProductState {
  final String errorMessage;
  ProductCubitFailure(this.errorMessage);
}
