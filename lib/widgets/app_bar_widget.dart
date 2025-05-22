import 'dart:ui'; // Importer pour ImageFilter
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? backgroundImage;
  const AppBarWidget({super.key, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black, // Rendre l'AppBar transparente pour voir le flou
      elevation: 0,
     /*  flexibleSpace: backgroundImage != null
          ? ClipRect( // ClipRect pour que le BackdropFilter ne s'applique qu'à l'AppBar
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3), // Couleur de fond semi-transparente pour l'AppBar
                ),
              ),
            )
          : null, */
      leadingWidth: 80,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Center(
          child: Text(
            "QN TV",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: const Text("Mua gói", style: TextStyle(color: Colors.white)),
          ),
        ),
        IconButton(icon: const Icon(Icons.notifications_none_outlined, size: 26), onPressed: () {}),
        IconButton(icon: const Icon(Icons.search, size: 26), onPressed: () {}),
        IconButton(icon: const Icon(Icons.account_circle_outlined, size: 26), onPressed: () {}),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
