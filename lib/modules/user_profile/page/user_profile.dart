import 'package:ev_booking/modules/user_profile/service/user_profile_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: FutureBuilder(
        future: userProfileService(user_id: 2), 
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
          final userProfile = snapshot.data!;

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
                  _buildProfileRow("Name", userProfile.name!),
                  _buildProfileRow("Username", userProfile.username! ?? "N/A"),
                  _buildProfileRow("Phone", userProfile.phone ?? "N/A"),
                  _buildProfileRow("Email", userProfile.email ?? "N/A"),
                ]),
                const SizedBox(height: 20),
                const Text(
                  "Vehicle Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProfileCard([
                _buildProfileRow("Brand", "Tesla"),
                _buildProfileRow("Model", "Model S"),
                _buildProfileRow("VIN", "1HGCM82633A123456"),
                _buildProfileRow("Registration Number", "AB123CD"),
              ]),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logic to handle API calls or edit functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Save button pressed")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3AA17E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
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
