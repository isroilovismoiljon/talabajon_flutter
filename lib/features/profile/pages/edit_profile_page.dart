import 'package:flutter/material.dart';

import 'dart:ui';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
            fit: BoxFit.cover,
          ),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  width: 250,
                  height: 160,
                  color: Colors.white.withValues(alpha: 0.2),
                  alignment: Alignment.center,
                  child: const Text(
                    "Glass Effect 😍",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class EditProfilePage extends StatelessWidget {
//   const EditProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple.shade100,
//       body: Column(
//         children: [
//           ClipPath(
//             clipper: PastkiTolqinClipper(),
//             child: Container(
//               height: 250,
//               color: Colors.deepPurple,
//               child: const Center(
//                 child: Text(
//                   "ClipPathda qilingan 👌👍",
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 40),
//           const Text(
//             "Bu to‘lqinli container shaklida kesilgan.\n"
//             "Custom dizaynlar uchun juda foydali!",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class PastkiTolqinClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 60);
//
//     final firstControlPoint = Offset(size.width / 4, size.height);
//     final firstEndPoint = Offset(size.width / 2, size.height - 40);
//     final secondControlPoint = Offset(size.width * 3 / 4, size.height - 80);
//     final secondEndPoint = Offset(size.width, size.height - 20);
//
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
//
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

//---------------------------------------------------------------------------------------------------

// class EditProfilePage extends StatelessWidget {
//   const EditProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("InteractiveViewer Qiziq Widget")),
//       body: Center(
//         child: InteractiveViewer(
//           panEnabled: true,
//           scaleEnabled: true,
//           boundaryMargin: const EdgeInsets.all(50),
//           minScale: 0.5,
//           maxScale: 4,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.network(
//               'https://images.unsplash.com/photo-1518791841217-8f162f1e1131',
//               width: 300,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
