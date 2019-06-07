import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CustomShapeClipper.dart';
import 'main.dart';

final Color discountBackgroundColor = Color(0xFFFFE08D);
final Color flightBorderColor = Color(0xFFE6E6E6);
final Color chipBackgroundColor = Colors.grey.withOpacity(0.1);

class FlightListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Search Result"),
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[FlightListTopPart(), FlightListBottomPart()],
        ),
      ),
    );
  }
}

class FlightListTopPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFF47D15), Color(0xFFEF772C)])),
            height: 160.0,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              elevation: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Boston (BOS)',
                              style: TextStyle(fontSize: 16.0)),
                          Divider(color: Colors.grey, height: 20.0),
                          Text(
                            'New York City (JFK)',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.import_export,
                        color: Colors.black87,
                        size: 28.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FlightListBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 46.0),
            child: Text(
              'Best Deals for Next 6 Months',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: listFlightCard,
          )
        ],
      ),
    );
  }
}

List<FlightCard> listFlightCard = [
  FlightCard(),
  FlightCard(),
  FlightCard(),
  FlightCard(),
  FlightCard()
];

class FlightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(color: flightBorderColor)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          NumberFormat.simpleCurrency().format(4159),
                          style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '(${NumberFormat.simpleCurrency().format(5159)})',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8.0,
                    children: <Widget>[
                      CategoryChip(Icons.calendar_today, 'Jun 2019'),
                      CategoryChip(Icons.flight, 'Cathay Pacific'),
                      CategoryChip(Icons.star, '4.6')
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 10,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                    color: discountBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Text(
                  '56%',
                  style: TextStyle(
                      color: appTheme.primaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final IconData icon;
  final String text;

  CategoryChip(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
          color: chipBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
            size: 16.0,
          ),
          SizedBox(width: 8.0),
          Text(text, style: TextStyle(fontSize: 14.0))
        ],
      ),
    );
  }
}
