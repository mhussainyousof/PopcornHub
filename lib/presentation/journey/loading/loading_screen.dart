import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:popcornhub/presentation/blocs/laoding/loading_bloc.dart';
import 'package:popcornhub/presentation/journey/loading/loading_circle.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;
  const LoadingScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            screen,
            if(state is LoadingStarted)
            Container(
              decoration:
                  BoxDecoration(color: AppColor.richBlack.withOpacity(0.8)),
              child: Container(
                decoration:
                    BoxDecoration(color: AppColor.richBlack.withOpacity(0.8)),
                child: Center(
                  child: LoadingCircle(size: 200.w),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
