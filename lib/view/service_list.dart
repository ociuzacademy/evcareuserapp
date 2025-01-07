import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({super.key});

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  // List of services
  final List<Map<String, dynamic>> services = [
    {'name': 'Maintenance and Repair', 'amount': 2000, 'time': '2 day'},
    {'name': 'Emergency Roadside Assistance', 'amount': 3000, 'time': '5 hour'},
    {'name': 'Customization and Upgrades', 'amount': 5000, 'time': '3 day'},
    {'name': 'cleaning Service', 'amount': 300, 'time': '30 mins'},
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
        totalAmount -= services[index]['amount'] as int ;
      } else {
        totalAmount += services[index]['amount'] as int ;
      }
      selectedServices[index] = !selectedServices[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Services'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(services[index]['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        'Time: ${services[index]['time']}\nAmount: ₹${services[index]['amount']}',
                        style: const TextStyle(height: 1.5)),
                    trailing: Icon(
                      selectedServices[index]
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: Colors.green,
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
              width:200,
              child: ElevatedButton(
                onPressed: totalAmount > 0
                    ? () {
                        // Handle the continue action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Total Amount: ₹$totalAmount'),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Continue (₹$totalAmount)',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}