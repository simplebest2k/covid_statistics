import 'dart:ui';

import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:flutter/material.dart';

class CovidStatViewer extends StatelessWidget {
  final String title;
  final double addedCount;
  final ArrowDirection upDown;
  final double totalCount;
  final bool dense;
  final Color titleColor;
  final Color subValueColor;
  final double spacing;

  CovidStatViewer({Key? key,
    required this.title,
    required this.addedCount,
    required this.upDown,
    required this.totalCount,
    this.titleColor = const Color(0xff4c4e5d),
    this.spacing = 10,
    this.subValueColor = Colors.black,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.black;

    switch(upDown) {
      case ArrowDirection.UP:
        color = Color(0xffcf5f51);
        break;

      case ArrowDirection.DOWN:
        color = Color(0xff3749be);
        break;
    }


    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: titleColor,
              fontSize: dense ? 14 : 18,
            ),
          ),
          SizedBox(height: spacing,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: ArrowClipPath(direction: upDown),
                child: Container(
                  width: dense ? 10 : 20,
                  height: dense ? 10 : 20,
                  color: color,
                ),
              ),
              SizedBox(width: 5,),
              Text(
                DataUtils.numberFormat(addedCount),
                style: TextStyle(
                    color: color,
                    fontSize: dense ? 20 : 34,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: spacing * 0.5,),
          Text(DataUtils.numberFormat(totalCount), style: TextStyle(
              color: subValueColor,
              fontSize: dense ? 12: 18,
              fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}
