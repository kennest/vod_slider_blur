import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vod_slider_blur/widgets/action_buttons_widget.dart'; // Importer ActionButtonsWidget
import 'package:vod_slider_blur/widgets/app_bar_widget.dart';
import 'package:vod_slider_blur/widgets/category_tabs_widget.dart'; // Importer CategoryTabsWidget (si nécessaire)
import 'package:vod_slider_blur/widgets/horizontal_image_list_widget.dart'; // Importer HorizontalImageListWidget
import 'package:vod_slider_blur/widgets/image_carousel_widget.dart';
import 'package:vod_slider_blur/widgets/top_10_indicator_widget.dart'; // Importer Top10IndicatorWidget

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const QNTvApp());
}

class QNTvApp extends StatelessWidget {
  const QNTvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QN TV Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F), // Fond très sombre
        primaryColor: const Color(
          0xFFE50914,
        ), // Rouge pour les accents comme "Mua gói"
        fontFamily:
            'Roboto', // Vous pouvez choisir une police plus spécifique si besoin
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A), // Fond de l'AppBar
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "Phim Bộ",
    "Phim Điện Ảnh",
    "VIP",
    "Chương trình",
    "Games",
    "Thiếu Nhi",
  ];

  final List<String> _bannerImageUrls = [
    "https://placeholderimage.eu/api/film/800/600", // Placeholder
    "https://placeholderimage.eu/api/nature/800/600", // Placeholder
    "https://placeholderimage.eu/api/monument/800/600", // Placeholder
  ];

  final List<String> _vodImageUrls = [
    "https://placeholderimage.eu/api/film/800/600", // Placeholder
    "https://placeholderimage.eu/api/nature/800/600", // Placeholder
    "https://placeholderimage.eu/api/monument/800/600", // Placeholder
  ];

  // Déplacer mainImageUrl ici pour y accéder facilement
  final String mainImageUrl =
      "https://placeholderimage.eu/api/monument/id/1/800/600";

  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  // Ajout des variables pour l'effet de fondu
  String _previousImageUrl = ""; // Pour stocker l'URL précédente
  bool _showPreviousImage = false;

  @override
  void initState() {
    super.initState();
    // Initialiser _previousImageUrl avec l'image de départ
    _previousImageUrl = _bannerImageUrls.isNotEmpty ? mainImageUrl : "";
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _showPreviousImage = true; // Commencer la transition
          // L'URL actuelle devient la précédente pour la prochaine transition
          // _previousImageUrl est déjà l'ancienne image active
          _currentPage = _pageController.page!.round();
        });
        // Après un court délai, cacher l'ancienne image et mettre à jour _previousImageUrl
        // pour la prochaine transition.
        Future.delayed(const Duration(milliseconds: 500), () {
          // Durée du fondu
          setState(() {
            _showPreviousImage = false;
            _previousImageUrl = _bannerImageUrls.isNotEmpty
                ? (_currentPage == 0
                      ? mainImageUrl
                      : _bannerImageUrls[_currentPage %
                            _bannerImageUrls.length])
                : mainImageUrl;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Déterminer l'URL de l'image actuelle pour l'AppBar et le fond
    String currentImageUrl = _bannerImageUrls.isNotEmpty
        ? (_currentPage == 0
              ? mainImageUrl
              : _bannerImageUrls[_currentPage % _bannerImageUrls.length])
        : mainImageUrl; // Fallback si la liste est vide

    return Scaffold(
      appBar: AppBarWidget(backgroundImage: currentImageUrl),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Carrousel avec fond dynamique et effets
            Stack(
              children: [
                // Image précédente pour l'effet de fondu
                if (_showPreviousImage && _previousImageUrl.isNotEmpty)
                  Positioned.fill(
                    child: Image.network(
                      _previousImageUrl,
                      fit: BoxFit.cover,
                      key: ValueKey<String>("prev_$_previousImageUrl"),
                    ),
                  ),
                // Image actuelle avec AnimatedOpacity pour l'effet de fondu
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: _showPreviousImage ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Image.network(
                      currentImageUrl,
                      fit: BoxFit.cover,
                      key: ValueKey<String>(currentImageUrl),
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: const Color(0xFF0F0F0F)),
                    ),
                  ),
                ),
                // BackdropFilter pour le flou
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(
                        0.1,
                      ), // Légère surcouche pour le flou
                    ),
                  ),
                ),
                // Dégradé noir pour la section carrousel
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                     border: Border.all(color: Colors.black, width: 0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent, // Plus transparent en haut
                          Colors.black.withOpacity(0.5),
                          Colors.black, // Plus opaque vers le bas de cette section
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                // Contenu de la section carrousel
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageCarouselWidget(
                      pageController: _pageController,
                      bannerImageUrls: _bannerImageUrls,
                      currentPage: _currentPage,
                    ),
                    // const Top10IndicatorWidget(),
                    const ActionButtonsWidget(), // Boutons liés au carrousel
                    const SizedBox(
                      height: 24,
                    ), // Espace après les boutons du carrousel
                  ],
                ),
              ],
            ),
            // Section 2: Listes horizontales avec fond noir
            Container(
              color: Colors.black, // Fond noir pour cette section
              padding: const EdgeInsets.only(
                top: 16.0,
              ), // Espace au-dessus des listes
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HorizontalImageListWidget(
                    title: "Programmes originaux QN TV",
                    imageUrls: _vodImageUrls,
                  ),
                  HorizontalImageListWidget(
                    title: "Tendances actuelles",
                    imageUrls: _bannerImageUrls,
                  ),
                  // Vous pouvez ajouter d'autres HorizontalImageListWidget ici
                  const SizedBox(
                    height: 60,
                  ), // Espace en bas de la zone scrollable
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
