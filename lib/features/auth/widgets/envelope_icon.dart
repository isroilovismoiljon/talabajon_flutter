import 'package:flutter/material.dart';

class EnvelopeIcon extends StatelessWidget {
  final double width;
  final double height;

  const EnvelopeIcon({
    Key? key,
    this.width = 280,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Envelope
          CustomPaint(
            size: Size(width, height * 0.7),
            painter: EnvelopePainter(),
          ),
          // Checkmark
          Positioned(
            top: 20,
            child: Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check,
                color: Color(0xFF3D3BF3),
                size: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3D3BF3).withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    
    // Envelope body
    path.moveTo(20, 60);
    path.lineTo(20, size.height - 20);
    path.lineTo(size.width - 20, size.height - 20);
    path.lineTo(size.width - 20, 60);
    path.lineTo(20, 60);
    
    // Envelope flap
    path.moveTo(20, 60);
    path.lineTo(size.width / 2, 100);
    path.lineTo(size.width - 20, 60);
    
    canvas.drawPath(path, paint);
    
    // Address lines
    final linePaint = Paint()
      ..color = const Color(0xFF3D3BF3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(
      Offset(40, size.height - 60),
      Offset(100, size.height - 60),
      linePaint,
    );
    canvas.drawLine(
      Offset(40, size.height - 45),
      Offset(70, size.height - 45),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
