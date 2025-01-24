import 'package:ev_booking/modules/service_list/service/service_list_service.dart';
import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  final int service_center_id;

  const ServiceList({super.key,
  required this.service_center_id});

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  // List of services
  final List<Map<String, dynamic>> services = [
    {'name': 'Maintenance and Repair', 'amount': 2000, 'time': '2 day'},
    {'name': 'Emergency Roadside Assistance', 'amount': 3000, 'time': '5 hour'},
    {'name': 'Customization and Upgrades', 'amount': 5000, 'time': '3 day'},
    {'name': 'Cleaning Service', 'amount': 300, 'time': '30 mins'},
    {'name': 'Diagnostics and Troubleshooting', 'amount': 500, 'time': '30 mins'},
  ];

  List<bool> selectedServices = [];
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the selected services list with false values
    selectedServices = List.filled(services.length, false);
  }


  void toggleSelection(int index) {
    setState(() {
      if (selectedServices[index]) {
        totalAmount -= services[index]['amount'] as int;
      } else {
        totalAmount += services[index]['amount'] as int;
      }
      selectedServices[index] = !selectedServices[index];
    });
  }



  Future<void> _requestService() async {
    List<Map<String, dynamic>> filteredServices = [];
    for (int index = 0; index < services.length; index++) {
      if (selectedServices[index]) {
        filteredServices.add(services[index]);
      }
    }

    if (filteredServices.isEmpty) return; 

    try {
      final int userId = int.parse("2"); 
      final responseMessage = await serviceListRequestService(
        //brand: "EV Brand", // Replace with actual brand if needed
        user: userId,
        service: filteredServices,
        service_center_id : widget.service_center_id,


      );

      if (responseMessage.status == 'success') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Service registered successfully')),
          );
          
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseMessage.message ?? "Unknown error")),
          );
        }
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      
       AppBar(
        title: const Text('Services '),
        backgroundColor: const Color(0xFF3AA17E),
        
      ),

      
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      services[index]['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Time: ${services[index]['time']}\nAmount: ₹${services[index]['amount']}',
                      style: const TextStyle(height: 1.5),
                    ),
                    trailing: Icon(
                      selectedServices[index]
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: const Color(0xFF3AA17E),
                    ),
                    onTap: () => toggleSelection(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: totalAmount > 0 ? _requestService : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3AA17E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Continue (₹$totalAmount)',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
