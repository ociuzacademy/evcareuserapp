

import 'package:ev_booking/modules/view_charging_history/model/charging_status_model.dart';
import 'package:ev_booking/modules/view_charging_history/service/charging_status_service.dart';

import 'package:ev_booking/modules/view_start_charging/page/charging_state.dart';
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
      body: FutureBuilder<List<ViewChargingStationModel>>(
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
              child: Column(
                children: [
                  Image.asset('assets/logo/error.jpg'),
                  Text("Error: ${snapshot.error}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            );
          }

          // Empty Response
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No services found"),
            );
          }

          //final item = snapshot.data!;
          List<ViewChargingStationModel> item = snapshot.data!.toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                final service = item[index];
                //final b_id=service.id;
              

                return GestureDetector(
                  onTap: () {
                    // Navigate to the details page for the specific service
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillPage(booking_history_id: service.id ?? 0), 

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
                            service.chargingStationName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Starting Time : ${service.startTime!}',
                            style: const TextStyle(
                              color: Color(0xFF3AA17E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Booked Date : ${service.bookingDate!}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                           const SizedBox(width: 8),
                          Text(
                            'Repair Cost: ₹${service.amount!}',
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

