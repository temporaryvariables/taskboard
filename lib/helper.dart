String getFormatedDateAndTime(DateTime dateTime) {
  String month = _getMonth(dateTime.month);
  String day = _getDay(dateTime.day);
  String hour = (dateTime.hour <= 12)
      ? dateTime.hour.toString()
      : (dateTime.hour - 12).toString();
  String minute = dateTime.minute.toString();
  String ampm = (dateTime.hour > 12) ? "PM" : "AM";
  String year = dateTime.year.toString();
  String date = "$month, $day $year @ $hour:$minute $ampm";
  return date;
}

String getFormatedDate(DateTime dateTime) {
  String month = _getMonth(dateTime.month);
  String day = _getDay(dateTime.day);
  String year = dateTime.year.toString();
  String date = "$month, $day $year";
  return date;
}

String _getMonth(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "Invalid Month";
  }
}

String _getDay(int day) {
  switch (day) {
    case 1:
      return "1st";
    case 2:
      return "2nd";
    case 3:
      return "3rd";
    case 4:
      return "4th";
    case 5:
      return "5th";
    case 6:
      return "6th";
    case 7:
      return "7th";
    case 8:
      return "8th";
    case 9:
      return "9th";
    case 10:
      return "10th";
    case 11:
      return "11th";
    case 12:
      return "12th";
    case 13:
      return "13th";
    case 14:
      return "14th";
    case 15:
      return "15th";
    case 16:
      return "16th";
    case 17:
      return "17th";
    case 18:
      return "18th";
    case 19:
      return "19th";
    case 20:
      return "20th";
    case 21:
      return "21st";
    case 22:
      return "22nd";
    case 23:
      return "23rd";
    case 24:
      return "24th";
    case 25:
      return "25th";
    case 26:
      return "26th";
    case 27:
      return "27th";
    case 28:
      return "28th";
    case 29:
      return "29th";
    case 30:
      return "30th";
    case 31:
      return "31st";
    default:
      return "Invalid Day";
  }
}
