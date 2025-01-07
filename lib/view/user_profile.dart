import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example user details
    const String name = "Manu C S";
    const String email = "manucs@gmail.com";
    const String phoneNumber = "+1 234 567 890";
    const String vehicleModel = "Tesla Model 3";
    const String registrationNumber = "AB-1234";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3AA17E),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3AA17E), Color(0xFFD8E8E4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/logo/profile_placeholder.png'),
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      _buildProfileDetail("Name", name),
                      _buildDivider(),
                      _buildProfileDetail("Email", email),
                      _buildDivider(),
                      _buildProfileDetail("Phone Number", phoneNumber),
                      _buildDivider(),
                      _buildProfileDetail("Vehicle Model", vehicleModel),
                      _buildDivider(),
                      _buildProfileDetail("Registration Number", registrationNumber),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to an edit details form or execute edit logic
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: const Text("Edit Profile"),
                          //       content: const Text(
                          //           "Edit functionality can be implemented here."),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () => Navigator.pop(context),
                          //           child: const Text("Close"),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3AA17E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                        child: const Text(
                          "Edit Details",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
      height: 16,
    );
  }
}
