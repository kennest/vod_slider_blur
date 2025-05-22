import 'package:flutter/material.dart';

class Top10IndicatorWidget extends StatelessWidget {
  const Top10IndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C), // Gris foncé
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey[600]!, width: 0.5)
            ),
            child: Column(
              children: const [
                Text("TOP", style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
                Text("10", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "#4 Tại QN TV hôm nay",
            style: TextStyle(color: Colors.grey[300], fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
