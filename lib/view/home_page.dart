import 'package:ev_booking/modules/vehicleRegistration/pages/vehicle_register.dart';
import 'package:ev_booking/view/evcharging_station_list.dart';
import 'package:ev_booking/modules/service_center/page/service_station_list.dart';
import 'package:ev_booking/modules/user_profile/page/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fab_speed_dial/fab_speed_dial.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<String> imageUrls = [
    'assets/logo/carouselImage1.jpg',
    'assets/logo/CarouselImage2.jpg',
    'assets/logo/CarouselImage3.jpg',
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 74, 203, 160),
                  Color.fromARGB(255, 230, 244, 241),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              // Home Page
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: screenHeight * 0.35,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.easeInOut,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                    items: imageUrls.map((url) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          child: Image.asset(
                            url,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Column(
                      children: [
                        const Text(
                          'Welcome to EV CARE',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Explore our services and EV charging stations with ease.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureCard(
                        context,
                        title: 'Service Station',
                        image: 'assets/icons/service.jpeg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ServiceStation()),
                          );
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        title: 'EV Charging',
                        image: 'assets/logo/chargingStation.jpg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EVChargingStationList()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const ServiceStation(),
              EVChargingStationList(),
              const ProfilePage(),
            ],
          ),
        ],
      ),


      // floatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EVRegistrationForm()),
          );
        },
        tooltip: 'Add vehicle',
        backgroundColor: const Color.fromARGB(255, 248, 251, 251),
        child: const Icon(Icons.add, size: 30, color: Color(0xFF3AA17E)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      
      
      //BottomNavigationBar
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.miscellaneous_services, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.electrical_services, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 30), label: ''),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3AA17E),
        unselectedItemColor: const Color.fromARGB(255, 20, 19, 19),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required String title, required String image, required VoidCallback onTap}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.03),
                topRight: Radius.circular(screenWidth * 0.03),
              ),
              child: Image.asset(
                image,
                width: screenWidth * 0.35,
                height: screenWidth * 0.25,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
