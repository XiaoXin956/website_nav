import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/home/home_state.dart';

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
  List<TypeBean> typeData = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween(begin: 80.0, end: 200.0).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isExpanded = true;
        } else if (status == AnimationStatus.dismissed) {
          _isExpanded = false;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: HomeBloc()..add(HomeGetTypeDataEvent()),
      builder: (BuildContext context, state) {
        if (state is HomeTypeLoadingState) {
          // 加载中
          loading = true;
        }else if(state is HomeTypeDataSuccessState){
          typeData.clear();
          typeData.addAll(state.typeData);
          loading = false;
        }else if(state is HomeTypeDataFailState){
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.msg}")));
          });
          loading = false;
        }
        return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: _animation.value,
                height: double.maxFinite,
                color: Colors.blue,
                child: Row(
                  children: [
                    (loading)
                        ? Expanded(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: typeData.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == typeData.length) {
                                return addTypeMenuItem();
                              }else{
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
    return Container(
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
    );
  }
}
