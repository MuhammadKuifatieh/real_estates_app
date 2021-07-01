import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estates_app/models/region.dart';
import 'package:real_estates_app/providers/home_provier.dart';
import 'package:real_estates_app/screens/home_region_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Color> colors = [
    Colors.red.shade300,
    Colors.green.shade400,
    Colors.blue,
    Colors.orange.shade300
  ];
  @override
  void didChangeDependencies() {
    Provider.of<HomeProvider>(context, listen: false).fetchRegion();
    // regions = Provider.of<HomeProvider>(context, listen: false).region;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<HomeProvider>(
      builder: (_, homeProvider, __) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(HomeRegionScreen.roueName,
                      arguments: {'regionId': homeProvider.region[index].id});
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            colors[index % 4].withOpacity(0.8),
                            colors[index % 4]
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.2, 0.4]),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            homeProvider.region[index].name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ])),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return StaggeredTile.count(
                1,
                (index % 4 == 0)
                    ? .8
                    : (index % 3 == 0)
                        ? 1
                        : (index % 2 == 0)
                            ? 0.6
                            : .5);
          },
          itemCount: homeProvider.region.length,
        );
      },
    ));
  }
}
