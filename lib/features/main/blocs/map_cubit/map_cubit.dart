import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promenade/features/main/blocs/map_cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState.empty());

  void buildRoute(bool isPedestrian) {
    emit(MapState.buildRoute(isPedestrian: isPedestrian));
  }

  void eraseState() {
    emit(const MapState.empty());
  }
}
