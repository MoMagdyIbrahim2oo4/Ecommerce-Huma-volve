import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_products_use_case.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  ProductCubit(this.getProductsUseCase) : super(ProductCubitInitial());
  Future<void> getProducts(int productID) async {
    emit(ProductCubitLoading());
    final data=await getProductsUseCase.invoke(productID);
    data.fold((error){
      emit(ProductCubitFailure(error.failureMessage));
    },
     (products){
      emit(ProductCubitSuccess(products));
     });
  }
}
