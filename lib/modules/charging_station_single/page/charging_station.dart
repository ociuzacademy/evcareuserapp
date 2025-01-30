import 'package:ev_booking/modules/charging_station_single/model/single_station_model.dart';
import 'package:ev_booking/modules/charging_station_single/service/response_station_service.dart';
import 'package:ev_booking/modules/charging_station_single/service/single_station_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ServiceStationBookingPage extends StatefulWidget {
  final String charging_station_id;
  const ServiceStationBookingPage(
      {super.key, required this.charging_station_id});

  @override
  _ServiceStationBookingPageState createState() =>
      _ServiceStationBookingPageState();
}

class _ServiceStationBookingPageState extends State<ServiceStationBookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedConnector;
  int? selectedTimeslot;

  // void _submitForm() {
  //   if (selectedConnector == null || selectedTimeslot == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Please select a connector type and a time slot."),
  //         backgroundColor: Colors.black,
  //       ),
  //     );
  //     return;
  //   }

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("Booking confirmed for $selectedConnector at $selectedTimeslot"),
  //       backgroundColor: Colors.green,
  //     ),
  //   );
  // }

  Future<void> _submitForm() async {
    if (selectedConnector == null || selectedTimeslot == null) {
      try {
        final responseMessage = await bookSlotService(
          connector: selectedConnector.toString(),
          slot_id: selectedTimeslot ?? 0,
          user_id: int.parse("2"),
        );
        if (responseMessage.status == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Slot Booking confirmed')),
            );
            Navigator.pop(
              context,
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(responseMessage.message ?? "Unkown error")),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Slot Booking failed: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Service Station',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder<SingleChargingStationModel>(
        future: singleChargingStationService(
            charging_station_id: widget.charging_station_id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/error.jpg',
                    width: 60,
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

          // Ensure that data is available
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No service found"),
            );
          }

          final serviceCenter = snapshot.data!;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 172, 228, 209), Color(0xFFD8E8E4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Center Info
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              "https://vqp6fbbv-8001.inc1.devtunnels.ms/${serviceCenter.image}",
                              height: screenHeight * 0.25,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  serviceCenter.name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3AA17E),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.grey),
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      '${serviceCenter.address!.split(' ').take(4).join(' ')}...',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Select Connector Type
                    const Text(
                      "Select Connector Type",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: selectedConnector,
                      items: serviceCenter.connectors!.map((String connector) {
                        return DropdownMenuItem<String>(
                          value: connector,
                          child: Text(connector),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedConnector = value;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Please select a connector type'
                          : null,
                      hint: const Text("Select Connector"),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Available Time Slots
                    const Text(
                      "Select Time Slot",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: screenWidth * 0.02,
                        mainAxisSpacing: screenHeight * 0.01,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: serviceCenter.slots!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: serviceCenter.slots![index].isBooked!
                              ? null
                              : () {
                                  setState(() {
                                    selectedTimeslot = int.tryParse(
                                            serviceCenter.slots![index].id
                                                .toString()) ??
                                        0;
                                    print(
                                        "Selected Timeslot ID: $selectedTimeslot"); // Debugging line
                                  });
                                },
                          child: Container(
                            decoration: BoxDecoration(
                              color: serviceCenter.slots![index].isBooked!
                                  ? Colors.grey
                                  : selectedTimeslot ==
                                          serviceCenter.slots![index].id
                                      ? const Color(0xFF3AA17E)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              serviceCenter.slots![index].startTime ?? 'N/A',
                              style: TextStyle(
                                color: serviceCenter.slots![index].isBooked!
                                    ? Colors.black38
                                    : selectedTimeslot ==
                                            serviceCenter.slots![index].id
                                        ? Colors.white
                                        : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    Center(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3AA17E),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
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
  }
}
