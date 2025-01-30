
import 'package:ev_booking/modules/user_profile_vehicle/service/vehicle_profile_service.dart';
import 'package:flutter/material.dart';

class VehicleProfilePage extends StatelessWidget {
  const VehicleProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details '),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder(
        future: vehicleProfileService(user_id: 2), 
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


          // Empty Response data array
          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return const Center(
          //     child: Text("No service found"),
          //   );
          // }


          // Extract data
          final vehicle = snapshot.data!;

          //final services = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personal Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProfileCard([
                _buildProfileRow("Brand", vehicle.brand!),
                _buildProfileRow("Model", vehicle.model!),
                _buildProfileRow("VIN", vehicle.vin!),
                _buildProfileRow("Registration Number", vehicle.registrationNum!),
              ]),

                const SizedBox(height: 20),
              
          
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(List<Widget> rows) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: rows,
        ),
      ),
    );
  }

  Widget _buildProfileRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
