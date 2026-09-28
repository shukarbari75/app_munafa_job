import 'package:intl/intl.dart';

 extension CustomDateFormate on DateTime{
   String toReadableDate (){
     final formatter = DateFormat('EEEE, MMM d');
     return formatter.format(this);
   }
 }

 String formatToApiDate(String uiDate) {
   try{
     final parsed = DateFormat(
       'MM--dd--yyyy',
     ).parseStrict(uiDate); // your UI format
     return DateFormat('yyyy-MM-dd').format(parsed);  // API format
   }catch (_){
    return uiDate;  // fallback if parsing fails
   }
 }

 bool isSameCalendarDay(DateTime a, DateTime b){
   return a.year == b.year && a.month == b.month && a.day == b.day;
 }

 String formatDate(DateTime date) {
   return '${date.day} ${_monthName(date.month)} ${date.year}';
 }

  String _monthName(int month) {
   const months = ['Jan','Feb','Mar','Apr','May','Jun',
                  'Jul','Aug','Sep','Oct','Nov','Dec'];
   return months [month - 1];
 }