import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcornhub/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class MovieDataWidget  extends StatelessWidget{
  
  const MovieDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
     final themeMode = Theme.of(context).brightness;
    final isDark = themeMode == Brightness.dark;

   return BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
      builder: (context, state) {
        if(state is MovieBackdropChanged){
          return Text(
            state.movie.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: isDark? Colors.white : AppColor.vulcan),
            maxLines: 1,
            overflow: TextOverflow.fade,
          );
        }
          return SizedBox.shrink();
      },
    );
  }


}