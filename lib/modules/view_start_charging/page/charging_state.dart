import 'package:flutter/material.dart';

class BillPage extends StatelessWidget {
  final String stationName = "Green EV Service Center";
  final String address = "123 Greenway Blvd, Springfield";
  final String totalChargingTime = "2 hours 30 minutes";
  final double totalAmount = 150.50;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Charging Bill',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: Container(
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
                      stationName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3AA17E),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    // Address
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Text(
                            address,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Total Charging Time
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.grey),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          "Total Charging Time: $totalChargingTime",
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
                          "Total Amount: ₹${totalAmount.toStringAsFixed(2)}",
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Charging Started")),
                            );
                          },
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Charging Ended")),
                            );
                          },
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
      ),
    );
  }
}
