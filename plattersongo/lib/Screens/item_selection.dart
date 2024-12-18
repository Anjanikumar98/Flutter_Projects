import 'package:flutter/material.dart';
import '../models/guest_pricing.dart';

class ItemSelectionScreen extends StatefulWidget {
  @override
  _ItemSelectionScreenState createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  int guestCount = 1;
  num price = GuestPricing.maxPrice; // Change to num

  void _updatePrice(int value) {
    setState(() {
      guestCount = value;
      price = GuestPricing.calculatePrice(value); // The result is now num
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Guests & Items")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Number of Guests: $guestCount", style: TextStyle(fontSize: 18)),
            Slider(
              value: guestCount.toDouble(),
              min: 1,
              max: GuestPricing.maxGuests.toDouble(),
              divisions: GuestPricing.maxGuests,
              label: "$guestCount Guests",
              onChanged: (value) => _updatePrice(value.toInt()),
            ),
            SizedBox(height: 20),
            Text("Total Price: ₹${price.toStringAsFixed(2)}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {},
                child: Text("Next: Fill Details")
            ),
          ],
        ),
      ),
    );
  }
}
