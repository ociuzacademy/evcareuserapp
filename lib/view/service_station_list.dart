import 'package:ev_booking/view/product_list.dart';
import 'package:ev_booking/view/service_list.dart';
import 'package:flutter/material.dart';

class ServiceStation extends StatelessWidget {
  final List<Map<String, dynamic>> serviceCenters = [
    {
      "image": "assets/logo/chargingStation.jpg",
      "name": "Green EV Service Center",
      "address": "123 Greenway Blvd, Springfield",
      "openingTime": "9:00 AM - 6:00 PM",
    },
    {
      "image": "assets/logo/CarouselImage2.jpg",
      "name": "EcoFix Garage",
      "address": "456 Elm Street, Greenville",
      "openingTime": "8:30 AM - 7:30 PM",
    },
    {
      "image": "assets/logo/carouselImage1.jpg",
      "name": "Charge & Care Center",
      "address": "789 Maple Avenue, Rivertown",
      "openingTime": "10:00 AM - 8:00 PM",
    },
  ];

  ServiceStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Service Centers'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: ListView.builder(
        itemCount: serviceCenters.length,
        itemBuilder: (context, index) {
          final center = serviceCenters[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          center["image"],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              center["name"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              center["address"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                const SizedBox(width: 5),
                                Text(
                                  center["openingTime"],
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
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
      ),
    );
  }
}


