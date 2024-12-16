import 'package:see_weather/core/utils/string_constants.dart';

class DateTimeUtils {
    String compareTimes(String localtime, String moonrise, String sunrise) {
    // Eğer herhangi bir değer boş ise işlem yapmayalım
    if (localtime.isEmpty || moonrise.isEmpty || sunrise.isEmpty) {
      return "";
    }

    try {
      // Localtime'ı DateTime'e çevir
      DateTime localDateTime = DateTime.parse(localtime);

      // Moonrise ve Sunrise'ı 24 saat formatına dönüştür
      String convertedMoonrise = convertTo24HourFormat(moonrise);
      String convertedSunrise = convertTo24HourFormat(sunrise);

      // Tarih bilgisi ile birleştir
      DateTime moonriseDateTime = parseTimeWithDate(convertedMoonrise, localDateTime);
      DateTime sunriseDateTime = parseTimeWithDate(convertedSunrise, localDateTime);

    

      // Gündüz veya gece kontrolü
      if (localDateTime.isAfter(sunriseDateTime) && localDateTime.isBefore(moonriseDateTime)) {
        return StringConstants().gunduz;
      } else {
        return StringConstants().gece;
      }
    } catch (e) {
      print("Error in compareTimes: $e");
      return "";
    }
  }

  DateTime parseTimeWithDate(String time, DateTime baseDate) {
    try {
      List<String> parts = time.split(":");
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      return DateTime(baseDate.year, baseDate.month, baseDate.day, hour, minute);
    } catch (e) {
      throw Exception("Invalid time format: $time");
    }
  }

  String convertTo24HourFormat(String time) {
    if (time.isEmpty) return "";

    try {
      // AM/PM'i ayır
      bool isPM = time.toLowerCase().contains("pm");
      String timeWithoutSuffix = time.replaceAll(RegExp(r'[APap][Mm]'), '').trim();

      // Saat ve dakikayı al
      List<String> parts = timeWithoutSuffix.split(":");
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      // 24 saat formatına dönüştür
      if (isPM && hour != 12) {
        hour += 12; // PM ise 12 ekle
      } else if (!isPM && hour == 12) {
        hour = 0; // AM ve 12 ise saat 0 olur
      }

      return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    } catch (e) {
      throw Exception("Invalid time format: $time");
    }
  }
}
