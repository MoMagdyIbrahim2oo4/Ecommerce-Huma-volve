import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepoImp(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDataSource.getCategories();
      return Right(categories);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    int productID,
    int limit,
    int offset,
  ) async {
    try {
      final products = await homeRemoteDataSource.getProducts(
        productID,
        limit,
        offset,
      );
      return Right(products);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
