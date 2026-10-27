import 'package:dartz/dartz.dart' hide State;
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/utils/failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/widgets/share_product_button.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/repos/home_repo_imp.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/color_selector.dart';
import '../widgets/size_selector.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productID;

  const ProductDetailsScreen({super.key, required this.productID});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final List<Color> _availableColors = [Colors.black, Colors.blue, Colors.grey];
  final List<String> _availableSizes = ['S', 'M', 'L', 'XL'];
  late Color _selectedColor;
  late String _selectedSize;
  late Future<Either<Failure, ProductEntity>> _productFuture;

  @override
  void initState() {
    super.initState();
    _selectedColor = _availableColors.first;
    _selectedSize = _availableSizes.first;
    final repo = HomeRepoImp(HomeRemoteDataSourceImp(ApiClient()));
    _productFuture = GetProductByIdUseCase(repo).invoke(widget.productID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, ProductEntity>>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final result = snapshot.data;
        if (snapshot.hasError || result == null || result.isLeft()) {
          final message = result?.fold(
            (failure) => failure.failureMessage,
            (_) => '',
          );
          return Scaffold(
            appBar: AppBar(title: const Text('Product details')),
            body: Center(
              child: Text(
                message?.isNotEmpty == true
                    ? message!
                    : 'Unable to load this product.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final product = result.fold(
          (_) => ProductEntity(),
          (product) => product,
        );
        final images = product.images;
        final imageUrl = images != null && images.isNotEmpty
            ? images.first
            : null;

        return Scaffold(
          backgroundColor: AppTheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: AppTheme.background,
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  ShareProductButton(productId: widget.productID.toString()),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, size: 18),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'product-${product.id}',
                    child: imageUrl == null
                        ? const _ProductImagePlaceholder()
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const _ProductImagePlaceholder(),
                          ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  transform: Matrix4.translationValues(0, -32, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                product.title ?? 'Unknown',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(fontSize: 28, height: 1.2),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '\$${(product.price ?? 0).toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    color: AppTheme.primary,
                                    fontSize: 24,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Description',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description ?? 'No description available.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.6, fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Select Color',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ColorSelector(
                          colors: _availableColors,
                          selectedColor: _selectedColor,
                          onColorSelected: (color) =>
                              setState(() => _selectedColor = color),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Select Size',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizeSelector(
                          sizes: _availableSizes,
                          selectedSize: _selectedSize,
                          onSizeSelected: (size) =>
                              setState(() => _selectedSize = size),
                        ),
                        const SizedBox(height: 32),
                        PrimaryButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.title ?? 'Product'} added to cart',
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: AppTheme.primary,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  const _ProductImagePlaceholder();

  @override
  Widget build(BuildContext context) => Container(
    color: AppTheme.background,
    alignment: Alignment.center,
    child: const Icon(Icons.image_not_supported_outlined),
  );
}
