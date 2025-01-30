import 'package:ev_booking/modules/charging_station/model/charging_station_model.dart';
import 'package:ev_booking/modules/charging_station/service/charging_station_service.dart';
import 'package:ev_booking/modules/charging_station_single/page/charging_station.dart';
import 'package:flutter/material.dart';

class EVChargingStationList extends StatelessWidget {
  const EVChargingStationList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chargingStationId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Charging Stations'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: 
      
      FutureBuilder<List<ChargingStationModel>>(
        future: chargingStationList(),
        builder: (context, snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error State
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/error.jpg',
                    width: size.width * 0.6,
                  ),
                  Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Empty Response
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No service found"),
            );
          }

          final stations = snapshot.data!;

          return ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              final station = stations[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ServiceStationBookingPage(charging_station_id:station.id.toString()),//ServiceStationBookingPage(charging_station_id:station.id.toString()),
                    ),
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
                    
                        child: Image.network(
                          "https://vqp6fbbv-8001.inc1.devtunnels.ms/${station.image}" ?? 'assets/icons/image.png',
                          width: size.width * 0.2,
                          height: size.width * 0.2,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/icons/image.png',
                              width: size.width * 0.2,
                              height: size.width * 0.2,
                              fit: BoxFit.cover,
                            );
                          },
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
                                station.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                station.address!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    station.workingHours!,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Connectors: ${station.connectors!.join(', ')}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Rate: ${station.ratePerMinute}/ hour",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3AA17E),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Capacity: ${station.capacity!} kW",
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
          );
        },
      ),
    );
  }
}
