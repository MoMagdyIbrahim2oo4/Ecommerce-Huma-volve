import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/categories/categories_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/cubit/products/product_cubit.dart';
import 'package:flutter/material.dart';

import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  bool _didLoadInitialProducts = false;
  bool _isLoadingMore = false;
  int? _selectedCategoryId;
  late final ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories();
    scrollController = ScrollController();
    scrollController.addListener(_loadMore);
  }

  void _loadMore() {
    if (!scrollController.hasClients || _selectedCategoryId == null) return;
    final position = scrollController.position;
    const trigger = 200.0;
    if (position.extentAfter <= trigger && !_isLoadingMore) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    final categoryId = _selectedCategoryId;
    if (categoryId == null || _isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    try {
      await context.read<ProductCubit>().loadMoreProducts(categoryId);
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_loadMore)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: AppTheme.primary,
                          ),
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.network(
                              dummyUser.profilePictureUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Explore',
                      style: Theme.of(context).textTheme.displayLarge
                          ?.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Best trendy collection!',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search clothes...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocConsumer<CategoriesCubit, CategoriesState>(
                      listener: (context, state) {
                        if (state is CategoriesCubitSuccess &&
                            !_didLoadInitialProducts &&
                            state.data.isNotEmpty) {
                          _didLoadInitialProducts = true;
                          final categoryId = state.data.first.id;
                          if (categoryId != null) {
                            _selectedCategoryId = categoryId;
                            context.read<ProductCubit>().getProducts(categoryId);
                          }
                        }
                      },
                      builder: (context, state) {
                        switch (state) {
                          case CategoriesCubitInitial():
                          case CategoriesCubitLoading():
                            return Center(child: CircularProgressIndicator());
                          case CategoriesCubitFailure():
                            return Center(child: Text(state.errorMessage));
                          case CategoriesCubitSuccess():
                            final categories = state.data;
                            if (categories.isEmpty) {
                              return const Center(child: Text('No categories found'));
                            }
                            return SizedBox(
                              height: 44,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  return CategoryChip(
                                    label: categories[index].name ?? "Unkown",
                                    isSelected: _selectedCategoryIndex == index,
                                    onTap: () {
                                      setState(() {
                                        _selectedCategoryIndex = index;
                                        _selectedCategoryId = categories[index].id;
                                      });
                                      final categoryId = categories[index].id;
                                      if (categoryId != null) {
                                        context.read<ProductCubit>().getProducts(categoryId);
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                switch (state) {
                  case ProductCubitInitial():
                    return SliverToBoxAdapter(
                      child: SizedBox.shrink()
                    );
                  case ProductCubitLoading():
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case ProductCubitFailure():
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.errorMessage,style: TextStyle(color: Colors.red),)),
                    );
                  case ProductCubitSuccess():
                    final products = state.data;
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ProductCard(product: products[index]),
                          childCount: products.length,
                        ),
                      ),
                    );
                }
              },
            ),
            if (_isLoadingMore)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               sliver: SliverGrid(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.7,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 delegate: SliverChildBuilderDelegate((context, index) {
//                   return ProductCard(product: dummyProducts[index]);
//                 }, childCount: dummyProducts.length),
//               ),
//             ),
