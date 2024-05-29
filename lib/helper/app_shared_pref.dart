
import 'dart:convert';

import 'package:website_nav/bean/user_bean.dart';
import 'package:website_nav/utils/sp_utils.dart';

class AppSharedPref{

  Future<UserBean?> getUserModel() async {
     dynamic localUser = await getData("local_user");
     if(localUser==null){
       return null;
     }
    return UserBean.fromJson(json.decode(localUser))  ;
  }

  Future clearUserModel() async {
    await removeData("local_user");
  }

}