import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  int limit = 10;
  int offset = 0;
  bool isPaginationLoading = false;
  bool hasMore = true;
  List<ProductEntity> currentProducts = [];
  ProductCubit(this.getProductsUseCase) : super(ProductCubitInitial());
  Future<void> getProducts(int productID) async {
    offset = 0;
    hasMore = true;
    isPaginationLoading = false;
    currentProducts.clear();
    emit(ProductCubitLoading());
    final data = await getProductsUseCase.invoke(productID, limit, offset);
    data.fold(
      (error) {
        emit(ProductCubitFailure(error.failureMessage));
      },
      (products) {
        currentProducts = products;
        if (products.length < limit) {
          hasMore = false;
        }
        emit(ProductCubitSuccess(products));
      },
    );
    isPaginationLoading = false;
  }

  Future<void> loadMoreProducts(int productID) async {
    if (isPaginationLoading || !hasMore) return;
    isPaginationLoading = true;
    final nextOffset = currentProducts.length;
    final data = await getProductsUseCase.invoke(productID, limit, nextOffset);
    data.fold(
      (error) {
        isPaginationLoading = false;
        emit(ProductCubitFailure(error.failureMessage));
      },
      (products) {
        isPaginationLoading = false;
        if (products.isEmpty) {
          hasMore = false;
          emit(ProductCubitSuccess(List.from(currentProducts)));
        } else {
          currentProducts.addAll(products);
          offset = currentProducts.length;
          if (products.length < limit) hasMore = false;
          emit(ProductCubitSuccess(List.from(currentProducts)));
        }
      },
    );
  }
}
