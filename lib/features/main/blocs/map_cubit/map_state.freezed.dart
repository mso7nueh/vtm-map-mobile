// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MapState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(bool isPedestrian) buildRoute,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(bool isPedestrian)? buildRoute,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(bool isPedestrian)? buildRoute,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MapStateEmpty value) empty,
    required TResult Function(MapStateBuildRoute value) buildRoute,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MapStateEmpty value)? empty,
    TResult? Function(MapStateBuildRoute value)? buildRoute,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MapStateEmpty value)? empty,
    TResult Function(MapStateBuildRoute value)? buildRoute,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) then) =
      _$MapStateCopyWithImpl<$Res, MapState>;
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res, $Val extends MapState>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MapStateEmptyImplCopyWith<$Res> {
  factory _$$MapStateEmptyImplCopyWith(
          _$MapStateEmptyImpl value, $Res Function(_$MapStateEmptyImpl) then) =
      __$$MapStateEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MapStateEmptyImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$MapStateEmptyImpl>
    implements _$$MapStateEmptyImplCopyWith<$Res> {
  __$$MapStateEmptyImplCopyWithImpl(
      _$MapStateEmptyImpl _value, $Res Function(_$MapStateEmptyImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MapStateEmptyImpl implements MapStateEmpty {
  const _$MapStateEmptyImpl();

  @override
  String toString() {
    return 'MapState.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MapStateEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(bool isPedestrian) buildRoute,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(bool isPedestrian)? buildRoute,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(bool isPedestrian)? buildRoute,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MapStateEmpty value) empty,
    required TResult Function(MapStateBuildRoute value) buildRoute,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MapStateEmpty value)? empty,
    TResult? Function(MapStateBuildRoute value)? buildRoute,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MapStateEmpty value)? empty,
    TResult Function(MapStateBuildRoute value)? buildRoute,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class MapStateEmpty implements MapState {
  const factory MapStateEmpty() = _$MapStateEmptyImpl;
}

/// @nodoc
abstract class _$$MapStateBuildRouteImplCopyWith<$Res> {
  factory _$$MapStateBuildRouteImplCopyWith(_$MapStateBuildRouteImpl value,
          $Res Function(_$MapStateBuildRouteImpl) then) =
      __$$MapStateBuildRouteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isPedestrian});
}

/// @nodoc
class __$$MapStateBuildRouteImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$MapStateBuildRouteImpl>
    implements _$$MapStateBuildRouteImplCopyWith<$Res> {
  __$$MapStateBuildRouteImplCopyWithImpl(_$MapStateBuildRouteImpl _value,
      $Res Function(_$MapStateBuildRouteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPedestrian = null,
  }) {
    return _then(_$MapStateBuildRouteImpl(
      isPedestrian: null == isPedestrian
          ? _value.isPedestrian
          : isPedestrian // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MapStateBuildRouteImpl implements MapStateBuildRoute {
  const _$MapStateBuildRouteImpl({required this.isPedestrian});

  @override
  final bool isPedestrian;

  @override
  String toString() {
    return 'MapState.buildRoute(isPedestrian: $isPedestrian)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapStateBuildRouteImpl &&
            (identical(other.isPedestrian, isPedestrian) ||
                other.isPedestrian == isPedestrian));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isPedestrian);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapStateBuildRouteImplCopyWith<_$MapStateBuildRouteImpl> get copyWith =>
      __$$MapStateBuildRouteImplCopyWithImpl<_$MapStateBuildRouteImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(bool isPedestrian) buildRoute,
  }) {
    return buildRoute(isPedestrian);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(bool isPedestrian)? buildRoute,
  }) {
    return buildRoute?.call(isPedestrian);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(bool isPedestrian)? buildRoute,
    required TResult orElse(),
  }) {
    if (buildRoute != null) {
      return buildRoute(isPedestrian);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MapStateEmpty value) empty,
    required TResult Function(MapStateBuildRoute value) buildRoute,
  }) {
    return buildRoute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MapStateEmpty value)? empty,
    TResult? Function(MapStateBuildRoute value)? buildRoute,
  }) {
    return buildRoute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MapStateEmpty value)? empty,
    TResult Function(MapStateBuildRoute value)? buildRoute,
    required TResult orElse(),
  }) {
    if (buildRoute != null) {
      return buildRoute(this);
    }
    return orElse();
  }
}

abstract class MapStateBuildRoute implements MapState {
  const factory MapStateBuildRoute({required final bool isPedestrian}) =
      _$MapStateBuildRouteImpl;

  bool get isPedestrian;
  @JsonKey(ignore: true)
  _$$MapStateBuildRouteImplCopyWith<_$MapStateBuildRouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
