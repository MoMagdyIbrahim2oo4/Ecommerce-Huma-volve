import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  ApiClient apiClient;
  HomeRemoteDataSourceImp(this.apiClient);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    final List jsonData = response.data;
    return jsonData
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  @override
  Future<List<ProductModel>> getProducts(
    int productID,
    int limit,
    int offset,
  ) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.categoriesEndpoint}/$productID/${ApiEndpoints.productsEndpoint}',
      queryParameters: {ApiConstants.limit: limit, ApiConstants.offset: offset},
    );
    final List jsonData = response.data;
    return jsonData.map((element) => ProductModel.fromJson(element)).toList();
  }
}
