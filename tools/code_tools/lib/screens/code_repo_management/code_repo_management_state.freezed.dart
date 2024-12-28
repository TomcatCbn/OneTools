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
  List<CodeRepoEntity> get codeRepoEntities =>
      throw _privateConstructorUsedError;
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
  $Res call({List<CodeRepoEntity> codeRepoEntities, int refresh});
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
    Object? codeRepoEntities = null,
    Object? refresh = null,
  }) {
    return _then(_value.copyWith(
      codeRepoEntities: null == codeRepoEntities
          ? _value.codeRepoEntities
          : codeRepoEntities // ignore: cast_nullable_to_non_nullable
              as List<CodeRepoEntity>,
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
  $Res call({List<CodeRepoEntity> codeRepoEntities, int refresh});
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
    Object? codeRepoEntities = null,
    Object? refresh = null,
  }) {
    return _then(_$CodeRepoMgmtStateImpl(
      codeRepoEntities: null == codeRepoEntities
          ? _value._codeRepoEntities
          : codeRepoEntities // ignore: cast_nullable_to_non_nullable
              as List<CodeRepoEntity>,
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
      {final List<CodeRepoEntity> codeRepoEntities = const [],
      this.refresh = 0})
      : _codeRepoEntities = codeRepoEntities;

  final List<CodeRepoEntity> _codeRepoEntities;
  @override
  @JsonKey()
  List<CodeRepoEntity> get codeRepoEntities {
    if (_codeRepoEntities is EqualUnmodifiableListView)
      return _codeRepoEntities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codeRepoEntities);
  }

  @override
  @JsonKey()
  final int refresh;

  @override
  String toString() {
    return 'CodeRepoMgmtState(codeRepoEntities: $codeRepoEntities, refresh: $refresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeRepoMgmtStateImpl &&
            const DeepCollectionEquality()
                .equals(other._codeRepoEntities, _codeRepoEntities) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_codeRepoEntities), refresh);

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
      {final List<CodeRepoEntity> codeRepoEntities,
      final int refresh}) = _$CodeRepoMgmtStateImpl;

  @override
  List<CodeRepoEntity> get codeRepoEntities;
  @override
  int get refresh;

  /// Create a copy of CodeRepoMgmtState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeRepoMgmtStateImplCopyWith<_$CodeRepoMgmtStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
