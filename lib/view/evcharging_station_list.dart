import 'package:ev_booking/view/charging_station.dart';
import 'package:ev_booking/view/single_charging_station.dart';
import 'package:flutter/material.dart';

class EVChargingStationList extends StatelessWidget {
  final List<Map<String, dynamic>> stations = [
    {
      "image": "assets/logo/carouselImage1.jpg",
      "name": "FastCharge EV Station",
      "address": "123 Greenway Drive, Springfield",
      "time": "24/7",
      "connectors": "Type 2, CCS, CHAdeMO",
      "rate": "₹5/min",
      "capacity": "150 kW"
    },
    {
      "image": "assets/logo/CarouselImage2.jpg",
      "name": "EcoCharge Hub",
      "address": "456 Elm Street, Greenville",
      "time": "6:00 AM - 10:00 PM",
      "connectors": "Type 2, CCS",
      "rate": "₹4/min",
      "capacity": "120 kW"
    },
    {
      "image": "assets/logo/CarouselImage3.jpg",
      "name": "PowerUp Station",
      "address": "789 Maple Avenue, Rivertown",
      "time": "8:00 AM - 8:00 PM",
      "connectors": "CHAdeMO, CCS",
      "rate": "₹6/min",
      "capacity": "100 kW"
    },
  ];

  EVChargingStationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Charging Stations'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const ServiceStationBookingPage()),
            );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Image.asset(
                      station["image"],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station["name"],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            station["address"],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text(
                                station["time"],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Connectors: ${station["connectors"]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Rate: ${station["rate"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3AA17E),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Text(
                                "Capacity: ${station["capacity"]}",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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


