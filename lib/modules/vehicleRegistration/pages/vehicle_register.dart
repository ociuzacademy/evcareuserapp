import 'package:ev_booking/modules/vehicleRegistration/service/vehicle_reg_service.dart';
import 'package:ev_booking/utils/preference_values.dart';
import 'package:ev_booking/view/home_page.dart';
import 'package:flutter/material.dart';

class EVRegistrationForm extends StatefulWidget {
  const EVRegistrationForm({super.key});

  @override
  State<EVRegistrationForm> createState() => _EVRegistrationFormState();
}

class _EVRegistrationFormState extends State<EVRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _vinController = TextEditingController();
  final TextEditingController _registrationController = TextEditingController();

  final Map<String, Map<String, List<String>>> _vehicleData = {
    'Tesla': {
      'Model S': ['Type 2', 'CCS'],
      'Model 3': ['Type 2', 'CCS'],
    },
    'Nissan': {
      'Leaf': ['CHAdeMO', 'Type 1'],
      'Ariya': ['Type 2', 'CCS'],
    },
    'BMW': {
      'i3': ['Type 2', 'CCS'],
      'iX': ['Type 2', 'CCS'],
    },
  };

  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedConnector;
  bool _isLoading = false;
  String? _currentVehicleId;

  @override
  void initState() {
    super.initState();
    _getCurrentVehicleId();
  }

  @override
  void dispose() {
    _vinController.dispose();
    _registrationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentVehicleId() async {
    String id = await PreferenceValues.getVehicleId();
    setState(() {
      _currentVehicleId = id;
    });
  }

  // Validation for VIN
  String? validateVIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the VIN';
    }
    final regExp = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid 17-character VIN (A-Z, 0-9, no I, O, Q)';
    }
    return null;
  }

  // Validation for Registration Number
  String? _validateRegistrationNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the registration number';
    }
    final regExp = RegExp(r'^[A-Z]{2}-\d{2}-[A-Z]{2}-\d{4}$');
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid registration number (e.g., KL-01-AB-1234)';
    }
    return null;
  }

  Future<void> _vehicleRegistration() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        _isLoading = true;
      });
      try {
        final responseMessage = await vehicleRegisterService(
          brand: _selectedBrand ?? "",
          model: _selectedModel ?? "",
          connector_type: _selectedConnector ?? "",
          vin: _vinController.text.trim(),
          registration_num: _registrationController.text.trim(),
        );

        if (responseMessage.status == 'success') {
          await PreferenceValues.addVehicle(
            vehicleId: responseMessage.vehicleId!.toString(),
          );
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserHomePage(),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(responseMessage.message ?? "Unkown error")),
            );
          }
        }
      } catch (e) {
        // Handle exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_currentVehicleId != null && _currentVehicleId != "0") {
      return Scaffold(
        body: Stack(
          children: [
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
            Center(
              child: Column(
                children: [
                  Image.asset('assets/logo/error.jpg'),
                  const Text(
                    "User can register only one vehicle",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return _currentVehicleId == null
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF176A4D)),
            ),
          )
        : Scaffold(
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

                // Centered form
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                              'EV Registration Form',
                              style: TextStyle(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF176A4D),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Brand Dropdown
                          _buildDropdown(
                            label: 'Vehicle Brand',
                            value: _selectedBrand,
                            items: _vehicleData.keys.toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBrand = value;
                                _selectedModel = null;
                                _selectedConnector = null;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a vehicle brand'
                                : null,
                          ),
                          const SizedBox(height: 20),

                          // Model Dropdown
                          _buildDropdown(
                            label: 'Vehicle Model',
                            value: _selectedModel,
                            items: _selectedBrand != null
                                ? _vehicleData[_selectedBrand]!.keys.toList()
                                : [],
                            onChanged: (value) {
                              setState(() {
                                _selectedModel = value;
                                _selectedConnector = null;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a vehicle model'
                                : null,
                          ),
                          const SizedBox(height: 20),

                          // Connector Type Dropdown
                          _buildDropdown(
                            label: 'Connector Type',
                            value: _selectedConnector,
                            items: _selectedBrand != null &&
                                    _selectedModel != null
                                ? _vehicleData[_selectedBrand]![_selectedModel]!
                                : [],
                            onChanged: (value) {
                              setState(() {
                                _selectedConnector = value;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a connector type'
                                : null,
                          ),
                          const SizedBox(height: 20),

                          // VIN Field
                          _buildTextField(
                            label: 'VIN',
                            validator: validateVIN,
                            controller: _vinController,
                            icon: Icons.directions_car,
                          ),
                          const SizedBox(height: 20),

                          // Registration Number Field
                          _buildTextField(
                            label: 'Registration Number',
                            validator: _validateRegistrationNumber,
                            controller: _registrationController,
                            icon: Icons.article,
                          ),
                          const SizedBox(height: 30),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF176A4D)),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF176A4D),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    onPressed: _vehicleRegistration,
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildTextField({
    required String label,
    required String? Function(String?) validator,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF176A4D)),
        prefixIcon: Icon(icon, color: const Color(0xFF176A4D)),
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
      style: const TextStyle(color: Colors.black),
      validator: validator,
    );
  }
}
