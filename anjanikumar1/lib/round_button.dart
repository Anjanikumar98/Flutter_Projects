import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Use onTap to handle the tap action
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color:
                      Colors.white) // Show loading spinner if loading is true
              : Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
