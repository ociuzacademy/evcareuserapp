import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  final int serviceId;

  const FeedbackPage({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provide feedback for Service ID: $serviceId',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            // Feedback Text Field
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                final feedback = feedbackController.text.trim();
                if (feedback.isNotEmpty) {
                  // Here you can handle the feedback submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feedback submitted successfully!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Feedback cannot be empty')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3AA17E),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
