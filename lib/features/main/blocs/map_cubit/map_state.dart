import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_state.freezed.dart';

@freezed
abstract class MapState with _$MapState {
  const factory MapState.empty() = MapStateEmpty;
  const factory MapState.buildRoute({required bool isPedestrian}) = MapStateBuildRoute;
}