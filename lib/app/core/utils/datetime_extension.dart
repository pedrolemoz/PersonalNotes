extension DateTimeExtension on DateTime {
  String get asDayMonthYear => '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

  String get timeAs24Hours => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String get formattedDateTime => '$asDayMonthYear às $timeAs24Hours';
}
