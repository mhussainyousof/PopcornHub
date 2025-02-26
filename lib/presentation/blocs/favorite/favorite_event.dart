part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class LoadFavoriteMovieEvent extends FavoriteEvent {
  @override
  List<Object?> get props => [];
} 

class DeleteFavoriteMovieEvent extends FavoriteEvent {
  final int movieId;
  const DeleteFavoriteMovieEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class ToggleFavoriteMovieEvent extends FavoriteEvent {
  final MovieEntity movieEntity;
  final bool isFavorite;
  const ToggleFavoriteMovieEvent({
    required this.movieEntity,
    required this.isFavorite,
  });
  
  @override
  List<Object?> get props =>[movieEntity, isFavorite];
}

class CheckIfFavoriteMovie extends FavoriteEvent {
  final int movieId;
  const CheckIfFavoriteMovie({
    required this.movieId,
  });
  @override
  List<Object?> get props => [movieId];

}
