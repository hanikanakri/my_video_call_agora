import 'package:easy_localization/easy_localization.dart';

class NumberUtils{
  static final oo = NumberFormat("#,##0");

  static String commaSeparatedInteger(int value){
    return oo.format(value);
  }

}