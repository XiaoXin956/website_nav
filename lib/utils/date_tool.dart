class DateTool {
  /// 年月日
  static String getToDay() {
    DateTime currentTime = DateTime.now();
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    var hour = (currentTime.hour.toString().length == 1) ? "0${currentTime.hour}" : currentTime.hour;
    var minute = (currentTime.minute.toString().length == 1) ? "0${currentTime.minute}" : currentTime.minute;
    var second = (currentTime.second.toString().length == 1) ? "0${currentTime.second}" : currentTime.second;
    return "${currentTime.year}-$month-$day $hour:$minute:$second";
  }

  /// 当前时间 年月日时分
  static String getTodayYearMothDayHourMinute() {
    DateTime currentTime = DateTime.now();
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    var hour = (currentTime.hour.toString().length == 1) ? "0${currentTime.hour}" : currentTime.hour;
    var minute = (currentTime.minute.toString().length == 1) ? "0${currentTime.minute}" : currentTime.minute;
    return "${currentTime.year}-$month-$day $hour:$minute";
  }

  /// 当天最后的时间
  static String todayEnd() {
    DateTime currentTime = DateTime.now();
    var month = (currentTime.month.toString().length == 1) ? "0${currentTime.month}" : currentTime.month;
    var day = (currentTime.day.toString().length == 1) ? "0${currentTime.day}" : currentTime.day;
    return "${currentTime.year}-${month}-${day} 23:59:59";
  }

  /// 时间戳
  static String timestamp() {
    DateTime currentTime = DateTime.now();
    return "${currentTime.microsecondsSinceEpoch}";
  }

  // 指定时间的多少天前，或者当前的多少天前
  static String ageDay(String currDateTime, int days) {
    DateTime dateTime = (currDateTime != "") ? DateTime.parse(currDateTime) : DateTime.now();
    DateTime dateResult = DateTime(dateTime.year, dateTime.month, dateTime.day - days, dateTime.hour, dateTime.minute, dateTime.second);
    var month = (dateResult.month.toString().length == 1) ? "0${dateResult.month}" : dateResult.month;
    var day = (dateResult.day.toString().length == 1) ? "0${dateResult.day}" : dateResult.day;
    return "${dateResult.year}-$month-$day";
  }

  // 生成时间日期数据
  static List<DateBean> getCompleteData({String startDate = ""}) {
    // 数据
    List<DateBean> dateBeans = [];
    // 第一天的日期
    DateTime firstTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: -90));
    // 开始日期
    DateTime startDateTime = (startDate != "") ? DateTime.parse(startDate) : DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
    // 结束日期
    DateTime endDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    while (startDateTime.millisecondsSinceEpoch < endDateTime.millisecondsSinceEpoch) {
      // 月份
      DateBean monthDateBean = DateBean();
      monthDateBean.monthStr = "${startDateTime.year}-${startDateTime.month}"; // 年月
      monthDateBean.itemType = DateBean.item_type_month;
      dateBeans.add(monthDateBean);
      addDatePlaceholder(dateBeans, 6, monthDateBean.monthStr.toString());
      // 处理单个月的日期
      DateTime currentLastTime = DateTime(
        startDateTime.year,
        startDateTime.month + 1,
      );
      currentLastTime = currentLastTime.subtract(Duration(days: 1));
      // 获取当月的最后一天
      while (startDateTime.millisecondsSinceEpoch <= currentLastTime.millisecondsSinceEpoch) {
        // 第一个日期
        if (startDateTime.millisecondsSinceEpoch == firstTime.millisecondsSinceEpoch) {
          // 周几
          switch (startDateTime.weekday) {
            case 1:
              //周日
              break;
            case 2:
              //周一
              addDatePlaceholder(dateBeans, 1, monthDateBean.monthStr.toString());
              break;
            case 3:
              //周二
              addDatePlaceholder(dateBeans, 2, monthDateBean.monthStr.toString());
              break;
            case 4:
              //周三
              addDatePlaceholder(dateBeans, 3, monthDateBean.monthStr.toString());
              break;
            case 5:
              //周四
              addDatePlaceholder(dateBeans, 4, monthDateBean.monthStr.toString());
              break;
            case 6:
              addDatePlaceholder(dateBeans, 5, monthDateBean.monthStr.toString());
              //周五
              break;
            case 7:
              addDatePlaceholder(dateBeans, 6, monthDateBean.monthStr.toString());
              //周六
              break;
          }
        } else {
          // 每个月的第一天
          if (startDateTime.day == 1) {
            switch (startDateTime.weekday) {
              case 1:
                //周日
                break;
              case 2:
                //周一
                addDatePlaceholder(dateBeans, 1, monthDateBean.monthStr.toString());
                break;
              case 3:
                //周二
                addDatePlaceholder(dateBeans, 2, monthDateBean.monthStr.toString());
                break;
              case 4:
                //周三
                addDatePlaceholder(dateBeans, 3, monthDateBean.monthStr.toString());
                break;
              case 5:
                //周四
                addDatePlaceholder(dateBeans, 4, monthDateBean.monthStr.toString());
                break;
              case 6:
                addDatePlaceholder(dateBeans, 5, monthDateBean.monthStr.toString());
                //周五
                break;
              case 7:
                addDatePlaceholder(dateBeans, 6, monthDateBean.monthStr.toString());
                //周六
                break;
            }
          }
        }
        // 每天
        DateBean dateBean = DateBean();
        dateBean.dateTime = startDateTime;
        dateBean.day = startDateTime.day.toString();
        dateBean.monthStr = monthDateBean.monthStr;
        dateBean.itemType = DateBean.item_type_day;
        dateBeans.add(dateBean);
        // 处理最后一天
        if (startDateTime.millisecondsSinceEpoch == currentLastTime.millisecondsSinceEpoch) {
          // 最后一天
          //看某个月第一天是周几
          var weekDay = startDateTime.weekday;
          switch (weekDay) {
            case 1:
              //周日
              addDatePlaceholder(dateBeans, 6, monthDateBean.monthStr.toString());
              break;
            case 2:
              //周一
              addDatePlaceholder(dateBeans, 5, monthDateBean.monthStr.toString());
              break;
            case 3:
              //周二
              addDatePlaceholder(dateBeans, 4, monthDateBean.monthStr.toString());
              break;
            case 4:
              //周三
              addDatePlaceholder(dateBeans, 3, monthDateBean.monthStr.toString());
              break;
            case 5:
              //周四
              addDatePlaceholder(dateBeans, 2, monthDateBean.monthStr.toString());
              break;
            case 6:
              addDatePlaceholder(dateBeans, 1, monthDateBean.monthStr.toString());
              //周5
              break;
          }
        }
        startDateTime = startDateTime.add(Duration(days: 1));
      }
    }
    dateBeans.forEach((element) {
      if (element.itemType == DateBean.item_type_month) {
        print("月份------------:${element.monthStr.toString()}");
      } else {
        print("日期:${element.dateTime?.month.toString()}-${element.dateTime?.day.toString()}");
      }
    });
    return dateBeans;
  }

  //添加空的日期占位
  static void addDatePlaceholder(List<DateBean> dateBeans, int count, String monthStr) {
    for (int i = 0; i < count; i++) {
      DateBean dateBean = DateBean();
      dateBean.monthStr = "占位 ${monthStr}";
      dateBeans.add(dateBean);
    }
  }
}

class DateBean {
  //item类型
  static int item_type_day = 1; //日期item
  static int item_type_month = 2; //月份item

  int itemType = 1; //默认是日期item
  //item状态
  static int ITEM_STATE_BEGIN_DATE = 1; //开始日期
  static int ITEM_STATE_END_DATE = 2; //结束日期
  static int ITEM_STATE_SELECTED = 3; //选中状态
  static int ITEM_STATE_NORMAL = 4; //正常状态
  static int ITEM_STATE_NO_CHECK = 5; //禁选状态
  int itemState = ITEM_STATE_NORMAL;

  DateTime? dateTime; //具体日期
  String? day; //一个月的某天
  String? monthStr; //月份
}
