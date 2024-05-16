import 'package:freezed_annotation/freezed_annotation.dart';

class AppConfigs {
  static const String baseUrl = 'https://nettrom.com/api/v2';
}

enum DurationTime {
  @JsonValue("week")
  week,
  @JsonValue("month")
  month,
  @JsonValue("year")
  year,
}
