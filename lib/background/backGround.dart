import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 244, 249, 1),
      body: Stack(
        children: [
          // Blurred Circle 1 - top left
          Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-40, 98),
              child: _buildSimulatedBlurCircle(
                color: const Color.fromRGBO(4, 139, 148, 0.01),
                spreadColor: const Color.fromRGBO(4, 139, 148, 0.3),
              ),
            ),
          ),

          // Blurred Circle 2 - center right
          Align(
            alignment: Alignment.centerRight,
            child: Transform.translate(
              offset: const Offset(50, 20),
              child: _buildSimulatedBlurCircle(
                color: const Color.fromRGBO(4, 139, 148, 0.01),
                spreadColor: const Color.fromRGBO(4, 139, 148, 0.3),
              ),
            ),
          ),

          // Blurred Circle 3 - bottom left
          Align(
            alignment: Alignment.bottomLeft,
            child: Transform.translate(
              offset: const Offset(-40, -100),
              child: _buildSimulatedBlurCircle(
                color: const Color.fromRGBO(210, 145, 29, 0.01),
                spreadColor: const Color.fromRGBO(210, 145, 29, 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Simulated Blur Circle (strong spread)
  Widget _buildSimulatedBlurCircle({
    required Color color,
    required Color spreadColor,
  }) {
    return Container(
      height: 131,
      width: 131,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: spreadColor,
            blurRadius: 90, // Controls how far it spreads (≈ 172.7% feel)
            spreadRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
