import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoriesCubit(this.getCategoriesUseCase) : super(CategoriesCubitInitial());

  Future<void> getCategories() async {
    emit(CategoriesCubitLoading());
    final data = await getCategoriesUseCase.invoke();
    data.fold(
      (error) {
        emit(CategoriesCubitFailure(error.failureMessage));
      },
      (cateories) {
        emit(CategoriesCubitSuccess(cateories));
      },
    );
  }
}
