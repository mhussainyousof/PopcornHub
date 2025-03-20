import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:popcornhub/data/core/api_constants.dart';
import 'package:popcornhub/data/domain/entity/movie_entity.dart';
import 'package:popcornhub/presentation/theme/app_color.dart';

class MoviePicWidget extends StatelessWidget {
  const MoviePicWidget({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: '${ApiConstants.baseImageUrl}${movie.posterPath}',
              height: 190,
              width: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(
                backgroundColor: AppColor.mintGreen,
                color: AppColor.softCoral,
                strokeAlign: 1,
              ),),
              errorWidget: (context, url, error) => Icon(Iconsax.image),
            ),
          ),
          Positioned(
            left: 2,
            bottom: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.electricBlue.withOpacity(0.8), AppColor.softCoral.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 9,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.softCoral.withOpacity(0.8), AppColor.electricBlue.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                movie.releaseDate.substring(0, 4),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}