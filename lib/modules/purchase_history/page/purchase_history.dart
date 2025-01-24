import 'package:ev_booking/modules/purchase_history/model/purchase_histroy_model.dart';
import 'package:ev_booking/modules/purchase_history/service/purchase_history_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseHistoryPage extends StatelessWidget {
  

  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd/MM/yyyy");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder<List<PurchaseHistoryModel>>(
        future: purchaseHistoryService(user_id: 2),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error State
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}",),
            );
          }


          // Empty Response data array
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No service found"),
            );
          }

          List<PurchaseHistoryModel> purchaseHistory = snapshot.data!.toList();
          return ListView.builder(
          itemCount: purchaseHistory.length,
          itemBuilder: (context, index) {
            final item = purchaseHistory[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailItem('Quantity', item.quantity!.toString(),),
                        _buildDetailItem('Price', item.price!),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildDetailItem('Date', dateFormat.format(item.date!) ),
                    const SizedBox(height: 8),
                    _buildDetailItem('Service Center', item.serviceCentre!.toString()),
                  ],
                ),
              ),
            );
          },
        );
        }
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
