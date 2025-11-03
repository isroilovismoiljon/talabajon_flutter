import 'package:flutter/material.dart';
import 'package:talabajon/features/home/widgets/bottom_container.dart';
import 'package:talabajon/features/home/widgets/top_container.dart';

import '../../common/widgets/custom_bottom_navigation_bar.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          TopContainer(),
          BottomContainer(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(activeIndex: 0),
    );
  }
}
