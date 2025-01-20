import 'package:ev_booking/modules/service_center/model/service_center_model.dart';
import 'package:ev_booking/modules/service_center/service/service_station_service.dart';
import 'package:ev_booking/modules/products/page/product_list.dart';
import 'package:ev_booking/view/service_list.dart';
import 'package:flutter/material.dart';

class ServiceStation extends StatelessWidget {
  const ServiceStation({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Service Centers'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder<List<ServiceCentreModel>>(
        future: serviceCentreList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error State
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          // Empty Response data array
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No service found"),
            );
          }

          List<ServiceCentreModel> servicelists = snapshot.data!.toList();
          return ListView.builder(
            itemCount: servicelists.length,
            itemBuilder: (context, index) {
              final center = servicelists[index];
              return Card(
                margin: EdgeInsets.all(screenWidth * 0.03), // Responsive margin
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(10),
                          //   child: Image.network(
                          //     center.image ?? 'assets/icons/image.png',
                          //      //center.image,
                          //     width: screenWidth * 0.2, // Responsive width
                          //     height: screenWidth * 0.2, // Responsive height
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          SizedBox(width: screenWidth * 0.03), // Responsive spacing
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  center.name!,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05, // Responsive text size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01), // Responsive spacing
                                Text(
                                  center.address!,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035, // Responsive text size
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01), // Responsive spacing
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                    SizedBox(width: screenWidth * 0.02), // Responsive spacing
                                    Text(
                                      center.workingHours!,
                                      style: TextStyle(fontSize: screenWidth * 0.035), // Responsive text size
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02), // Responsive spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle Get Service Access action
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const ServiceList()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3AA17E),
                            ),
                            icon: const Icon(Icons.car_repair),
                            label: const Text("Get Service Access"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle Buy Products action
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListPage(),));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text("Buy Products"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
