import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    super.id,
    super.name,
    super.slug,
    super.image,
    super.creationAt,
    super.updatedAt,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
}
