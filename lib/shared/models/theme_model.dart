import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'theme_model.freezed.dart';
part 'theme_model.g.dart';

/// Custom converter for Color to/from int for JSON serialization
class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.toARGB32();
}

@freezed
abstract class ThemeModel with _$ThemeModel {
  const factory ThemeModel({
    required String name,
    @ColorConverter() required Color background,
    @ColorConverter() required Color timeline,
    @ColorConverter() required Color taskFill,
    @ColorConverter() required Color taskBorder,
    @ColorConverter() required Color breakFill,
    @ColorConverter() required Color breakBorder,
  }) = _ThemeModel;

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);
}
