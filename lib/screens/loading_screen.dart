import 'package:covidtrack/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return Column(
      children: <Widget>[
        AppHeader(
          headerText: 'COVID-19',
        ),
        SizedBox(
          height: 20,
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              offset += 5;
              time = 800 + offset;
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey[100],
                    child: ShimmerLayout(),
                    period: Duration(milliseconds: time),
                  ));
            },
          ),
        ),
      ],
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width / 1.5;
    double containerHeight = MediaQuery.of(context).size.height / 6;

    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: SizedBox(
        height: containerHeight,
        width: containerWidth,
      ),
    );
  }
}
