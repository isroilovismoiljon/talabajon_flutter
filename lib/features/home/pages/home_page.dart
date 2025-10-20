import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Color(0xFF0D0B98),
            centerTitle: true,
            title: Container(
              width: double.infinity,
              height: 225.h,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(colors: [Color(0xFF3C3ADD), Color(0xFF0D0B98)]),
              // ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              "https://i.pinimg.com/originals/fc/67/03/fc6703e79d41363832817cbdf297beaa.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
