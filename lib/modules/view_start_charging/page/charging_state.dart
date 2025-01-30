import 'package:ev_booking/modules/view_start_charging/model/charging_state_model.dart';
import 'package:ev_booking/modules/view_start_charging/service/charging_state_service.dart';
import 'package:ev_booking/modules/view_start_charging/service/reponse_stop_service.dart';
import 'package:ev_booking/modules/view_start_charging/service/response_start_state.dart';
import 'package:flutter/material.dart';

class BillPage extends StatefulWidget {
  final int booking_history_id;
  const BillPage({super.key, required this.booking_history_id});

  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {



  // void _startCharging() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Charging Started")),
  //   );
  // }

  // void _endCharging() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Charging Ended")),
  //   );
  // }


    Future<void> _startCharging()async{
    try {
        final responseMessage = await startChargingService(
         bookingHistoryId: widget.booking_history_id.toString(),

        );
       // print(responseMessage);

        if (responseMessage.status == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Start Charging')),
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
            SnackBar(content: Text(' Failed to charge : $e')),
          );
        }
      }
  }

  Future<void> _endCharging()async{
    try {
        final responseMessage = await stopChargingService(
           bookingHistoryId: widget.booking_history_id.toString(),

        );
       // print(responseMessage);

        if (responseMessage.status == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('stop Charging')),
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
            SnackBar(content: Text(' Failed to stop : $e')),
          );
        }
      }
  }



  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Charging Time',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder<SingleChargingStationBillModel>(
        future: bookingService(booking_id: widget.booking_history_id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Handle Error
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Image.asset('assets/logo/error.jpg'),
                  Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          // Ensure Data Exists
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No data available"),
            );
          }

          final item = snapshot.data!; // Get data safely

          // RETURN THE CONTAINER
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 172, 228, 209), Color(0xFFD8E8E4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Charging Station Name
                        Text(
                          item.chargingStationName ?? "Unknown Station",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3AA17E),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),

                        // Booking Date
                        Row(
                          children: [
                            const Icon(Icons.timelapse, color: Colors.grey),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                item.startTime?.toString() ?? "No Date",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Total Charging Amount
                        Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.grey),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              "Date: ${item.bookingDate ?? 0}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        // Total Amount
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.grey),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              "Total Amount: ₹${item.amount ?? 0}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.04),

                        // Buttons
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: (item.chargingStatus == "Charging Started" || 
                                        item.chargingStatus == "Charging Completed")
                                ? null // Disable button
                                : _startCharging, // Enable button only if status allows
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3AA17E),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.015,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Charging Started",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (item.chargingStatus == "pending" || 
                                        item.chargingStatus == "Charging Completed")
                                ? null // Disable button
                                : _endCharging, // Enable button only if status allows
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFDC3545),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.015,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Charging Ended",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ); // Now returning the correct widget
        },
      ),
    );
  }
}
