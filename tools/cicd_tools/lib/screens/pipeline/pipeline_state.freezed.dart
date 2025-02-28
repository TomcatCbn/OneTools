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
  List<ModuleState> get modules =>
      throw _privateConstructorUsedError; // 当前默认选中的module
  ModuleState? get selected => throw _privateConstructorUsedError;

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
  $Res call(
      {Pipeline? pipeline, List<ModuleState> modules, ModuleState? selected});
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
    Object? modules = null,
    Object? selected = freezed,
  }) {
    return _then(_value.copyWith(
      pipeline: freezed == pipeline
          ? _value.pipeline
          : pipeline // ignore: cast_nullable_to_non_nullable
              as Pipeline?,
      modules: null == modules
          ? _value.modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleState>,
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as ModuleState?,
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
  $Res call(
      {Pipeline? pipeline, List<ModuleState> modules, ModuleState? selected});
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
    Object? modules = null,
    Object? selected = freezed,
  }) {
    return _then(_$PipelineHomeStateImpl(
      pipeline: freezed == pipeline
          ? _value.pipeline
          : pipeline // ignore: cast_nullable_to_non_nullable
              as Pipeline?,
      modules: null == modules
          ? _value._modules
          : modules // ignore: cast_nullable_to_non_nullable
              as List<ModuleState>,
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as ModuleState?,
    ));
  }
}

/// @nodoc

class _$PipelineHomeStateImpl implements _PipelineHomeState {
  const _$PipelineHomeStateImpl(
      {this.pipeline,
      final List<ModuleState> modules = const [],
      this.selected})
      : _modules = modules;

  @override
  final Pipeline? pipeline;
  final List<ModuleState> _modules;
  @override
  @JsonKey()
  List<ModuleState> get modules {
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modules);
  }

// 当前默认选中的module
  @override
  final ModuleState? selected;

  @override
  String toString() {
    return 'PipelineHomeState(pipeline: $pipeline, modules: $modules, selected: $selected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PipelineHomeStateImpl &&
            (identical(other.pipeline, pipeline) ||
                other.pipeline == pipeline) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.selected, selected) ||
                other.selected == selected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pipeline,
      const DeepCollectionEquality().hash(_modules), selected);

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
  const factory _PipelineHomeState(
      {final Pipeline? pipeline,
      final List<ModuleState> modules,
      final ModuleState? selected}) = _$PipelineHomeStateImpl;

  @override
  Pipeline? get pipeline;
  @override
  List<ModuleState> get modules; // 当前默认选中的module
  @override
  ModuleState? get selected;

  /// Create a copy of PipelineHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PipelineHomeStateImplCopyWith<_$PipelineHomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
