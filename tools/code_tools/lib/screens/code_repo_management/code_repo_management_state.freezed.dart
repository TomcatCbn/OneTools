// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code_repo_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CodeRepoMgmtState {
  List<CodeRepoState> get codeRepos => throw _privateConstructorUsedError;
  int get refresh => throw _privateConstructorUsedError;

  /// Create a copy of CodeRepoMgmtState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodeRepoMgmtStateCopyWith<CodeRepoMgmtState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeRepoMgmtStateCopyWith<$Res> {
  factory $CodeRepoMgmtStateCopyWith(
          CodeRepoMgmtState value, $Res Function(CodeRepoMgmtState) then) =
      _$CodeRepoMgmtStateCopyWithImpl<$Res, CodeRepoMgmtState>;
  @useResult
  $Res call({List<CodeRepoState> codeRepos, int refresh});
}

/// @nodoc
class _$CodeRepoMgmtStateCopyWithImpl<$Res, $Val extends CodeRepoMgmtState>
    implements $CodeRepoMgmtStateCopyWith<$Res> {
  _$CodeRepoMgmtStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CodeRepoMgmtState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeRepos = null,
    Object? refresh = null,
  }) {
    return _then(_value.copyWith(
      codeRepos: null == codeRepos
          ? _value.codeRepos
          : codeRepos // ignore: cast_nullable_to_non_nullable
              as List<CodeRepoState>,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodeRepoMgmtStateImplCopyWith<$Res>
    implements $CodeRepoMgmtStateCopyWith<$Res> {
  factory _$$CodeRepoMgmtStateImplCopyWith(_$CodeRepoMgmtStateImpl value,
          $Res Function(_$CodeRepoMgmtStateImpl) then) =
      __$$CodeRepoMgmtStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CodeRepoState> codeRepos, int refresh});
}

/// @nodoc
class __$$CodeRepoMgmtStateImplCopyWithImpl<$Res>
    extends _$CodeRepoMgmtStateCopyWithImpl<$Res, _$CodeRepoMgmtStateImpl>
    implements _$$CodeRepoMgmtStateImplCopyWith<$Res> {
  __$$CodeRepoMgmtStateImplCopyWithImpl(_$CodeRepoMgmtStateImpl _value,
      $Res Function(_$CodeRepoMgmtStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CodeRepoMgmtState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeRepos = null,
    Object? refresh = null,
  }) {
    return _then(_$CodeRepoMgmtStateImpl(
      codeRepos: null == codeRepos
          ? _value._codeRepos
          : codeRepos // ignore: cast_nullable_to_non_nullable
              as List<CodeRepoState>,
      refresh: null == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CodeRepoMgmtStateImpl implements _CodeRepoMgmtState {
  const _$CodeRepoMgmtStateImpl(
      {final List<CodeRepoState> codeRepos = const [], this.refresh = 0})
      : _codeRepos = codeRepos;

  final List<CodeRepoState> _codeRepos;
  @override
  @JsonKey()
  List<CodeRepoState> get codeRepos {
    if (_codeRepos is EqualUnmodifiableListView) return _codeRepos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codeRepos);
  }

  @override
  @JsonKey()
  final int refresh;

  @override
  String toString() {
    return 'CodeRepoMgmtState(codeRepos: $codeRepos, refresh: $refresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeRepoMgmtStateImpl &&
            const DeepCollectionEquality()
                .equals(other._codeRepos, _codeRepos) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_codeRepos), refresh);

  /// Create a copy of CodeRepoMgmtState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeRepoMgmtStateImplCopyWith<_$CodeRepoMgmtStateImpl> get copyWith =>
      __$$CodeRepoMgmtStateImplCopyWithImpl<_$CodeRepoMgmtStateImpl>(
          this, _$identity);
}

abstract class _CodeRepoMgmtState implements CodeRepoMgmtState {
  const factory _CodeRepoMgmtState(
      {final List<CodeRepoState> codeRepos,
      final int refresh}) = _$CodeRepoMgmtStateImpl;

  @override
  List<CodeRepoState> get codeRepos;
  @override
  int get refresh;

  /// Create a copy of CodeRepoMgmtState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeRepoMgmtStateImplCopyWith<_$CodeRepoMgmtStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CodeRepoState {
  String get repoName => throw _privateConstructorUsedError;
  String get branch => throw _privateConstructorUsedError;

  /// Create a copy of CodeRepoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodeRepoStateCopyWith<CodeRepoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeRepoStateCopyWith<$Res> {
  factory $CodeRepoStateCopyWith(
          CodeRepoState value, $Res Function(CodeRepoState) then) =
      _$CodeRepoStateCopyWithImpl<$Res, CodeRepoState>;
  @useResult
  $Res call({String repoName, String branch});
}

/// @nodoc
class _$CodeRepoStateCopyWithImpl<$Res, $Val extends CodeRepoState>
    implements $CodeRepoStateCopyWith<$Res> {
  _$CodeRepoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CodeRepoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repoName = null,
    Object? branch = null,
  }) {
    return _then(_value.copyWith(
      repoName: null == repoName
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CodeRepoStateImplCopyWith<$Res>
    implements $CodeRepoStateCopyWith<$Res> {
  factory _$$CodeRepoStateImplCopyWith(
          _$CodeRepoStateImpl value, $Res Function(_$CodeRepoStateImpl) then) =
      __$$CodeRepoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String repoName, String branch});
}

/// @nodoc
class __$$CodeRepoStateImplCopyWithImpl<$Res>
    extends _$CodeRepoStateCopyWithImpl<$Res, _$CodeRepoStateImpl>
    implements _$$CodeRepoStateImplCopyWith<$Res> {
  __$$CodeRepoStateImplCopyWithImpl(
      _$CodeRepoStateImpl _value, $Res Function(_$CodeRepoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CodeRepoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repoName = null,
    Object? branch = null,
  }) {
    return _then(_$CodeRepoStateImpl(
      repoName: null == repoName
          ? _value.repoName
          : repoName // ignore: cast_nullable_to_non_nullable
              as String,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CodeRepoStateImpl implements _CodeRepoState {
  const _$CodeRepoStateImpl({required this.repoName, this.branch = 'unknown'});

  @override
  final String repoName;
  @override
  @JsonKey()
  final String branch;

  @override
  String toString() {
    return 'CodeRepoState(repoName: $repoName, branch: $branch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeRepoStateImpl &&
            (identical(other.repoName, repoName) ||
                other.repoName == repoName) &&
            (identical(other.branch, branch) || other.branch == branch));
  }

  @override
  int get hashCode => Object.hash(runtimeType, repoName, branch);

  /// Create a copy of CodeRepoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeRepoStateImplCopyWith<_$CodeRepoStateImpl> get copyWith =>
      __$$CodeRepoStateImplCopyWithImpl<_$CodeRepoStateImpl>(this, _$identity);
}

abstract class _CodeRepoState implements CodeRepoState {
  const factory _CodeRepoState(
      {required final String repoName,
      final String branch}) = _$CodeRepoStateImpl;

  @override
  String get repoName;
  @override
  String get branch;

  /// Create a copy of CodeRepoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeRepoStateImplCopyWith<_$CodeRepoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
