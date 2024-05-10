
import 'dart:developer';

import 'package:flutter/foundation.dart';

appLog(dynamic message){
  if(kDebugMode){

    log("Message from App : $message");

  }
}