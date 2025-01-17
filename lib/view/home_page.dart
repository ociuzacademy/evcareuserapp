import 'package:ev_booking/modules/vehicleRegistration/pages/vehicle_register.dart';
import 'package:ev_booking/view/evcharging_station_list.dart';
import 'package:ev_booking/view/service_confirm.dart';
import 'package:ev_booking/view/service_station_list.dart';
import 'package:ev_booking/view/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  _UserHomePageState createState() => _UserHomePageState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 74, 203, 160), Color.fromARGB(255, 230, 244, 241)],
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
                  const SizedBox(height: 40),
              
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.easeInOut,
                      aspectRatio: 16 / 9,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                    items: imageUrls.map((url) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
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
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            url,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to EV CARE',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
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
                   const SizedBox(height: 40),
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
                            MaterialPageRoute(builder: (context) => ServiceStation()),
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

                  // Registration Link
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => const EVRegistrationForm()), // Replace with your AddVehiclePage
                  //         );
                  //       },
                  //       child: Container(
                  //         width: 160,
                  //         height: 120,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(12),
                  //           boxShadow: const [
                  //             BoxShadow(
                  //               color: Colors.black26,
                  //               blurRadius: 6,
                  //               spreadRadius: 2,
                  //               offset: Offset(2, 4),
                  //             ),
                  //           ],
                  //         ),
                  //         child: const Center(
                  //           child: Text(
                  //             'Add Vehicle',
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //             ),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),


                ],
              ),
              // Service station Page
               ServiceStation(),

              // Charging station Page
               EVChargingStationList(),

              // Profile Page
              const ProfilePage(),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EVRegistrationForm()), // Replace with your page
        );
      },
      tooltip: 'Add vehicle',
      backgroundColor: const Color.fromARGB(255, 248, 251, 251),
      child: const Icon(Icons.add, size: 30, color: Color(0xFF3AA17E)),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    
   
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services,size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electrical_services,size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,size: 30,),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: const Color(0xFF3AA17E),
        unselectedItemColor: const Color.fromARGB(255, 20, 19, 19),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required String title, required String image, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                width: 140,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
