import 'package:ev_booking/view/home_page.dart';
import 'package:flutter/material.dart';

class PaymentOpp extends StatefulWidget {
  const PaymentOpp({super.key});

  @override
  PaymentOppState createState() => PaymentOppState();
}

class PaymentOppState extends State<PaymentOpp> {
  String? selectedBank;
  TextEditingController pricecontroller = TextEditingController();

  final List<Map<String, String>> banks = [
    {
      'name': 'Google Pay',
      'image': 'assets/icons/google-pay-icon.webp',
    },
    {
      'name': 'Credit/Debit Cards',
      'image': 'assets/icons/credit_card.jpg',
    },
    {
      'name': 'Paypal',
      'image': 'assets/icons/paypal.jpg',
    },
    {
      'name': 'Master Card',
      'image': 'assets/icons/master card.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedBank = banks.first['name']; // Default selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Payment Option",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: pricecontroller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // Fixed border visibility
                hintText: '₹0',
              ),
              style: const TextStyle(fontSize: 70),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Choose Your Transaction Method",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        value: selectedBank,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                        ),
                        items: banks.map((bank) {
                          return DropdownMenuItem<String>(
                            value: bank['name'],
                            child: Row(
                              children: [
                                Image.asset(
                                  bank['image']!,
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  bank['name']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBank = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Payment initiated for ${pricecontroller.text}")),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserHomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Confirm Payment',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
      ),
    );
  }
}
