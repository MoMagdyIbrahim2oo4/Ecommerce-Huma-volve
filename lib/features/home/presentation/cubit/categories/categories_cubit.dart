import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/service/home_service.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final HomeService homeService;
  CategoriesCubit(this.homeService) : super(CategoriesCubitInitial());

  Future<void> getCategories() async {
    emit(CategoriesCubitLoading());
    try {
      final data = await homeService.getCategories();
      emit(CategoriesCubitSuccess(data));
    } on DioException catch (e) {
      emit(CategoriesCubitFailure(e.message ?? 'Something Went Wrong'));
    }
  }
}
