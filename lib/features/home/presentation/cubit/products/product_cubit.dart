import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/service/home_service.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  HomeService homeService;
  ProductCubit(this.homeService) : super(ProductCubitInitial());
  Future<void> getProducts(int productID) async {
    emit(ProductCubitLoading());
    try {
      final data = await homeService.getProducts(productID);
      emit(ProductCubitSuccess(data));
    } on DioException catch (e) {
      emit(ProductCubitFailure(e.message ?? 'Something Went Wrong'));
    } catch (e) {
      emit(ProductCubitFailure('Could not load products: $e'));
    }
  }
}
