import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_city_dashboard/models/city_card_model.dart';
import 'package:smart_city_dashboard/pages/dashboard/google_map.dart';
import 'package:smart_city_dashboard/widgets/helper.dart';
import '../../constants/constants.dart';
import '../../providers/page_providers.dart';
import 'weather_tab/left_panel.dart';
import 'weather_tab/right_panel.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CityCardModel city = ref.watch(cityDataProvider)!;
    int tab = ref.watch(tabProvider);
    return Padding(
      padding: EdgeInsets.only(top: Const.appBarHeight),
      child: SizedBox(
        height: screenSize(context).height - Const.appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox.shrink(),
            SizedBox(
              width: (screenSize(context).width - Const.tabBarWidth) / 2,
              height: screenSize(context).height - Const.appBarHeight,
              // color: Colors.blue,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: (() {
                  // if(tab == 0) {
                  return const WeatherTab();
                  // }
                  // switch(city.number) {
                  //   case 1:
                  //     sw
                  // }
                }()),
              ),
            ),
            Container(
                width: (screenSize(context).width - Const.tabBarWidth) / 2 - 40,
                // color: Colors.blue,
                child: Column(
                  children: [
                    GoogleMapPart(),
                    (() {
                      return Container();
                      // if(tab == 0) {
                      // return const WeatherTab();
                      // }
                      // switch(city.number) {
                      //   case 1:
                      //     sw
                      // }
                    }())
                  ],
                )),
            // const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
