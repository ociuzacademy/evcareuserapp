import 'package:ev_booking/modules/service_list/page/service_list.dart';
import 'package:ev_booking/modules/service_center/page/service_station_list.dart';
import 'package:ev_booking/modules/signup/pages/signup.dart';
import 'package:ev_booking/view/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ServiceHomePage extends StatelessWidget {
  ServiceHomePage({super.key});

  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // Height of the AppBar
        child: ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: AppBar(
            toolbarHeight: 100.0,
            backgroundColor: const Color.fromARGB(255, 57, 190, 47),
            leading: IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                // Use the GlobalKey to open the drawer
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            title: SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Notifications clicked!")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 57, 190, 47)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text('Welcome..John Doe',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color.fromARGB(255, 57, 190, 47)),
              title: const Text('My Account'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Color.fromARGB(255, 57, 190, 47)),
              title: const Text('Charging History'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Color.fromARGB(255, 57, 190, 47)),
              title: const Text('Preferred Locations'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined, color: Color.fromARGB(255, 57, 190, 47)),
              title: const Text('My Bookings'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.miscellaneous_services, color: Color.fromARGB(255, 57, 190, 47)),
              title: const Text('Services'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ServiceList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_mark_rounded, color: Color.fromARGB(255, 57, 190, 47)),
              title: const Text('Help and Support'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
            const SizedBox(height: 90,),
            const Divider(), // Divider between main content and bottom links
            // Adding the links to Privacy Policy and Terms & Conditions
            ListTile(
              title: const Text('Sign Out', textAlign: TextAlign.center),
              onTap: () {
                // Navigate to the Privacy Policy page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Terms and Conditions', textAlign: TextAlign.center),
              onTap: () {
                // Navigate to the Terms and Conditions page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'List all stations',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const StatusView(),));
        },
        tooltip: 'View Status',
        backgroundColor:const Color.fromARGB(255, 57, 190, 47),
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

