import 'package:flutter/material.dart';
import 'package:ev_booking/modules/service_list/repair_model.dart';
import 'package:ev_booking/modules/service_payment/service/payment_service.dart';
import 'package:ev_booking/modules/service_payment/service/status_respond.dart';

class ServicePaymentPage extends StatelessWidget {
  final int service_id;

  const ServicePaymentPage({super.key, required this.service_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Payment'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<SingleRepairModel>(
          future: paymentService(reairId: service_id.toString()),
          builder: (context, snapshot) {
            // Waiting state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error state
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }

            // Empty response
            if (!snapshot.hasData ||
                snapshot.data!.services == null ||
                snapshot.data!.services!.isEmpty) {
              return const Center(
                child: Text("No services found"),
              );
            }

            final repair = snapshot.data!;

            return ListView(
              children: [
                // Service Center Name
                Text(
                  'Service Center: ${repair.serviceName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),

                // Services List
                const Text(
                  'Services:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                if (repair.services != null)
                  ...repair.services!.map((service) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(service.name ?? 'No name available'),
                        subtitle: Text('Time: ${service.time ?? 'N/A'}'),
                        trailing: Text('₹${service.amount ?? 0}'),
                      ),
                    );
                  }),

                const SizedBox(height: 20),

                // Total Amount
                Text(
                  'Total Amount: ₹${repair.repairCost}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),

                // Status
                const Text(
                  'Status:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    _getStatusText(repair.status!),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),

                // Conditional Button
                ElevatedButton(
                  onPressed: repair.status == "Repair Completed"
                      ? () async {
                          try {
                            final responseMessage = await paymentServiceRespond(
                              reairId: repair.id!,
                            );

                            if (responseMessage.status == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Payment Successful')),
                              );
                              Navigator.pop(context);
                            } 
                            // else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text(responseMessage.message ??
                            //           "Unknown error"),
                            //     ),
                            //   );
                            // }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Payment failed: $e'),
                              ),
                            );
                          }
                        }
                      : (repair.status == "Vehicle Delivered"
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FeedbackPage(serviceId: repair.id!),
                                ),
                              );
                            }
                          : null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: repair.status == "Repair Completed"
                        ? const Color(0xFF3AA17E)
                        : (repair.status == "Vehicle Delivered"
                            ? Colors.blue
                            : Colors.grey),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    repair.status == "Repair Completed"
                        ? 'Make Payment'
                        : (repair.status == "Vehicle Delivered"
                            ? 'Give Feedback'
                            : 'Unavailable'),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Function to return status text based on the status
  String _getStatusText(String status) {
    switch (status) {
      case "Repair Requested":
        return "Repair Requested";
      case "Mechanic Assigned":
        return "Mechanic Assigned";
      case "Repair Completed":
        return "Repair Completed";
      case "Vehicle Delivered":
        return "Vehicle Delivered";
      default:
        return "Unknown Status";
    }
  }
}

// Feedback Page Example (Placeholder)
class FeedbackPage extends StatelessWidget {
  final int serviceId;

  const FeedbackPage({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provide feedback for Service ID: $serviceId',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            // Feedback Text Field
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                final feedback = feedbackController.text.trim();
                if (feedback.isNotEmpty) {
                  // Here you can handle the feedback submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feedback submitted successfully!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feedback cannot be empty')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3AA17E),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
