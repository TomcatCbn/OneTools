// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  List<ProjectState> get projects => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({List<ProjectState> projects});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_value.copyWith(
      projects: null == projects
          ? _value.projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<ProjectState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProjectState> projects});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projects = null,
  }) {
    return _then(_$HomeStateImpl(
      projects: null == projects
          ? _value._projects
          : projects // ignore: cast_nullable_to_non_nullable
              as List<ProjectState>,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl({final List<ProjectState> projects = const []})
      : _projects = projects;

  final List<ProjectState> _projects;
  @override
  @JsonKey()
  List<ProjectState> get projects {
    if (_projects is EqualUnmodifiableListView) return _projects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_projects);
  }

  @override
  String toString() {
    return 'HomeState(projects: $projects)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality().equals(other._projects, _projects));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_projects));

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({final List<ProjectState> projects}) =
      _$HomeStateImpl;

  @override
  List<ProjectState> get projects;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProjectState {
  String get projectName => throw _privateConstructorUsedError;
  String get projectDesc => throw _privateConstructorUsedError;
  String get projectDir => throw _privateConstructorUsedError;
  int get codeRepoCount => throw _privateConstructorUsedError;

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectStateCopyWith<ProjectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStateCopyWith<$Res> {
  factory $ProjectStateCopyWith(
          ProjectState value, $Res Function(ProjectState) then) =
      _$ProjectStateCopyWithImpl<$Res, ProjectState>;
  @useResult
  $Res call(
      {String projectName,
      String projectDesc,
      String projectDir,
      int codeRepoCount});
}

/// @nodoc
class _$ProjectStateCopyWithImpl<$Res, $Val extends ProjectState>
    implements $ProjectStateCopyWith<$Res> {
  _$ProjectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? projectDesc = null,
    Object? projectDir = null,
    Object? codeRepoCount = null,
  }) {
    return _then(_value.copyWith(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      projectDesc: null == projectDesc
          ? _value.projectDesc
          : projectDesc // ignore: cast_nullable_to_non_nullable
              as String,
      projectDir: null == projectDir
          ? _value.projectDir
          : projectDir // ignore: cast_nullable_to_non_nullable
              as String,
      codeRepoCount: null == codeRepoCount
          ? _value.codeRepoCount
          : codeRepoCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProjectStateImplCopyWith<$Res>
    implements $ProjectStateCopyWith<$Res> {
  factory _$$ProjectStateImplCopyWith(
          _$ProjectStateImpl value, $Res Function(_$ProjectStateImpl) then) =
      __$$ProjectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String projectName,
      String projectDesc,
      String projectDir,
      int codeRepoCount});
}

/// @nodoc
class __$$ProjectStateImplCopyWithImpl<$Res>
    extends _$ProjectStateCopyWithImpl<$Res, _$ProjectStateImpl>
    implements _$$ProjectStateImplCopyWith<$Res> {
  __$$ProjectStateImplCopyWithImpl(
      _$ProjectStateImpl _value, $Res Function(_$ProjectStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectName = null,
    Object? projectDesc = null,
    Object? projectDir = null,
    Object? codeRepoCount = null,
  }) {
    return _then(_$ProjectStateImpl(
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      projectDesc: null == projectDesc
          ? _value.projectDesc
          : projectDesc // ignore: cast_nullable_to_non_nullable
              as String,
      projectDir: null == projectDir
          ? _value.projectDir
          : projectDir // ignore: cast_nullable_to_non_nullable
              as String,
      codeRepoCount: null == codeRepoCount
          ? _value.codeRepoCount
          : codeRepoCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ProjectStateImpl implements _ProjectState {
  const _$ProjectStateImpl(
      {required this.projectName,
      required this.projectDesc,
      required this.projectDir,
      this.codeRepoCount = 0});

  @override
  final String projectName;
  @override
  final String projectDesc;
  @override
  final String projectDir;
  @override
  @JsonKey()
  final int codeRepoCount;

  @override
  String toString() {
    return 'ProjectState(projectName: $projectName, projectDesc: $projectDesc, projectDir: $projectDir, codeRepoCount: $codeRepoCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectStateImpl &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.projectDesc, projectDesc) ||
                other.projectDesc == projectDesc) &&
            (identical(other.projectDir, projectDir) ||
                other.projectDir == projectDir) &&
            (identical(other.codeRepoCount, codeRepoCount) ||
                other.codeRepoCount == codeRepoCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, projectName, projectDesc, projectDir, codeRepoCount);

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectStateImplCopyWith<_$ProjectStateImpl> get copyWith =>
      __$$ProjectStateImplCopyWithImpl<_$ProjectStateImpl>(this, _$identity);
}

abstract class _ProjectState implements ProjectState {
  const factory _ProjectState(
      {required final String projectName,
      required final String projectDesc,
      required final String projectDir,
      final int codeRepoCount}) = _$ProjectStateImpl;

  @override
  String get projectName;
  @override
  String get projectDesc;
  @override
  String get projectDir;
  @override
  int get codeRepoCount;

  /// Create a copy of ProjectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectStateImplCopyWith<_$ProjectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
