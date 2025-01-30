import 'package:ev_booking/modules/service_payment/page/payment.dart';
import 'package:ev_booking/modules/status_service/model/status_service_model.dart';


import 'package:flutter/material.dart';

class ChargingStatusViews extends StatefulWidget {
  const ChargingStatusViews({super.key});

  @override
  _ChargingStatusViewsState createState() => _ChargingStatusViewsState();
}

class _ChargingStatusViewsState extends State<ChargingStatusViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Status History'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder<List<ServiceStatusModel>>(
        future: chargingStationStatusService(user_id: 2), 
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

          // Empty Response
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No services found"),
            );
          }

          final services = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to the details page for the specific service
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicePaymentPage(repair_id: service.id ?? 0),

                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.serviceName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // const Text(
                          //   'Services:',
                          //   style: TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          // if (service.services != null && service.services!.isNotEmpty) 
                          //     ...service.services!.map((item) => Padding(
                          //           padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          //           child: Text('- $item'),
                          //         )),
                          // if (service.services == null )
                          //   const Padding(
                          //     padding: EdgeInsets.only(left: 8.0, top: 4.0),
                          //     child: Text('No services available'),
                          //   ),

                          const SizedBox(height: 8),
                          Text(
                            'Repair Cost: ₹${service.repairCost!}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

