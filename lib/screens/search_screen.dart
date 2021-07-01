import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async {},
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
                        'fuck',
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
      itemCount: 10,
    ));
  }
}
