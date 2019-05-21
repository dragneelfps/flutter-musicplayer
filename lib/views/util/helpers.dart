import 'package:intl/intl.dart';

final NumberFormat _nf = NumberFormat('00');

String formatTimestamp(int timeInMillis) {
  int totalSeconds = timeInMillis ~/ 1000;
  int minutes = totalSeconds ~/ 60;
  int remainderSeconds = totalSeconds - minutes * 60;
  return '${_nf.format(minutes)}:${_nf.format(remainderSeconds)}';
}
