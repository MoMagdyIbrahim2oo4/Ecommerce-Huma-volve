import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetProductsUseCase {
  final HomeRepo homeRepo;
  GetProductsUseCase(this.homeRepo);
  Future<Either<Failure, List<ProductEntity>>> invoke(
    int productID,
    int limit,
    int offset,
  ) => homeRepo.getProducts(productID, limit, offset);
}
