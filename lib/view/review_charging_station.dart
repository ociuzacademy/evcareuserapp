import 'package:flutter/material.dart';

class ChargingStationReviews extends StatefulWidget {
  const ChargingStationReviews({super.key});

  @override
  _ChargingStationReviewsState createState() => _ChargingStationReviewsState();
}

class _ChargingStationReviewsState extends State<ChargingStationReviews> {
  final List<Map<String, String>> _reviews = [
    {'name': 'John Doe', 'review': 'Great service and well-maintained station!'},
    {'name': 'Jane Smith', 'review': 'Fast charging and friendly staff.'},
  ];

  final TextEditingController _reviewController = TextEditingController();

  void _addReview(String review) {
    if (review.isNotEmpty) {
      setState(() {
        _reviews.add({'name': 'You', 'review': review});
      });
      _reviewController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Charging Station Reviews'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: Column(
        children: [
          // Display Existing Reviews
          Expanded(
            child: _reviews.isEmpty
                ? const Center(
                    child: Text(
                      'No reviews yet. Be the first to add one!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _reviews.length,
                    itemBuilder: (context, index) {
                      final review = _reviews[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.03,
                        ),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                review['review']!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Add Review Section
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.03,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  controller: _reviewController,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.03,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                ElevatedButton(
                  onPressed: () {
                    _addReview(_reviewController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3AA17E),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.1,
                    ),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
