// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'money_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MoneyEvent {
  Change<dynamic> get change => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Change<dynamic> change) modifyMoney,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Change<dynamic> change)? modifyMoney,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Change<dynamic> change)? modifyMoney,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ModifyMoney value) modifyMoney,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ModifyMoney value)? modifyMoney,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ModifyMoney value)? modifyMoney,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoneyEventCopyWith<MoneyEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyEventCopyWith<$Res> {
  factory $MoneyEventCopyWith(
          MoneyEvent value, $Res Function(MoneyEvent) then) =
      _$MoneyEventCopyWithImpl<$Res, MoneyEvent>;
  @useResult
  $Res call({Change<dynamic> change});
}

/// @nodoc
class _$MoneyEventCopyWithImpl<$Res, $Val extends MoneyEvent>
    implements $MoneyEventCopyWith<$Res> {
  _$MoneyEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? change = null,
  }) {
    return _then(_value.copyWith(
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as Change<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModifyMoneyImplCopyWith<$Res>
    implements $MoneyEventCopyWith<$Res> {
  factory _$$ModifyMoneyImplCopyWith(
          _$ModifyMoneyImpl value, $Res Function(_$ModifyMoneyImpl) then) =
      __$$ModifyMoneyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Change<dynamic> change});
}

/// @nodoc
class __$$ModifyMoneyImplCopyWithImpl<$Res>
    extends _$MoneyEventCopyWithImpl<$Res, _$ModifyMoneyImpl>
    implements _$$ModifyMoneyImplCopyWith<$Res> {
  __$$ModifyMoneyImplCopyWithImpl(
      _$ModifyMoneyImpl _value, $Res Function(_$ModifyMoneyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? change = null,
  }) {
    return _then(_$ModifyMoneyImpl(
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as Change<dynamic>,
    ));
  }
}

/// @nodoc

class _$ModifyMoneyImpl implements _ModifyMoney {
  const _$ModifyMoneyImpl({required this.change});

  @override
  final Change<dynamic> change;

  @override
  String toString() {
    return 'MoneyEvent.modifyMoney(change: $change)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModifyMoneyImpl &&
            (identical(other.change, change) || other.change == change));
  }

  @override
  int get hashCode => Object.hash(runtimeType, change);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ModifyMoneyImplCopyWith<_$ModifyMoneyImpl> get copyWith =>
      __$$ModifyMoneyImplCopyWithImpl<_$ModifyMoneyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Change<dynamic> change) modifyMoney,
  }) {
    return modifyMoney(change);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Change<dynamic> change)? modifyMoney,
  }) {
    return modifyMoney?.call(change);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Change<dynamic> change)? modifyMoney,
    required TResult orElse(),
  }) {
    if (modifyMoney != null) {
      return modifyMoney(change);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ModifyMoney value) modifyMoney,
  }) {
    return modifyMoney(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ModifyMoney value)? modifyMoney,
  }) {
    return modifyMoney?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ModifyMoney value)? modifyMoney,
    required TResult orElse(),
  }) {
    if (modifyMoney != null) {
      return modifyMoney(this);
    }
    return orElse();
  }
}

abstract class _ModifyMoney implements MoneyEvent {
  const factory _ModifyMoney({required final Change<dynamic> change}) =
      _$ModifyMoneyImpl;

  @override
  Change<dynamic> get change;
  @override
  @JsonKey(ignore: true)
  _$$ModifyMoneyImplCopyWith<_$ModifyMoneyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MoneyState {
  int get moneyLeft => throw _privateConstructorUsedError;
  List<Change> get changes => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int moneyLeft, List<Change> changes) idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int moneyLeft, List<Change> changes)? idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int moneyLeft, List<Change> changes)? idle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MoneyStateCopyWith<MoneyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneyStateCopyWith<$Res> {
  factory $MoneyStateCopyWith(
          MoneyState value, $Res Function(MoneyState) then) =
      _$MoneyStateCopyWithImpl<$Res, MoneyState>;
  @useResult
  $Res call({int moneyLeft, List<Change> changes});
}

/// @nodoc
class _$MoneyStateCopyWithImpl<$Res, $Val extends MoneyState>
    implements $MoneyStateCopyWith<$Res> {
  _$MoneyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? moneyLeft = null,
    Object? changes = null,
  }) {
    return _then(_value.copyWith(
      moneyLeft: null == moneyLeft
          ? _value.moneyLeft
          : moneyLeft // ignore: cast_nullable_to_non_nullable
              as int,
      changes: null == changes
          ? _value.changes
          : changes // ignore: cast_nullable_to_non_nullable
              as List<Change>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> implements $MoneyStateCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int moneyLeft, List<Change> changes});
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$MoneyStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? moneyLeft = null,
    Object? changes = null,
  }) {
    return _then(_$IdleImpl(
      moneyLeft: null == moneyLeft
          ? _value.moneyLeft
          : moneyLeft // ignore: cast_nullable_to_non_nullable
              as int,
      changes: null == changes
          ? _value._changes
          : changes // ignore: cast_nullable_to_non_nullable
              as List<Change>,
    ));
  }
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl(
      {required this.moneyLeft, required final List<Change> changes})
      : _changes = changes;

  @override
  final int moneyLeft;
  final List<Change> _changes;
  @override
  List<Change> get changes {
    if (_changes is EqualUnmodifiableListView) return _changes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_changes);
  }

  @override
  String toString() {
    return 'MoneyState.idle(moneyLeft: $moneyLeft, changes: $changes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdleImpl &&
            (identical(other.moneyLeft, moneyLeft) ||
                other.moneyLeft == moneyLeft) &&
            const DeepCollectionEquality().equals(other._changes, _changes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, moneyLeft, const DeepCollectionEquality().hash(_changes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IdleImplCopyWith<_$IdleImpl> get copyWith =>
      __$$IdleImplCopyWithImpl<_$IdleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int moneyLeft, List<Change> changes) idle,
  }) {
    return idle(moneyLeft, changes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int moneyLeft, List<Change> changes)? idle,
  }) {
    return idle?.call(moneyLeft, changes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int moneyLeft, List<Change> changes)? idle,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(moneyLeft, changes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements MoneyState {
  const factory _Idle(
      {required final int moneyLeft,
      required final List<Change> changes}) = _$IdleImpl;

  @override
  int get moneyLeft;
  @override
  List<Change> get changes;
  @override
  @JsonKey(ignore: true)
  _$$IdleImplCopyWith<_$IdleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
