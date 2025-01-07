// import 'package:ev_booking/view/login_page.dart';
// import 'package:flutter/material.dart';

// class IntroductionScreen extends StatefulWidget {
//   const IntroductionScreen({super.key});

//   @override
//   _IntroductionScreenState createState() => _IntroductionScreenState();
// }

// class _IntroductionScreenState extends State<IntroductionScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // PageView for slides
//           PageView(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             children: [
//               _buildPage(
//                 imagePath: 'assets/logo/intro1.jpg',
//                 title: 'Find Charging Stations',
//                 description: 'Locate the nearest charging stations with ease.',
//               ),
//               _buildPage(
//                 imagePath: 'assets/logo/intro2.jpg',
//                 title: 'Schedule Charging',
//                 description: 'Book a slot in advance for hassle-free charging.',
//               ),
//               _buildPage(
//                 imagePath: 'assets/logo/intro3..jpg',
//                 title: 'Track Your EV',
//                 description: 'Monitor your EV’s status and battery life.',
//               ),
//             ],
//           ),
//           // Dots Indicator
//           Positioned(
//             bottom: screenHeight * 0.1,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 3,
//                 (index) => _buildDot(index == _currentPage),
//               ),
//             ),
//           ),
//           // "Get Started" Button
//           if (_currentPage == 2)
//             Positioned(
//               bottom: screenHeight * 0.05,
//               right: screenWidth * 0.05,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(
//                     vertical: screenHeight * 0.01,
//                     horizontal: screenWidth * 0.01,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   backgroundColor: const Color.fromARGB(255, 22, 144, 85)
//                 ),
//                 child: const Text(
//                   'Start',
//                   style: TextStyle(fontSize: 15,color: Colors.black),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   // Helper Widget to build each page
//   Widget _buildPage(
//       {required String imagePath, required String title, required String description}) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(imagePath, height: screenHeight * 0.3),
//         const SizedBox(height: 30),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 22, 144, 85),
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 15),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Text(
//             description,
//             style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 22, 144, 85)),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }

//   // Helper Widget to build dots indicator
//   Widget _buildDot(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       margin: const EdgeInsets.symmetric(horizontal: 5),
//       height: 10,
//       width: isActive ? 20 : 10,
//       decoration: BoxDecoration(
//         color: isActive ? const Color.fromARGB(255, 22, 144, 85) : Colors.grey,
//         borderRadius: BorderRadius.circular(5),
//       ),
//     );
//   }
// }

// // Replace HomePage with your actual app's main screen
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text('Welcome to EV Booking App!')),
//     );
//   }
// }
