

import 'package:travel_map_f/generic_widgets/card_flipper.dart';
import 'package:flutter/material.dart';
import 'package:travel_map_f/models/card_data.dart';

class DestinationPage extends StatefulWidget {
  final List<CardViewModel> countrydata;

  DestinationPage({
    this.countrydata
  });


  @override
  _DestinationPageState createState() => new _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This container is to push content below notification bar)
          Container(
            width: double.infinity,
            height: 20.0,
          ),
          Expanded(
            child: CardFlipper(
              cards: widget.countrydata,
              onScroll: (double scrollPercent) {
                setState(() {
                  this.scrollPercent = scrollPercent;
                });
              },
            ),
          ),
          BottomBar(
              scrollPercent: scrollPercent,
              cardCount: widget.countrydata.length
          )

        ],
      ), // Column
    );
  }
}