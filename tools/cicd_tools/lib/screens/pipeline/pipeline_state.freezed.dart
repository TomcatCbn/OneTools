// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pipeline_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PipelineHomeState {
  Pipeline? get pipeline => throw _privateConstructorUsedError;

  /// Create a copy of PipelineHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PipelineHomeStateCopyWith<PipelineHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PipelineHomeStateCopyWith<$Res> {
  factory $PipelineHomeStateCopyWith(
          PipelineHomeState value, $Res Function(PipelineHomeState) then) =
      _$PipelineHomeStateCopyWithImpl<$Res, PipelineHomeState>;
  @useResult
  $Res call({Pipeline? pipeline});
}

/// @nodoc
class _$PipelineHomeStateCopyWithImpl<$Res, $Val extends PipelineHomeState>
    implements $PipelineHomeStateCopyWith<$Res> {
  _$PipelineHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PipelineHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pipeline = freezed,
  }) {
    return _then(_value.copyWith(
      pipeline: freezed == pipeline
          ? _value.pipeline
          : pipeline // ignore: cast_nullable_to_non_nullable
              as Pipeline?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PipelineHomeStateImplCopyWith<$Res>
    implements $PipelineHomeStateCopyWith<$Res> {
  factory _$$PipelineHomeStateImplCopyWith(_$PipelineHomeStateImpl value,
          $Res Function(_$PipelineHomeStateImpl) then) =
      __$$PipelineHomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Pipeline? pipeline});
}

/// @nodoc
class __$$PipelineHomeStateImplCopyWithImpl<$Res>
    extends _$PipelineHomeStateCopyWithImpl<$Res, _$PipelineHomeStateImpl>
    implements _$$PipelineHomeStateImplCopyWith<$Res> {
  __$$PipelineHomeStateImplCopyWithImpl(_$PipelineHomeStateImpl _value,
      $Res Function(_$PipelineHomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PipelineHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pipeline = freezed,
  }) {
    return _then(_$PipelineHomeStateImpl(
      pipeline: freezed == pipeline
          ? _value.pipeline
          : pipeline // ignore: cast_nullable_to_non_nullable
              as Pipeline?,
    ));
  }
}

/// @nodoc

class _$PipelineHomeStateImpl implements _PipelineHomeState {
  const _$PipelineHomeStateImpl({this.pipeline});

  @override
  final Pipeline? pipeline;

  @override
  String toString() {
    return 'PipelineHomeState(pipeline: $pipeline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PipelineHomeStateImpl &&
            (identical(other.pipeline, pipeline) ||
                other.pipeline == pipeline));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pipeline);

  /// Create a copy of PipelineHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PipelineHomeStateImplCopyWith<_$PipelineHomeStateImpl> get copyWith =>
      __$$PipelineHomeStateImplCopyWithImpl<_$PipelineHomeStateImpl>(
          this, _$identity);
}

abstract class _PipelineHomeState implements PipelineHomeState {
  const factory _PipelineHomeState({final Pipeline? pipeline}) =
      _$PipelineHomeStateImpl;

  @override
  Pipeline? get pipeline;

  /// Create a copy of PipelineHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PipelineHomeStateImplCopyWith<_$PipelineHomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
