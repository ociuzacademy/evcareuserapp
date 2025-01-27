import 'package:ev_booking/modules/feedback/service/feedback_service.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  final int serviceId;
  final int repairId;

  const FeedbackPage({
    super.key,
    required this.serviceId,
    required this.repairId,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  Future<void> submitFeedback() async {
    if (formKey.currentState!.validate()) {
      final feedbackText = feedbackController.text.trim();
      const int userId = 2; // Hardcoded user ID for testing purposes

      try {
        final responseMessage = await feedbackService(
          feedback: feedbackText,
          user: userId.toString(),
          service_id: widget.serviceId.toString(),
          repair_id: widget.repairId.toString(),
        );

        if (responseMessage.status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feedback submitted successfully!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseMessage.message ?? "Unknown error")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color(0xFF3AA17E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter feedback:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Feedback Text Field
                TextFormField(
                  controller: feedbackController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Your Feedback',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Feedback cannot be empty';
                    }
                    return null;
                  },
                ),

                SizedBox(height: screenHeight * 0.02),

                // Submit Button
                ElevatedButton(
                  onPressed: submitFeedback,
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
        ),
      ),
    );
  }
}
