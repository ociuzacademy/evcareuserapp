import 'package:ev_booking/modules/login/service/login_service.dart';
import 'package:ev_booking/view/home_page.dart';
import 'package:ev_booking/modules/signup/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:ev_booking/constants/urls.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  Future<void> _loginUser() async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final responseMessage = await UserLogin(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );
       // print(responseMessage);

        if (responseMessage.status == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const UserHomePage(),
              ),
            );
          }
         
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseMessage.message??"Unkown error")),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3AA17E), Color(0xFFD8E8E4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Foreground content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo
                  Container(
                    width: screenWidth * 0.35,
                    height: screenWidth * 0.35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Welcome text
                  const Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF176A4D),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Form for username and password
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Username field
                        _buildTextField(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.account_circle,
                          
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Password field
                        _buildTextField(
                          controller: _passwordController,
                          icon: Icons.lock,
                          label: 'Password',
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176A4D),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5,
                      ),
                      onPressed: _loginUser,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sign-up and Forgot Password links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [                    
                      TextButton(
                        onPressed: () {
                          // Forgot password functionality
                        },
                        child: const Text(
                          '',
                          style: TextStyle(
                            color: Color(0xFF176A4D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const 
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF176A4D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    bool isPassword = false,
    
  }) {
    return TextFormField(
      controller: controller,
       obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF176A4D)),
          suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF176A4D),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF176A4D)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Color(0xFF176A4D), width: 2.0),
        ),
      ),
      validator: validator,
    );
  }
}
