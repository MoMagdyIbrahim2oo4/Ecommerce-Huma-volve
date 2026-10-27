import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetProductByIdUseCase {
  final HomeRepo homeRepo;

  GetProductByIdUseCase(this.homeRepo);

  Future<Either<Failure, ProductEntity>> invoke(int productId) =>
      homeRepo.getProductById(productId);
}
