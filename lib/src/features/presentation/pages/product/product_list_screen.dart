import 'dart:async';
import 'package:e_comm/src/core/routes/route_path.dart';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/features/data/product_list_model.dart';
import 'package:e_comm/src/features/domain/cubit/product/product_cubit.dart';
import 'package:e_comm/src/features/domain/cubit/product/product_state.dart';
import 'package:e_comm/src/features/presentation/widgets/custom_widget.dart';
import 'package:e_comm/src/features/presentation/widgets/loading_widget.dart';
import 'package:e_comm/src/features/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductListModel> productsList = [];
  List<ProductListModel> allProducts = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _sortOrder = 'lowToHigh';

  List<String> sortOptions = ['Price: Low to High', 'Price: High to Low'];
  String selectedOption = "";

  @override
  void initState() {
    super.initState();
    selectedOption = sortOptions[0];
    context.read<ProductCubit>().getProductList();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        productsList = allProducts
            .where(
              (product) => product.title.toString().toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
        _sortProducts();
      });
    });
  }

  void _sortProducts() {
    setState(() {
      if (_sortOrder == 'lowToHigh') {
        productsList.sort((a, b) => a.price.compareTo(b.price));
      } else {
        productsList.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void showSortDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0),
            topRight: Radius.circular(2.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: sortOptions.map((option) {
            final isSelected = option == selectedOption;
            return ListTile(
              title: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              tileColor: isSelected ? Colors.deepPurple : Colors.white,
              // 🔁 Change this color
              onTap: () {
                setState(() {
                  selectedOption = option;
                  Navigator.pop(context);
                });
                // Trigger sort logic here
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).primaryColorDark,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            GoRouter.of(context).pop();
          },
        ),
        title: Text(
          'Products',
          style: CustomWidget(context: context).CustomSizedTextStyle(
            16.0,
            Theme.of(context).focusColor,
            FontWeight.w600,
            'FontRegular',
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return LoadingDialog.widget();
          } else if (state is ProductListSucceed) {
            allProducts = state.response;
            productsList = productsList.isEmpty ? allProducts : productsList;

            return Container(
              height: ConstantValues.height(context),
              width: ConstantValues.width(context),
              color: CustomTheme.of(context).primaryColorDark,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: CustomTheme.of(
                          context,
                        ).splashColor.withOpacity(0.5),
                        border: Border.all(color: Color(0xFFD8DFE8)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width,

                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 10.0),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                                16.0,
                                CustomTheme.of(context).focusColor,
                                FontWeight.w400,
                                'FontRegular',
                              ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomTheme.of(context).shadowColor,
                            hintText: 'Search',
                            hintStyle: CustomWidget(context: context)
                                .CustomSizedTextStyle(
                                  14.0,
                                  Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.5),
                                  FontWeight.w400,
                                  'FontRegular',
                                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => showSortDropdown(context),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: CustomTheme.of(context).shadowColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedOption,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CustomTheme.of(context).primaryColor,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8.0),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: productsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 6,
                          ),
                      itemBuilder: (context, index) {
                        final product = productsList[index];
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoute.productdetails.name,
                              extra: {"details": productsList[index]},
                            );
                          },
                          child: ProductCard(
                            imageUrl: product.image as String,
                            title: product.title as String,
                            price: product.price,
                            originalPrice: product.price + product.price / 2,
                            discount: product.rating?.rate ?? 0.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          else if (state is ProductDBListSucceed) {
            productsList = state.response
                .map(
                  (e) => ProductListModel(
                id: e.id,
                title: e.title,
                price: double.tryParse(e.price) ?? 0.0,
                description: e.description,
                category: e.category,
                image: e.image,
                rating: Rating(
                  rate: double.tryParse(e.rate) ?? 0.0,
                  count: int.tryParse(e.count) ?? 0,
                ),
              ),
            )
                .toList();
            return Container(
              height: ConstantValues.height(context),
              width: ConstantValues.width(context),
              color: CustomTheme.of(context).primaryColorDark,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: CustomTheme.of(
                          context,
                        ).splashColor.withOpacity(0.5),
                        border: Border.all(color: Color(0xFFD8DFE8)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width,

                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 10.0),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                            16.0,
                            CustomTheme.of(context).focusColor,
                            FontWeight.w400,
                            'FontRegular',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: CustomTheme.of(context).shadowColor,
                            hintText: 'Search',
                            hintStyle: CustomWidget(context: context)
                                .CustomSizedTextStyle(
                              14.0,
                              Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.5),
                              FontWeight.w400,
                              'FontRegular',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => showSortDropdown(context),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                            vertical: 5.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: CustomTheme.of(context).shadowColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedOption,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: CustomTheme.of(context).primaryColor,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8.0),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: productsList.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) {
                        final product = productsList[index];
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                              AppRoute.productdetails.name,
                              extra: {"details": productsList[index]},
                            );
                          },
                          child: ProductCard(
                            imageUrl: product.image as String,
                            title: product.title as String,
                            price: product.price,
                            originalPrice: product.price + product.price / 2,
                            discount: product.rating?.rate ?? 0.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return LoadingDialog.widget();
        },
      ),
    );
  }
}
