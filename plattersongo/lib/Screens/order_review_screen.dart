
import 'package:flutter/material.dart';

class OrderReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Review")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Order Summary", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            // Display selected items and details here
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle order confirmation
              },
              child: Text("Confirm Order"),
            ),
          ],
        ),
      ),
    );
  }
}
