import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:website_nav/pages/feedback/feedback_page.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_cubit.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_view.dart';
import 'package:website_nav/pages/label/label_cubit.dart';
import 'package:website_nav/pages/login/login_bloc.dart';
import 'package:website_nav/utils/print_utils.dart';
import 'package:website_nav/utils/uri_utils.dart';

import 'generated/l10n.dart';
import 'pages/home/view/home_page.dart';

final appGlobalKey = GlobalKey();

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, build) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LabelCubit()),
              BlocProvider(create: (context) => LabelCubit()),
              BlocProvider(create: (context) => LoginBloc()),
              BlocProvider(create: (context) => KnowledgeCubit()..reqSearchAllKnowledgeData(data: {"type": "search"})),
            ],
            child: MaterialApp(
              key: appGlobalKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: HomePage(),
              localizationsDelegates: const [
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                S.delegate,
              ],
              supportedLocales: const [
                Locale("zh"),
                Locale("en"),
              ],
              onGenerateRoute: (settings) {
                String urlName = settings.name.toString();
                if (urlName == '/') {
                  //首页
                  return MaterialPageRoute(builder: (BuildContext context) {
                    return HomePage();
                  });
                } else if (urlName == '/add_data') {
                  return MaterialPageRoute(builder: (BuildContext context) {
                    return KnowledgePage();
                  });
                }else if(urlName.startsWith("/feedback")){
                  // 解析url
                  // final params = settings.name!.substring(settings.name!.lastIndexOf("?")+1,settings.name!.length);
                  // Map<String,dynamic> urlAnalyzeData = urlAnalyze(params);
                  return MaterialPageRoute(builder: (BuildContext context) {
                    return FeedbackPage();
                  });
                }
                return null;
              },
            ));
      },
    );
  }
}
