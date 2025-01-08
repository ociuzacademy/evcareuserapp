import 'package:ev_booking/modules/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to generate the introduction pages
    List<PageViewModel> getPages() {
      return [
        PageViewModel(
          image: Image.asset("assets/logo/carouselImage1.jpg",fit: BoxFit.fill,),
          title: "Welcome to Our App",
          body: "Discover features designed to enhance your experience.",
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3AA17E),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            imagePadding: EdgeInsets.only(top: 20),
            pageColor:  Color.fromARGB(255, 89, 223, 178),
          ),
        ),


        PageViewModel(
          image: Image.asset("assets/logo/CarouselImage2.jpg"),
          title: "Stay Connected",
          body: "Engage and collaborate with ease using our tools.",
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3AA17E),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            imagePadding: EdgeInsets.only(top: 20),
            pageColor: Colors.white,
          ),
        ),

        PageViewModel(
          image: Image.asset("assets/logo/CarouselImage3.jpg"),
          title: "Achieve More",
          body: "Unlock your potential with our powerful features.",
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3AA17E),
            ),
            bodyTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            imagePadding: EdgeInsets.only(top: 20),
            pageColor: Colors.white,
          ),
        ),

      ];
    }

    return Scaffold(
     
      body: IntroductionScreen(
        pages: getPages(),
        onDone: () {
          // Navigate to the next page or home screen
          Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
        },
        done: const Text(
          "Done",
          style: TextStyle(
            color: Color(0xFF3AA17E),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        next: const Icon(
          Icons.arrow_forward,
          size: 24,
          color: Color(0xFF3AA17E),
        ),
        skip: const Text(
          "Skip ",
          style: TextStyle(
            color: Color(0xFF3AA17E),
            fontSize: 16,
          ),
        ),
        showSkipButton: true,
        dotsDecorator: DotsDecorator(
          size: const Size(5, 5),
          color: Colors.grey,
          activeSize: const Size(12, 12),
          activeColor: const Color(0xFF3AA17E),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        globalBackgroundColor: Colors.white,
      ),
      
    );
  }
}
