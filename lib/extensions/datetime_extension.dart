import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExt on DateTime {
  String timeAgo() {
    return timeago.format(this);
  }
}
