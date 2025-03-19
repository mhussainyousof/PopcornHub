import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/presentation/journey/home/home_screen.dart';

class NavigationHome  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(icon: Icon(Iconsax.search_favorite), label: 'search'),
        ],
      ),
      body: HomeScreen(),
    );
  }
}



