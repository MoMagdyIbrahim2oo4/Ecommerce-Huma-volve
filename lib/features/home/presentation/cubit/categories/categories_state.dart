part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesCubitInitial extends CategoriesState {}

final class CategoriesCubitLoading extends CategoriesState {}

final class CategoriesCubitSuccess extends CategoriesState {
  final List<CategoryEntity> data;
  CategoriesCubitSuccess(this.data);
}

final class CategoriesCubitFailure extends CategoriesState {
  final String errorMessage;
  CategoriesCubitFailure(this.errorMessage);
}
