import 'package:ev_booking/modules/products/model/productlist.dart';
import 'package:ev_booking/modules/single_product/service/buy_product_service.dart';
import 'package:ev_booking/modules/single_product/service/single_product_service.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String product_id;

  const ProductDetailPage({
    super.key,
    required this.product_id,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  late Future<dynamic> singleProductFuture;

  @override
  void initState() {
    super.initState();
    singleProductFuture = singleProductList(product_id: widget.product_id);
  }

  Future<void> _buyProduct()async{
    try {
        final responseMessage = await buyProductService(
          user_id:"2",
         product_id: widget.product_id,
         quantity: quantity,
        );
       // print(responseMessage);

        if (responseMessage.status == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product Purchased')),
            );
            Navigator.pop(
              context,
              
            );
          }
         
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseMessage.message??"Unkown error")),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product purchase failed: $e')),
          );
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3AA17E),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: singleProductFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Image.asset('assets/logo/error.jpg'),
                  Text("Error: ${snapshot.error}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No service found"));
          }

          final singleitem = snapshot.data;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://vqp6fbbv-8001.inc1.devtunnels.ms/${singleitem?.image}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product Name
                  Text(
                    singleitem?.name ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product Description
                  Text(
                    singleitem?.description ?? 'No Description Available',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Product Price
                  Text(
                    'Price: ₹${double.parse(singleitem?.price) * quantity}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3AA17E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quantity Selector
                  _buildQuantitySelector(),
                  const SizedBox(height: 24),
                  // Buttons
                  Row(
                    children: [
                      // Expanded(
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       print('Add to Cart');
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: const Color(0xFF3AA17E),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(vertical: 16),
                      //     ),
                      //     child: const Text(
                      //       'Add to Cart',
                      //       style: TextStyle(fontSize: 16, color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _buyProduct,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Quantity:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (quantity > 1) quantity--;
                });
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              quantity.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
