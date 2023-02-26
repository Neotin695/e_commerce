import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ErrWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Widget child;
  const ErrWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (_, result, child) {
        if (result == ConnectivityResult.none) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imageUrl,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }
        return child;
      },
      child: child,
    );
  }
}
