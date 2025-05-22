import 'dart:ui'; // Importer pour ImageFilter
import 'package:flutter/material.dart';

class ImageCarouselWidget extends StatelessWidget {
  final PageController pageController;
  final List<String> bannerImageUrls;
  final int currentPage;

  const ImageCarouselWidget({
    super.key,
    required this.pageController,
    required this.bannerImageUrls,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    const String mainImageUrl = "https://placeholderimage.eu/api/monument/id/1/800/600";

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55, // Ajustez cette hauteur
      child: PageView.builder(
        controller: pageController,
        itemCount: bannerImageUrls.length, // Utilisez la liste d'URLs pour le carrousel
        itemBuilder: (context, index) {
          String imageUrl = (index == 0) ? mainImageUrl : bannerImageUrls[index];
          
          double scale = currentPage == index ? 1.0 : 0.9;
          double opacity = currentPage == index ? 1.0 : 0.7;

          return TweenAnimationBuilder(
            tween: Tween<double>(begin: scale, end: scale),
            duration: const Duration(milliseconds: 350),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: opacity,
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.image_not_supported, color: Colors.grey, size: 50)),
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    // Ajout du BackdropFilter pour l'effet de flou sur l'image active
                    /* if (currentPage == index)
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Ajustez les valeurs de sigma pour l'intensité du flou
                          child: Container(
                            color: Colors.black.withOpacity(0.1), // Légère surcouche pour accentuer le flou
                          ),
                        ),
                      ), */
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          stops: const [0.0, 0.4]
                        ),
                      ),
                    ),
                    // if (index == 0) 
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CUỘC ĐỜI VẪN ĐẸP SAO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(blurRadius: 2.0, color: Colors.black54, offset: Offset(1,1))]
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text("ĐẠO DIỄN: NGUYỄN DANH DŨNG", style: TextStyle(color: Colors.grey[300], fontSize: 10)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text("21H40 - THỨ 2,3,4", style: TextStyle(color: Colors.grey[300], fontSize: 10)),
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.red[800],
                                    borderRadius: BorderRadius.circular(2)
                                  ),
                                  child: const Text("VTV3", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
