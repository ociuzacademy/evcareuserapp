import 'package:ev_booking/constants/urls.dart';
import 'package:ev_booking/modules/products/model/productlist.dart';
import 'package:ev_booking/modules/products/service/product_list_service.dart';
import 'package:ev_booking/modules/single_product/page/single_product.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final int service_center_id;
  const ProductListPage({super.key,
  required this.service_center_id});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<SingleProductListModel>>(
          future: productList(service_centre_id:service_center_id.toString() ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Image.asset('assets/logo/error.jpg'),
                  Text("Error: ${snapshot.error}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            );
          }


            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Image.asset('assets/logo/no service.jpg'),
                    const Text("No products found",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
              );
            }

            List<SingleProductListModel> products = snapshot.data!.toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.75, // Adjust the aspect ratio for card size
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return _buildProductCard(context, product, screenWidth, screenHeight);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, SingleProductListModel product, double screenWidth, double screenHeight) {
    final imageWidth = screenWidth * 3; // 40% of screen width
    final imageHeight = imageWidth; // Make it square

    return GestureDetector(
      onTap: () 
           {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => ProductDetailPage(product_id: product.id?.toString() ?? '0'),

              
              ),
              );
           },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://vqp6fbbv-8001.inc1.devtunnels.ms/${product.image}",
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/icons/image.png',
                            width: imageWidth,
                            height: imageHeight,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
              product.name!.length > 20
                  ? '${product.name!.substring(0, 20)}...' // Show first 15 characters
                  : product.name!, // Show full name if shorter
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

              const SizedBox(height: 4),
              Text(
                product.description!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '₹${product.price!}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3AA17E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
