import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 3.0;
  TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    String feedbackText = _feedbackController.text;
    // In real implementation, you might send the feedback data to your backend
    print('Feedback Submitted: Rating: $_rating, Comment: $feedbackText');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Color(0xFFD7433C), // Custom app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate Our App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 30),
            Text(
              'Leave a comment (optional)',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                hintText: 'Enter your comments here...',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD7433C)),
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFD7433C), // Custom button color
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(
  'Submit Feedback',
  style: TextStyle(color: Colors.white),
),
              
            ),
          ],
        ),
      ),
    );
  }
}
