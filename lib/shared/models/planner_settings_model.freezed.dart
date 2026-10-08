// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlannerSettings {

 String get theme; List<int> get taskColor; List<int> get taskBorderColor; List<int> get breakColor; List<int> get breakBorderColor; int get dayStartMinute; int get dayEndMinute; double get timeFontSize; bool get timeFontBold; bool get use24HourFormat;
/// Create a copy of PlannerSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerSettingsCopyWith<PlannerSettings> get copyWith => _$PlannerSettingsCopyWithImpl<PlannerSettings>(this as PlannerSettings, _$identity);

  /// Serializes this PlannerSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerSettings&&(identical(other.theme, theme) || other.theme == theme)&&const DeepCollectionEquality().equals(other.taskColor, taskColor)&&const DeepCollectionEquality().equals(other.taskBorderColor, taskBorderColor)&&const DeepCollectionEquality().equals(other.breakColor, breakColor)&&const DeepCollectionEquality().equals(other.breakBorderColor, breakBorderColor)&&(identical(other.dayStartMinute, dayStartMinute) || other.dayStartMinute == dayStartMinute)&&(identical(other.dayEndMinute, dayEndMinute) || other.dayEndMinute == dayEndMinute)&&(identical(other.timeFontSize, timeFontSize) || other.timeFontSize == timeFontSize)&&(identical(other.timeFontBold, timeFontBold) || other.timeFontBold == timeFontBold)&&(identical(other.use24HourFormat, use24HourFormat) || other.use24HourFormat == use24HourFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,const DeepCollectionEquality().hash(taskColor),const DeepCollectionEquality().hash(taskBorderColor),const DeepCollectionEquality().hash(breakColor),const DeepCollectionEquality().hash(breakBorderColor),dayStartMinute,dayEndMinute,timeFontSize,timeFontBold,use24HourFormat);

@override
String toString() {
  return 'PlannerSettings(theme: $theme, taskColor: $taskColor, taskBorderColor: $taskBorderColor, breakColor: $breakColor, breakBorderColor: $breakBorderColor, dayStartMinute: $dayStartMinute, dayEndMinute: $dayEndMinute, timeFontSize: $timeFontSize, timeFontBold: $timeFontBold, use24HourFormat: $use24HourFormat)';
}


}

/// @nodoc
abstract mixin class $PlannerSettingsCopyWith<$Res>  {
  factory $PlannerSettingsCopyWith(PlannerSettings value, $Res Function(PlannerSettings) _then) = _$PlannerSettingsCopyWithImpl;
@useResult
$Res call({
 String theme, List<int> taskColor, List<int> taskBorderColor, List<int> breakColor, List<int> breakBorderColor, int dayStartMinute, int dayEndMinute, double timeFontSize, bool timeFontBold, bool use24HourFormat
});




}
/// @nodoc
class _$PlannerSettingsCopyWithImpl<$Res>
    implements $PlannerSettingsCopyWith<$Res> {
  _$PlannerSettingsCopyWithImpl(this._self, this._then);

  final PlannerSettings _self;
  final $Res Function(PlannerSettings) _then;

/// Create a copy of PlannerSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? taskColor = null,Object? taskBorderColor = null,Object? breakColor = null,Object? breakBorderColor = null,Object? dayStartMinute = null,Object? dayEndMinute = null,Object? timeFontSize = null,Object? timeFontBold = null,Object? use24HourFormat = null,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,taskColor: null == taskColor ? _self.taskColor : taskColor // ignore: cast_nullable_to_non_nullable
as List<int>,taskBorderColor: null == taskBorderColor ? _self.taskBorderColor : taskBorderColor // ignore: cast_nullable_to_non_nullable
as List<int>,breakColor: null == breakColor ? _self.breakColor : breakColor // ignore: cast_nullable_to_non_nullable
as List<int>,breakBorderColor: null == breakBorderColor ? _self.breakBorderColor : breakBorderColor // ignore: cast_nullable_to_non_nullable
as List<int>,dayStartMinute: null == dayStartMinute ? _self.dayStartMinute : dayStartMinute // ignore: cast_nullable_to_non_nullable
as int,dayEndMinute: null == dayEndMinute ? _self.dayEndMinute : dayEndMinute // ignore: cast_nullable_to_non_nullable
as int,timeFontSize: null == timeFontSize ? _self.timeFontSize : timeFontSize // ignore: cast_nullable_to_non_nullable
as double,timeFontBold: null == timeFontBold ? _self.timeFontBold : timeFontBold // ignore: cast_nullable_to_non_nullable
as bool,use24HourFormat: null == use24HourFormat ? _self.use24HourFormat : use24HourFormat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerSettings].
extension PlannerSettingsPatterns on PlannerSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerSettings value)  $default,){
final _that = this;
switch (_that) {
case _PlannerSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String theme,  List<int> taskColor,  List<int> taskBorderColor,  List<int> breakColor,  List<int> breakBorderColor,  int dayStartMinute,  int dayEndMinute,  double timeFontSize,  bool timeFontBold,  bool use24HourFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerSettings() when $default != null:
return $default(_that.theme,_that.taskColor,_that.taskBorderColor,_that.breakColor,_that.breakBorderColor,_that.dayStartMinute,_that.dayEndMinute,_that.timeFontSize,_that.timeFontBold,_that.use24HourFormat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String theme,  List<int> taskColor,  List<int> taskBorderColor,  List<int> breakColor,  List<int> breakBorderColor,  int dayStartMinute,  int dayEndMinute,  double timeFontSize,  bool timeFontBold,  bool use24HourFormat)  $default,) {final _that = this;
switch (_that) {
case _PlannerSettings():
return $default(_that.theme,_that.taskColor,_that.taskBorderColor,_that.breakColor,_that.breakBorderColor,_that.dayStartMinute,_that.dayEndMinute,_that.timeFontSize,_that.timeFontBold,_that.use24HourFormat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String theme,  List<int> taskColor,  List<int> taskBorderColor,  List<int> breakColor,  List<int> breakBorderColor,  int dayStartMinute,  int dayEndMinute,  double timeFontSize,  bool timeFontBold,  bool use24HourFormat)?  $default,) {final _that = this;
switch (_that) {
case _PlannerSettings() when $default != null:
return $default(_that.theme,_that.taskColor,_that.taskBorderColor,_that.breakColor,_that.breakBorderColor,_that.dayStartMinute,_that.dayEndMinute,_that.timeFontSize,_that.timeFontBold,_that.use24HourFormat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlannerSettings implements PlannerSettings {
  const _PlannerSettings({this.theme = 'Default', final  List<int> taskColor = const [60, 100, 200, 180], final  List<int> taskBorderColor = const [100, 150, 220], final  List<int> breakColor = const [60, 120, 80, 180], final  List<int> breakBorderColor = const [100, 200, 120], this.dayStartMinute = AppConstants.defaultDayStartMinute, this.dayEndMinute = AppConstants.defaultDayEndMinute, this.timeFontSize = AppConstants.defaultTimeFontSize, this.timeFontBold = AppConstants.defaultTimeFontBold, this.use24HourFormat = false}): _taskColor = taskColor,_taskBorderColor = taskBorderColor,_breakColor = breakColor,_breakBorderColor = breakBorderColor;
  factory _PlannerSettings.fromJson(Map<String, dynamic> json) => _$PlannerSettingsFromJson(json);

@override@JsonKey() final  String theme;
 final  List<int> _taskColor;
@override@JsonKey() List<int> get taskColor {
  if (_taskColor is EqualUnmodifiableListView) return _taskColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taskColor);
}

 final  List<int> _taskBorderColor;
@override@JsonKey() List<int> get taskBorderColor {
  if (_taskBorderColor is EqualUnmodifiableListView) return _taskBorderColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_taskBorderColor);
}

 final  List<int> _breakColor;
@override@JsonKey() List<int> get breakColor {
  if (_breakColor is EqualUnmodifiableListView) return _breakColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_breakColor);
}

 final  List<int> _breakBorderColor;
@override@JsonKey() List<int> get breakBorderColor {
  if (_breakBorderColor is EqualUnmodifiableListView) return _breakBorderColor;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_breakBorderColor);
}

@override@JsonKey() final  int dayStartMinute;
@override@JsonKey() final  int dayEndMinute;
@override@JsonKey() final  double timeFontSize;
@override@JsonKey() final  bool timeFontBold;
@override@JsonKey() final  bool use24HourFormat;

/// Create a copy of PlannerSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerSettingsCopyWith<_PlannerSettings> get copyWith => __$PlannerSettingsCopyWithImpl<_PlannerSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannerSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerSettings&&(identical(other.theme, theme) || other.theme == theme)&&const DeepCollectionEquality().equals(other._taskColor, _taskColor)&&const DeepCollectionEquality().equals(other._taskBorderColor, _taskBorderColor)&&const DeepCollectionEquality().equals(other._breakColor, _breakColor)&&const DeepCollectionEquality().equals(other._breakBorderColor, _breakBorderColor)&&(identical(other.dayStartMinute, dayStartMinute) || other.dayStartMinute == dayStartMinute)&&(identical(other.dayEndMinute, dayEndMinute) || other.dayEndMinute == dayEndMinute)&&(identical(other.timeFontSize, timeFontSize) || other.timeFontSize == timeFontSize)&&(identical(other.timeFontBold, timeFontBold) || other.timeFontBold == timeFontBold)&&(identical(other.use24HourFormat, use24HourFormat) || other.use24HourFormat == use24HourFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,const DeepCollectionEquality().hash(_taskColor),const DeepCollectionEquality().hash(_taskBorderColor),const DeepCollectionEquality().hash(_breakColor),const DeepCollectionEquality().hash(_breakBorderColor),dayStartMinute,dayEndMinute,timeFontSize,timeFontBold,use24HourFormat);

@override
String toString() {
  return 'PlannerSettings(theme: $theme, taskColor: $taskColor, taskBorderColor: $taskBorderColor, breakColor: $breakColor, breakBorderColor: $breakBorderColor, dayStartMinute: $dayStartMinute, dayEndMinute: $dayEndMinute, timeFontSize: $timeFontSize, timeFontBold: $timeFontBold, use24HourFormat: $use24HourFormat)';
}


}

/// @nodoc
abstract mixin class _$PlannerSettingsCopyWith<$Res> implements $PlannerSettingsCopyWith<$Res> {
  factory _$PlannerSettingsCopyWith(_PlannerSettings value, $Res Function(_PlannerSettings) _then) = __$PlannerSettingsCopyWithImpl;
@override @useResult
$Res call({
 String theme, List<int> taskColor, List<int> taskBorderColor, List<int> breakColor, List<int> breakBorderColor, int dayStartMinute, int dayEndMinute, double timeFontSize, bool timeFontBold, bool use24HourFormat
});




}
/// @nodoc
class __$PlannerSettingsCopyWithImpl<$Res>
    implements _$PlannerSettingsCopyWith<$Res> {
  __$PlannerSettingsCopyWithImpl(this._self, this._then);

  final _PlannerSettings _self;
  final $Res Function(_PlannerSettings) _then;

/// Create a copy of PlannerSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? taskColor = null,Object? taskBorderColor = null,Object? breakColor = null,Object? breakBorderColor = null,Object? dayStartMinute = null,Object? dayEndMinute = null,Object? timeFontSize = null,Object? timeFontBold = null,Object? use24HourFormat = null,}) {
  return _then(_PlannerSettings(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,taskColor: null == taskColor ? _self._taskColor : taskColor // ignore: cast_nullable_to_non_nullable
as List<int>,taskBorderColor: null == taskBorderColor ? _self._taskBorderColor : taskBorderColor // ignore: cast_nullable_to_non_nullable
as List<int>,breakColor: null == breakColor ? _self._breakColor : breakColor // ignore: cast_nullable_to_non_nullable
as List<int>,breakBorderColor: null == breakBorderColor ? _self._breakBorderColor : breakBorderColor // ignore: cast_nullable_to_non_nullable
as List<int>,dayStartMinute: null == dayStartMinute ? _self.dayStartMinute : dayStartMinute // ignore: cast_nullable_to_non_nullable
as int,dayEndMinute: null == dayEndMinute ? _self.dayEndMinute : dayEndMinute // ignore: cast_nullable_to_non_nullable
as int,timeFontSize: null == timeFontSize ? _self.timeFontSize : timeFontSize // ignore: cast_nullable_to_non_nullable
as double,timeFontBold: null == timeFontBold ? _self.timeFontBold : timeFontBold // ignore: cast_nullable_to_non_nullable
as bool,use24HourFormat: null == use24HourFormat ? _self.use24HourFormat : use24HourFormat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
