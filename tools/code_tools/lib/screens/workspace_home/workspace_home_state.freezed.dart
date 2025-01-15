// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workspace_home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkspaceHomeState {
  List<WorkSpaceEntity> get workspaces => throw _privateConstructorUsedError;

  /// Create a copy of WorkspaceHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkspaceHomeStateCopyWith<WorkspaceHomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkspaceHomeStateCopyWith<$Res> {
  factory $WorkspaceHomeStateCopyWith(
          WorkspaceHomeState value, $Res Function(WorkspaceHomeState) then) =
      _$WorkspaceHomeStateCopyWithImpl<$Res, WorkspaceHomeState>;
  @useResult
  $Res call({List<WorkSpaceEntity> workspaces});
}

/// @nodoc
class _$WorkspaceHomeStateCopyWithImpl<$Res, $Val extends WorkspaceHomeState>
    implements $WorkspaceHomeStateCopyWith<$Res> {
  _$WorkspaceHomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkspaceHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaces = null,
  }) {
    return _then(_value.copyWith(
      workspaces: null == workspaces
          ? _value.workspaces
          : workspaces // ignore: cast_nullable_to_non_nullable
              as List<WorkSpaceEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkspaceHomeStateImplCopyWith<$Res>
    implements $WorkspaceHomeStateCopyWith<$Res> {
  factory _$$WorkspaceHomeStateImplCopyWith(_$WorkspaceHomeStateImpl value,
          $Res Function(_$WorkspaceHomeStateImpl) then) =
      __$$WorkspaceHomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WorkSpaceEntity> workspaces});
}

/// @nodoc
class __$$WorkspaceHomeStateImplCopyWithImpl<$Res>
    extends _$WorkspaceHomeStateCopyWithImpl<$Res, _$WorkspaceHomeStateImpl>
    implements _$$WorkspaceHomeStateImplCopyWith<$Res> {
  __$$WorkspaceHomeStateImplCopyWithImpl(_$WorkspaceHomeStateImpl _value,
      $Res Function(_$WorkspaceHomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkspaceHomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workspaces = null,
  }) {
    return _then(_$WorkspaceHomeStateImpl(
      workspaces: null == workspaces
          ? _value._workspaces
          : workspaces // ignore: cast_nullable_to_non_nullable
              as List<WorkSpaceEntity>,
    ));
  }
}

/// @nodoc

class _$WorkspaceHomeStateImpl implements _WorkspaceHomeState {
  const _$WorkspaceHomeStateImpl(
      {final List<WorkSpaceEntity> workspaces = const []})
      : _workspaces = workspaces;

  final List<WorkSpaceEntity> _workspaces;
  @override
  @JsonKey()
  List<WorkSpaceEntity> get workspaces {
    if (_workspaces is EqualUnmodifiableListView) return _workspaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workspaces);
  }

  @override
  String toString() {
    return 'WorkspaceHomeState(workspaces: $workspaces)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkspaceHomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._workspaces, _workspaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_workspaces));

  /// Create a copy of WorkspaceHomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkspaceHomeStateImplCopyWith<_$WorkspaceHomeStateImpl> get copyWith =>
      __$$WorkspaceHomeStateImplCopyWithImpl<_$WorkspaceHomeStateImpl>(
          this, _$identity);
}

abstract class _WorkspaceHomeState implements WorkspaceHomeState {
  const factory _WorkspaceHomeState({final List<WorkSpaceEntity> workspaces}) =
      _$WorkspaceHomeStateImpl;

  @override
  List<WorkSpaceEntity> get workspaces;

  /// Create a copy of WorkspaceHomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkspaceHomeStateImplCopyWith<_$WorkspaceHomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
