
import 'package:flutter/foundation.dart';

printRed(String msg){
  if (kDebugMode) {
    print("\x1B[31m ${msg} \x1B[0m");
  }
}
printBlue(String msg){
  if (kDebugMode) {
    print("\x1B[34m ${msg} \x1B[0m");
  }
}
printWhite(String msg){
  if (kDebugMode) {
    print("\x1B[37m ${msg} \x1B[0m");
  }
}
printPurple(String msg){
  if (kDebugMode) {
    print("\x1B[35m ${msg} \x1B[0m");
  }
}