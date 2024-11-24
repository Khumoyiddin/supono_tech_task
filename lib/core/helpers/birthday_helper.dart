class BirthdayHelper {
  String formatBirthday(String date, String month, String year) {
    month = month.startsWith('0') ? month.substring(1) : month;

    if (!_isValidDate(date) || !_isValidMonth(month) || !_isValidYear(year)) {
      return '';
    }

    Map<String, String> monthNames = {
      '1': 'Jan',
      '2': 'Feb',
      '3': 'Mar',
      '4': 'Apr',
      '5': 'May',
      '6': 'Jun',
      '7': 'Jul',
      '8': 'Aug',
      '9': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dec'
    };

    String monthName = monthNames[month] ?? '';

    if (monthName.isEmpty) return '';

    return '$date $monthName $year';
  }

  bool _isValidDate(String date) {
    int? day = int.tryParse(date);
    return day != null && day >= 1 && day <= 31;
  }

  bool _isValidMonth(String month) {
    int? monthNum = int.tryParse(month);
    return monthNum != null && monthNum >= 1 && monthNum <= 12;
  }

  bool _isValidYear(String year) {
    int? yearNum = int.tryParse(year);
    int currentYear = DateTime.now().year;
    return yearNum != null && yearNum >= 1900 && yearNum <= currentYear;
  }
}
