// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Planner {

 String get id; DateTime get date; List<Task> get tasks; PlannerSettings get settings; Summary get summary; DateTime get lastUpdated;
/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerCopyWith<Planner> get copyWith => _$PlannerCopyWithImpl<Planner>(this as Planner, _$identity);

  /// Serializes this Planner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Planner&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.tasks, tasks)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,const DeepCollectionEquality().hash(tasks),settings,summary,lastUpdated);

@override
String toString() {
  return 'Planner(id: $id, date: $date, tasks: $tasks, settings: $settings, summary: $summary, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $PlannerCopyWith<$Res>  {
  factory $PlannerCopyWith(Planner value, $Res Function(Planner) _then) = _$PlannerCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, List<Task> tasks, PlannerSettings settings, Summary summary, DateTime lastUpdated
});


$PlannerSettingsCopyWith<$Res> get settings;$SummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$PlannerCopyWithImpl<$Res>
    implements $PlannerCopyWith<$Res> {
  _$PlannerCopyWithImpl(this._self, this._then);

  final Planner _self;
  final $Res Function(Planner) _then;

/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? tasks = null,Object? settings = null,Object? summary = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PlannerSettings,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Summary,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlannerSettingsCopyWith<$Res> get settings {
  
  return $PlannerSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryCopyWith<$Res> get summary {
  
  return $SummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [Planner].
extension PlannerPatterns on Planner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Planner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Planner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Planner value)  $default,){
final _that = this;
switch (_that) {
case _Planner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Planner value)?  $default,){
final _that = this;
switch (_that) {
case _Planner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  List<Task> tasks,  PlannerSettings settings,  Summary summary,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Planner() when $default != null:
return $default(_that.id,_that.date,_that.tasks,_that.settings,_that.summary,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  List<Task> tasks,  PlannerSettings settings,  Summary summary,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _Planner():
return $default(_that.id,_that.date,_that.tasks,_that.settings,_that.summary,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  List<Task> tasks,  PlannerSettings settings,  Summary summary,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _Planner() when $default != null:
return $default(_that.id,_that.date,_that.tasks,_that.settings,_that.summary,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Planner implements Planner {
  const _Planner({required this.id, required this.date, final  List<Task> tasks = const [], required this.settings, required this.summary, required this.lastUpdated}): _tasks = tasks;
  factory _Planner.fromJson(Map<String, dynamic> json) => _$PlannerFromJson(json);

@override final  String id;
@override final  DateTime date;
 final  List<Task> _tasks;
@override@JsonKey() List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override final  PlannerSettings settings;
@override final  Summary summary;
@override final  DateTime lastUpdated;

/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerCopyWith<_Planner> get copyWith => __$PlannerCopyWithImpl<_Planner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlannerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Planner&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._tasks, _tasks)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,const DeepCollectionEquality().hash(_tasks),settings,summary,lastUpdated);

@override
String toString() {
  return 'Planner(id: $id, date: $date, tasks: $tasks, settings: $settings, summary: $summary, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$PlannerCopyWith<$Res> implements $PlannerCopyWith<$Res> {
  factory _$PlannerCopyWith(_Planner value, $Res Function(_Planner) _then) = __$PlannerCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, List<Task> tasks, PlannerSettings settings, Summary summary, DateTime lastUpdated
});


@override $PlannerSettingsCopyWith<$Res> get settings;@override $SummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$PlannerCopyWithImpl<$Res>
    implements _$PlannerCopyWith<$Res> {
  __$PlannerCopyWithImpl(this._self, this._then);

  final _Planner _self;
  final $Res Function(_Planner) _then;

/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? tasks = null,Object? settings = null,Object? summary = null,Object? lastUpdated = null,}) {
  return _then(_Planner(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as PlannerSettings,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as Summary,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlannerSettingsCopyWith<$Res> get settings {
  
  return $PlannerSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of Planner
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryCopyWith<$Res> get summary {
  
  return $SummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
