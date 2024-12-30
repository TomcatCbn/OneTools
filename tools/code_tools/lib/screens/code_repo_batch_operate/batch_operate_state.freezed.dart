// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'batch_operate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BatchOperateState {
  List<CodeRepoState> get codeRepos => throw _privateConstructorUsedError;
  int get refreshIndex => throw _privateConstructorUsedError;

  /// Create a copy of BatchOperateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchOperateStateCopyWith<BatchOperateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchOperateStateCopyWith<$Res> {
  factory $BatchOperateStateCopyWith(
          BatchOperateState value, $Res Function(BatchOperateState) then) =
      _$BatchOperateStateCopyWithImpl<$Res, BatchOperateState>;
  @useResult
  $Res call({List<CodeRepoState> codeRepos, int refreshIndex});
}

/// @nodoc
class _$BatchOperateStateCopyWithImpl<$Res, $Val extends BatchOperateState>
    implements $BatchOperateStateCopyWith<$Res> {
  _$BatchOperateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchOperateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeRepos = null,
    Object? refreshIndex = null,
  }) {
    return _then(_value.copyWith(
      codeRepos: null == codeRepos
          ? _value.codeRepos
          : codeRepos // ignore: cast_nullable_to_non_nullable
              as List<CodeRepoState>,
      refreshIndex: null == refreshIndex
          ? _value.refreshIndex
          : refreshIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BatchOperateStateImplCopyWith<$Res>
    implements $BatchOperateStateCopyWith<$Res> {
  factory _$$BatchOperateStateImplCopyWith(_$BatchOperateStateImpl value,
          $Res Function(_$BatchOperateStateImpl) then) =
      __$$BatchOperateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CodeRepoState> codeRepos, int refreshIndex});
}

/// @nodoc
class __$$BatchOperateStateImplCopyWithImpl<$Res>
    extends _$BatchOperateStateCopyWithImpl<$Res, _$BatchOperateStateImpl>
    implements _$$BatchOperateStateImplCopyWith<$Res> {
  __$$BatchOperateStateImplCopyWithImpl(_$BatchOperateStateImpl _value,
      $Res Function(_$BatchOperateStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BatchOperateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeRepos = null,
    Object? refreshIndex = null,
  }) {
    return _then(_$BatchOperateStateImpl(
      codeRepos: null == codeRepos
          ? _value._codeRepos
          : codeRepos // ignore: cast_nullable_to_non_nullable
              as List<CodeRepoState>,
      refreshIndex: null == refreshIndex
          ? _value.refreshIndex
          : refreshIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BatchOperateStateImpl implements _BatchOperateState {
  const _$BatchOperateStateImpl(
      {final List<CodeRepoState> codeRepos = const [], this.refreshIndex = 0})
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
  final int refreshIndex;

  @override
  String toString() {
    return 'BatchOperateState(codeRepos: $codeRepos, refreshIndex: $refreshIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchOperateStateImpl &&
            const DeepCollectionEquality()
                .equals(other._codeRepos, _codeRepos) &&
            (identical(other.refreshIndex, refreshIndex) ||
                other.refreshIndex == refreshIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_codeRepos), refreshIndex);

  /// Create a copy of BatchOperateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchOperateStateImplCopyWith<_$BatchOperateStateImpl> get copyWith =>
      __$$BatchOperateStateImplCopyWithImpl<_$BatchOperateStateImpl>(
          this, _$identity);
}

abstract class _BatchOperateState implements BatchOperateState {
  const factory _BatchOperateState(
      {final List<CodeRepoState> codeRepos,
      final int refreshIndex}) = _$BatchOperateStateImpl;

  @override
  List<CodeRepoState> get codeRepos;
  @override
  int get refreshIndex;

  /// Create a copy of BatchOperateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchOperateStateImplCopyWith<_$BatchOperateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
