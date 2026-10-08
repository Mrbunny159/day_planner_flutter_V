// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BlockDraft {

 String? get id; String get name; String get description; BlockType get type; int get startMinute; int get duration; ColorTag get colorTag; Repeat get recurring;
/// Create a copy of BlockDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockDraftCopyWith<BlockDraft> get copyWith => _$BlockDraftCopyWithImpl<BlockDraft>(this as BlockDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.colorTag, colorTag) || other.colorTag == colorTag)&&(identical(other.recurring, recurring) || other.recurring == recurring));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,startMinute,duration,colorTag,recurring);

@override
String toString() {
  return 'BlockDraft(id: $id, name: $name, description: $description, type: $type, startMinute: $startMinute, duration: $duration, colorTag: $colorTag, recurring: $recurring)';
}


}

/// @nodoc
abstract mixin class $BlockDraftCopyWith<$Res>  {
  factory $BlockDraftCopyWith(BlockDraft value, $Res Function(BlockDraft) _then) = _$BlockDraftCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String description, BlockType type, int startMinute, int duration, ColorTag colorTag, Repeat recurring
});




}
/// @nodoc
class _$BlockDraftCopyWithImpl<$Res>
    implements $BlockDraftCopyWith<$Res> {
  _$BlockDraftCopyWithImpl(this._self, this._then);

  final BlockDraft _self;
  final $Res Function(BlockDraft) _then;

/// Create a copy of BlockDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? description = null,Object? type = null,Object? startMinute = null,Object? duration = null,Object? colorTag = null,Object? recurring = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,colorTag: null == colorTag ? _self.colorTag : colorTag // ignore: cast_nullable_to_non_nullable
as ColorTag,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as Repeat,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockDraft].
extension BlockDraftPatterns on BlockDraft {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockDraft() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockDraft value)  $default,){
final _that = this;
switch (_that) {
case _BlockDraft():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockDraft value)?  $default,){
final _that = this;
switch (_that) {
case _BlockDraft() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String description,  BlockType type,  int startMinute,  int duration,  ColorTag colorTag,  Repeat recurring)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockDraft() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.startMinute,_that.duration,_that.colorTag,_that.recurring);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String description,  BlockType type,  int startMinute,  int duration,  ColorTag colorTag,  Repeat recurring)  $default,) {final _that = this;
switch (_that) {
case _BlockDraft():
return $default(_that.id,_that.name,_that.description,_that.type,_that.startMinute,_that.duration,_that.colorTag,_that.recurring);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String description,  BlockType type,  int startMinute,  int duration,  ColorTag colorTag,  Repeat recurring)?  $default,) {final _that = this;
switch (_that) {
case _BlockDraft() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.startMinute,_that.duration,_that.colorTag,_that.recurring);case _:
  return null;

}
}

}

/// @nodoc


class _BlockDraft implements BlockDraft {
  const _BlockDraft({this.id, this.name = 'Untitled', this.description = '', this.type = BlockType.task, this.startMinute = 540, this.duration = 60, this.colorTag = ColorTag.none, this.recurring = Repeat.none});
  

@override final  String? id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String description;
@override@JsonKey() final  BlockType type;
@override@JsonKey() final  int startMinute;
@override@JsonKey() final  int duration;
@override@JsonKey() final  ColorTag colorTag;
@override@JsonKey() final  Repeat recurring;

/// Create a copy of BlockDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockDraftCopyWith<_BlockDraft> get copyWith => __$BlockDraftCopyWithImpl<_BlockDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockDraft&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.colorTag, colorTag) || other.colorTag == colorTag)&&(identical(other.recurring, recurring) || other.recurring == recurring));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,startMinute,duration,colorTag,recurring);

@override
String toString() {
  return 'BlockDraft(id: $id, name: $name, description: $description, type: $type, startMinute: $startMinute, duration: $duration, colorTag: $colorTag, recurring: $recurring)';
}


}

/// @nodoc
abstract mixin class _$BlockDraftCopyWith<$Res> implements $BlockDraftCopyWith<$Res> {
  factory _$BlockDraftCopyWith(_BlockDraft value, $Res Function(_BlockDraft) _then) = __$BlockDraftCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String description, BlockType type, int startMinute, int duration, ColorTag colorTag, Repeat recurring
});




}
/// @nodoc
class __$BlockDraftCopyWithImpl<$Res>
    implements _$BlockDraftCopyWith<$Res> {
  __$BlockDraftCopyWithImpl(this._self, this._then);

  final _BlockDraft _self;
  final $Res Function(_BlockDraft) _then;

/// Create a copy of BlockDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? description = null,Object? type = null,Object? startMinute = null,Object? duration = null,Object? colorTag = null,Object? recurring = null,}) {
  return _then(_BlockDraft(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,colorTag: null == colorTag ? _self.colorTag : colorTag // ignore: cast_nullable_to_non_nullable
as ColorTag,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as Repeat,
  ));
}


}

/// @nodoc
mixin _$SettingsDraft {

 int get dayStartMinute; int get dayEndMinute; bool get use24HourFormat;
/// Create a copy of SettingsDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsDraftCopyWith<SettingsDraft> get copyWith => _$SettingsDraftCopyWithImpl<SettingsDraft>(this as SettingsDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsDraft&&(identical(other.dayStartMinute, dayStartMinute) || other.dayStartMinute == dayStartMinute)&&(identical(other.dayEndMinute, dayEndMinute) || other.dayEndMinute == dayEndMinute)&&(identical(other.use24HourFormat, use24HourFormat) || other.use24HourFormat == use24HourFormat));
}


@override
int get hashCode => Object.hash(runtimeType,dayStartMinute,dayEndMinute,use24HourFormat);

@override
String toString() {
  return 'SettingsDraft(dayStartMinute: $dayStartMinute, dayEndMinute: $dayEndMinute, use24HourFormat: $use24HourFormat)';
}


}

/// @nodoc
abstract mixin class $SettingsDraftCopyWith<$Res>  {
  factory $SettingsDraftCopyWith(SettingsDraft value, $Res Function(SettingsDraft) _then) = _$SettingsDraftCopyWithImpl;
@useResult
$Res call({
 int dayStartMinute, int dayEndMinute, bool use24HourFormat
});




}
/// @nodoc
class _$SettingsDraftCopyWithImpl<$Res>
    implements $SettingsDraftCopyWith<$Res> {
  _$SettingsDraftCopyWithImpl(this._self, this._then);

  final SettingsDraft _self;
  final $Res Function(SettingsDraft) _then;

/// Create a copy of SettingsDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayStartMinute = null,Object? dayEndMinute = null,Object? use24HourFormat = null,}) {
  return _then(_self.copyWith(
dayStartMinute: null == dayStartMinute ? _self.dayStartMinute : dayStartMinute // ignore: cast_nullable_to_non_nullable
as int,dayEndMinute: null == dayEndMinute ? _self.dayEndMinute : dayEndMinute // ignore: cast_nullable_to_non_nullable
as int,use24HourFormat: null == use24HourFormat ? _self.use24HourFormat : use24HourFormat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsDraft].
extension SettingsDraftPatterns on SettingsDraft {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsDraft() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsDraft value)  $default,){
final _that = this;
switch (_that) {
case _SettingsDraft():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsDraft value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsDraft() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dayStartMinute,  int dayEndMinute,  bool use24HourFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsDraft() when $default != null:
return $default(_that.dayStartMinute,_that.dayEndMinute,_that.use24HourFormat);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dayStartMinute,  int dayEndMinute,  bool use24HourFormat)  $default,) {final _that = this;
switch (_that) {
case _SettingsDraft():
return $default(_that.dayStartMinute,_that.dayEndMinute,_that.use24HourFormat);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dayStartMinute,  int dayEndMinute,  bool use24HourFormat)?  $default,) {final _that = this;
switch (_that) {
case _SettingsDraft() when $default != null:
return $default(_that.dayStartMinute,_that.dayEndMinute,_that.use24HourFormat);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsDraft implements SettingsDraft {
  const _SettingsDraft({this.dayStartMinute = 540, this.dayEndMinute = 1020, this.use24HourFormat = false});
  

@override@JsonKey() final  int dayStartMinute;
@override@JsonKey() final  int dayEndMinute;
@override@JsonKey() final  bool use24HourFormat;

/// Create a copy of SettingsDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsDraftCopyWith<_SettingsDraft> get copyWith => __$SettingsDraftCopyWithImpl<_SettingsDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsDraft&&(identical(other.dayStartMinute, dayStartMinute) || other.dayStartMinute == dayStartMinute)&&(identical(other.dayEndMinute, dayEndMinute) || other.dayEndMinute == dayEndMinute)&&(identical(other.use24HourFormat, use24HourFormat) || other.use24HourFormat == use24HourFormat));
}


@override
int get hashCode => Object.hash(runtimeType,dayStartMinute,dayEndMinute,use24HourFormat);

@override
String toString() {
  return 'SettingsDraft(dayStartMinute: $dayStartMinute, dayEndMinute: $dayEndMinute, use24HourFormat: $use24HourFormat)';
}


}

/// @nodoc
abstract mixin class _$SettingsDraftCopyWith<$Res> implements $SettingsDraftCopyWith<$Res> {
  factory _$SettingsDraftCopyWith(_SettingsDraft value, $Res Function(_SettingsDraft) _then) = __$SettingsDraftCopyWithImpl;
@override @useResult
$Res call({
 int dayStartMinute, int dayEndMinute, bool use24HourFormat
});




}
/// @nodoc
class __$SettingsDraftCopyWithImpl<$Res>
    implements _$SettingsDraftCopyWith<$Res> {
  __$SettingsDraftCopyWithImpl(this._self, this._then);

  final _SettingsDraft _self;
  final $Res Function(_SettingsDraft) _then;

/// Create a copy of SettingsDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayStartMinute = null,Object? dayEndMinute = null,Object? use24HourFormat = null,}) {
  return _then(_SettingsDraft(
dayStartMinute: null == dayStartMinute ? _self.dayStartMinute : dayStartMinute // ignore: cast_nullable_to_non_nullable
as int,dayEndMinute: null == dayEndMinute ? _self.dayEndMinute : dayEndMinute // ignore: cast_nullable_to_non_nullable
as int,use24HourFormat: null == use24HourFormat ? _self.use24HourFormat : use24HourFormat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
