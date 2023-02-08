class TimeAgo {
  static int SECOND_MILLIS = 1000;
  static int MINUTE_MILLIS = 60 * SECOND_MILLIS;
  static int HOUR_MILLIS = 60 * MINUTE_MILLIS;
  static int DAY_MILLIS = 24 * HOUR_MILLIS;
  static String? getTimeAgo(int? time) {
    var now = DateTime.now().millisecondsSinceEpoch;
    // int? time = complain.complainTime?.millisecondsSinceEpoch;
    if (time! > now || time <= 0) {
      return null;
    }

    var diff = now - time;
    if (diff < MINUTE_MILLIS) {
      return "just now";
    } else if (diff < 2 * MINUTE_MILLIS) {
      return "a minute ago";
    } else if (diff < 50 * MINUTE_MILLIS) {
      return "${(diff / MINUTE_MILLIS).toString()} minutes ago";
    } else if (diff < 90 * MINUTE_MILLIS) {
      return "an hour ago";
    } else if (diff < 24 * HOUR_MILLIS) {
      return "${(diff / HOUR_MILLIS).floor()} hours ago";
    } else if (diff < 48 * HOUR_MILLIS) {
      return "yesterday";
    } else {
      return "${(diff / DAY_MILLIS).floor()} days ago";
    }
  }
}
