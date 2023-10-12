import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/home/home_state.dart';
import 'package:website_nav/utils/print_utils.dart';

class SlideMenuView extends StatefulWidget {
  Function(dynamic)? itemClick;

  SlideMenuView({super.key, this.itemClick});

  @override
  State<SlideMenuView> createState() => _SlideMenuViewState();
}

class _SlideMenuViewState extends State<SlideMenuView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;
  bool loading = false;
  bool loadingError = false;
  List<TypeBean> typeData = [];
  HomeBloc? homeBloc;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween(begin: 100.0, end: 200.0).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isExpanded = true;
        } else if (status == AnimationStatus.dismissed) {
          _isExpanded = false;
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      homeBloc?.add(HomeGetTypeDataEvent());
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        homeBloc = context.read<HomeBloc>();
        if (state is HomeInitialState) {
          // 加载中
          printBlue("恢復");
        } else if (state is HomeTypeLoadingState) {
          // 加载中
          loading = true;
          loadingError = false;
        } else if (state is HomeTypeDataSuccessState) {
          typeData.clear();
          typeData.addAll(state.typeData);
          loading = false;
          loadingError = false;
          context.read<HomeBloc>().add(HomeInitEvent());
        } else if (state is HomeTypeDataFailState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.msg}")));
          });
          loadingError = true;
          loading = false;
        }
        return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: _animation.value,
                height: double.maxFinite,
                color: Colors.blue,
                child: Column(
                  children: [
                    if (loadingError)
                      TextButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(HomeGetTypeDataEvent());
                        },
                        child: Text('重新加載'),
                      ),
                    Expanded(
                        child: Row(
                      children: [
                        (loading)
                            ? Expanded(
                                child: Row(
                                children: [Expanded(child: SizedBox()), CircularProgressIndicator(), Expanded(child: SizedBox())],
                              ))
                            : Expanded(
                                child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: typeData.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == typeData.length) {
                                    return addTypeMenuItem();
                                  } else {
                                    return menuItem(typeBean: typeData[index]);
                                  }
                                },
                              )),
                        GestureDetector(
                            onTap: () {
                              if (_isExpanded) {
                                _animationController.reverse();
                              } else {
                                _animationController.forward();
                              }
                            },
                            child: AnimatedCrossFade(
                                firstChild: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                ),
                                secondChild: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                ),
                                crossFadeState: !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                duration: Duration(milliseconds: 200))),
                      ],
                    )),
                  ],
                ),
              );
            });
      },
    );
  }

  Widget menuItem({required TypeBean typeBean}) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 20,
          ),
          if (_isExpanded) Text("${typeBean.name}"),
        ],
      ),
    );
  }

  Widget addTypeMenuItem() {
    return GestureDetector(onTap: (){


    },child: Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outlined,
            size: 20,
          ),
          if (_isExpanded) Text("添加类型"),
        ],
      ),
      ),
    );
  }
}
