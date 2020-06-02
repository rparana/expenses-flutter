import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percent;

  ChartBar({this.day, this.value, this.percent});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('${value.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(day),
            ),
          ),
        ],
      );
    });
  }
}
