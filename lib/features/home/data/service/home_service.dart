import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeService {
  ApiClient apiClient;
  HomeService(this.apiClient);
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    final List jsonData = response.data;
    return jsonData
        .map((category) => CategoryModel.fromJson(category))
        .toList();
  }

  Future<List<ProductModel>> getProducts(int productID) async {
    final response=await apiClient.dio.get('${ApiEndpoints.categoriesEndpoint}/$productID/${ApiEndpoints.productsEndpoint}');
    final List jsonData=response.data;
    return jsonData.map((element)=>ProductModel.fromJson(element)).toList();
  }
}
