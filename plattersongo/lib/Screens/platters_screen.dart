import 'package:flutter/material.dart';
import '../widgets/platter_card.dart';
import 'item_selection.dart';

class PlattersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Your Platter")),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: 4,  // Adjust based on how many platters you want to show
        itemBuilder: (context, index) => PlatterCard(
          title: "Platter ${index + 1}",
          imagePath: "assets/${getPlatterImage(index)}", // Dynamically pick an image
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) => ItemSelectionScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return SlideTransition(
                    position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to return images based on the platter index
  String getPlatterImage(int index) {
    switch (index) {
      case 0:
        return "Vegetarian food platter.jpg";
      case 1:
        return "Non-vegetarian food platter.jpg";
      case 2:
        return "Special food platter.jpg";
      default:
        return "Vegetarian food platter.jpg"; // Default platter
    }
  }
}
