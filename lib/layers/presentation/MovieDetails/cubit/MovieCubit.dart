import 'package:bloc/bloc.dart';
import 'package:watchdice/layers/domain/entity/movie.dart';


part 'MovieState.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit(super.initialState);
}
