import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/modules/Crypto/Crypto.dart';
import 'package:menafn/modules/Energy/Energy.dart';
import 'package:menafn/modules/Entertainment/Entertainment.dart';
import 'package:menafn/modules/Health/Health.dart';
import 'package:menafn/modules/Home/Home.dart';
import 'package:menafn/modules/Politics/Politics.dart';
import 'package:menafn/modules/Sports/Sports.dart';
import 'package:menafn/modules/Telecom/Telecom.dart';
import 'package:menafn/shared/adsManager.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: DefaultTabController(
                initialIndex: 0,
                length: 8,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: const BoxConstraints.expand(height: 50),
                      child: TabBar(
                        indicatorColor: const Color(0xff88db52),
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          const Tab(
                            text: 'Home',
                          ),
                          const Tab(
                            text: 'Politics',
                          ),
                          const Tab(
                            text: 'Crypto',
                          ),
                          const Tab(
                            text: 'Entertainment',
                          ),
                          const Tab(
                            text: 'Energy',
                          ),
                          const Tab(
                            text: 'Health',
                          ),
                          const Tab(
                            text: 'Sports',
                          ),
                          const Tab(
                            text: 'Telecom',
                          ),
                        ],
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        indicatorWeight: 5,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(children: [
                          HomeScreen(),
                          PoliticsScreen(),
                          CryptoScreen(),
                          EntertainmentScreen(),
                          EnergyScreen(),
                          HealthScreen(),
                          SportsScreen(),
                          TelecomScreen(),
                        ]),
                      ),
                    ),
                    Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: google_ads(),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}