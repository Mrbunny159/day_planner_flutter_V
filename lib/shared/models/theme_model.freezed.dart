// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeModel {

 String get name;@ColorConverter() Color get background;@ColorConverter() Color get timeline;@ColorConverter() Color get taskFill;@ColorConverter() Color get taskBorder;@ColorConverter() Color get breakFill;@ColorConverter() Color get breakBorder;
/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeModelCopyWith<ThemeModel> get copyWith => _$ThemeModelCopyWithImpl<ThemeModel>(this as ThemeModel, _$identity);

  /// Serializes this ThemeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeModel&&(identical(other.name, name) || other.name == name)&&(identical(other.background, background) || other.background == background)&&(identical(other.timeline, timeline) || other.timeline == timeline)&&(identical(other.taskFill, taskFill) || other.taskFill == taskFill)&&(identical(other.taskBorder, taskBorder) || other.taskBorder == taskBorder)&&(identical(other.breakFill, breakFill) || other.breakFill == breakFill)&&(identical(other.breakBorder, breakBorder) || other.breakBorder == breakBorder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,background,timeline,taskFill,taskBorder,breakFill,breakBorder);

@override
String toString() {
  return 'ThemeModel(name: $name, background: $background, timeline: $timeline, taskFill: $taskFill, taskBorder: $taskBorder, breakFill: $breakFill, breakBorder: $breakBorder)';
}


}

/// @nodoc
abstract mixin class $ThemeModelCopyWith<$Res>  {
  factory $ThemeModelCopyWith(ThemeModel value, $Res Function(ThemeModel) _then) = _$ThemeModelCopyWithImpl;
@useResult
$Res call({
 String name,@ColorConverter() Color background,@ColorConverter() Color timeline,@ColorConverter() Color taskFill,@ColorConverter() Color taskBorder,@ColorConverter() Color breakFill,@ColorConverter() Color breakBorder
});




}
/// @nodoc
class _$ThemeModelCopyWithImpl<$Res>
    implements $ThemeModelCopyWith<$Res> {
  _$ThemeModelCopyWithImpl(this._self, this._then);

  final ThemeModel _self;
  final $Res Function(ThemeModel) _then;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? background = null,Object? timeline = null,Object? taskFill = null,Object? taskBorder = null,Object? breakFill = null,Object? breakBorder = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as Color,taskFill: null == taskFill ? _self.taskFill : taskFill // ignore: cast_nullable_to_non_nullable
as Color,taskBorder: null == taskBorder ? _self.taskBorder : taskBorder // ignore: cast_nullable_to_non_nullable
as Color,breakFill: null == breakFill ? _self.breakFill : breakFill // ignore: cast_nullable_to_non_nullable
as Color,breakBorder: null == breakBorder ? _self.breakBorder : breakBorder // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeModel].
extension ThemeModelPatterns on ThemeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeModel value)  $default,){
final _that = this;
switch (_that) {
case _ThemeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @ColorConverter()  Color background, @ColorConverter()  Color timeline, @ColorConverter()  Color taskFill, @ColorConverter()  Color taskBorder, @ColorConverter()  Color breakFill, @ColorConverter()  Color breakBorder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
return $default(_that.name,_that.background,_that.timeline,_that.taskFill,_that.taskBorder,_that.breakFill,_that.breakBorder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @ColorConverter()  Color background, @ColorConverter()  Color timeline, @ColorConverter()  Color taskFill, @ColorConverter()  Color taskBorder, @ColorConverter()  Color breakFill, @ColorConverter()  Color breakBorder)  $default,) {final _that = this;
switch (_that) {
case _ThemeModel():
return $default(_that.name,_that.background,_that.timeline,_that.taskFill,_that.taskBorder,_that.breakFill,_that.breakBorder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @ColorConverter()  Color background, @ColorConverter()  Color timeline, @ColorConverter()  Color taskFill, @ColorConverter()  Color taskBorder, @ColorConverter()  Color breakFill, @ColorConverter()  Color breakBorder)?  $default,) {final _that = this;
switch (_that) {
case _ThemeModel() when $default != null:
return $default(_that.name,_that.background,_that.timeline,_that.taskFill,_that.taskBorder,_that.breakFill,_that.breakBorder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemeModel implements ThemeModel {
  const _ThemeModel({required this.name, @ColorConverter() required this.background, @ColorConverter() required this.timeline, @ColorConverter() required this.taskFill, @ColorConverter() required this.taskBorder, @ColorConverter() required this.breakFill, @ColorConverter() required this.breakBorder});
  factory _ThemeModel.fromJson(Map<String, dynamic> json) => _$ThemeModelFromJson(json);

@override final  String name;
@override@ColorConverter() final  Color background;
@override@ColorConverter() final  Color timeline;
@override@ColorConverter() final  Color taskFill;
@override@ColorConverter() final  Color taskBorder;
@override@ColorConverter() final  Color breakFill;
@override@ColorConverter() final  Color breakBorder;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeModelCopyWith<_ThemeModel> get copyWith => __$ThemeModelCopyWithImpl<_ThemeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeModel&&(identical(other.name, name) || other.name == name)&&(identical(other.background, background) || other.background == background)&&(identical(other.timeline, timeline) || other.timeline == timeline)&&(identical(other.taskFill, taskFill) || other.taskFill == taskFill)&&(identical(other.taskBorder, taskBorder) || other.taskBorder == taskBorder)&&(identical(other.breakFill, breakFill) || other.breakFill == breakFill)&&(identical(other.breakBorder, breakBorder) || other.breakBorder == breakBorder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,background,timeline,taskFill,taskBorder,breakFill,breakBorder);

@override
String toString() {
  return 'ThemeModel(name: $name, background: $background, timeline: $timeline, taskFill: $taskFill, taskBorder: $taskBorder, breakFill: $breakFill, breakBorder: $breakBorder)';
}


}

/// @nodoc
abstract mixin class _$ThemeModelCopyWith<$Res> implements $ThemeModelCopyWith<$Res> {
  factory _$ThemeModelCopyWith(_ThemeModel value, $Res Function(_ThemeModel) _then) = __$ThemeModelCopyWithImpl;
@override @useResult
$Res call({
 String name,@ColorConverter() Color background,@ColorConverter() Color timeline,@ColorConverter() Color taskFill,@ColorConverter() Color taskBorder,@ColorConverter() Color breakFill,@ColorConverter() Color breakBorder
});




}
/// @nodoc
class __$ThemeModelCopyWithImpl<$Res>
    implements _$ThemeModelCopyWith<$Res> {
  __$ThemeModelCopyWithImpl(this._self, this._then);

  final _ThemeModel _self;
  final $Res Function(_ThemeModel) _then;

/// Create a copy of ThemeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? background = null,Object? timeline = null,Object? taskFill = null,Object? taskBorder = null,Object? breakFill = null,Object? breakBorder = null,}) {
  return _then(_ThemeModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as Color,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as Color,taskFill: null == taskFill ? _self.taskFill : taskFill // ignore: cast_nullable_to_non_nullable
as Color,taskBorder: null == taskBorder ? _self.taskBorder : taskBorder // ignore: cast_nullable_to_non_nullable
as Color,breakFill: null == breakFill ? _self.breakFill : breakFill // ignore: cast_nullable_to_non_nullable
as Color,breakBorder: null == breakBorder ? _self.breakBorder : breakBorder // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
