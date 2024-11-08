// import 'package:intl/intl.dart';
//
// String dateFormatter(DateTime date){
//   final DateFormat formatter = DateFormat('dd - MM -yyyy');
//   return formatter.format(date);
//
// }
extension FormatDate on DateTime{
   String get formatDate => '$day / $month / $year';
   String get hourDate => '$hour';
}