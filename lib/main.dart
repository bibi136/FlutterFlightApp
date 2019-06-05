import 'package:flighttickets/CustomShapeClipper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CustomAppbar.dart';

void main() => runApp(MaterialApp(
      title: "Flight List Mock Up",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: appTheme,
    ));

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          HomeScreenTopPart(),
          homeScreenBottomPart,
        ],
      ),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

const dropdownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const dropdownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);
List<String> locations = ['Boston (BOS)', 'New York City (NYC)'];

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 410.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFF47D15), Color(0xFFEF772C)])),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 16.0),
                        PopupMenuButton(
                          onSelected: (index) {
                            setState(() {
                              selectedLocationIndex = index;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(locations[selectedLocationIndex],
                                  style: dropdownLabelStyle),
                              Icon(Icons.arrow_drop_down, color: Colors.white)
                            ],
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                                PopupMenuItem(
                                  child: Text(locations[0],
                                      style: dropdownMenuItemStyle),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(locations[1],
                                      style: dropdownMenuItemStyle),
                                  value: 1,
                                )
                              ],
                        ),
                        Spacer(),
                        Icon(Icons.settings, color: Colors.white)
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Text(
                    "Where would\nyou want to go?",
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: TextField(
                        controller: TextEditingController(text: locations[1]),
                        style: dropdownMenuItemStyle,
                        cursorColor: appTheme.primaryColor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Material(
                              elevation: 5.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              child: Icon(
                                Icons.search,
                                color: Colors.black54,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 14.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: ChoiceChip(
                          icon: Icons.flight_takeoff,
                          text: "Flight",
                          isSelected: isFlightSelected,
                        ),
                        onTap: () {
                          setState(() {
                            isFlightSelected = true;
                          });
                        },
                      ),
                      SizedBox(width: 20.0),
                      InkWell(
                        child: ChoiceChip(
                          icon: Icons.hotel,
                          text: "Hotels",
                          isSelected: !isFlightSelected,
                        ),
                        onTap: () {
                          setState(() {
                            isFlightSelected = false;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  ChoiceChip({this.icon, this.text, this.isSelected});

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(20.0)))
          : null,
      child: Row(
        children: <Widget>[
          Icon(
            widget.icon,
            color: Colors.white,
          ),
          SizedBox(width: 4.0),
          Text(widget.text,
              style: TextStyle(color: Colors.white, fontSize: 14.0))
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

var homeScreenBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: <Widget>[
          Text(
            "Currently Watched Items",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "VIEW ALL (12)",
            style: viewAllStyle,
          ),
        ],
      ),
    ),
    Container(
      height: 300.0,
      child: ListView(scrollDirection: Axis.horizontal, children: cityCards),
    )
  ],
);

List<CityCard> cityCards = [
  CityCard(
      "assets/images/lasvegas.jpg", "Las Vegas", "Feb 2019", "45", 5299, 2399),
  CityCard("assets/images/athens.jpg", "Athens", "Jan 2018", "55", 7600, 1199),
  CityCard("assets/images/sydney.jpeg", "Sydney", "Sep 2019", "25", 3200, 1999),
];

final formatCurrency = NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount;
  final int oldPrice, newPrice;

  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount,
      this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 230.0,
                  width: 160.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.black87,
                          Colors.black.withOpacity(0.1)
                        ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            cityName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                          Text(
                            monthYear,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white70),
                        child: Text(
                          "$discount%",
                          style: TextStyle(color: Colors.black, fontSize: 13.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("${formatCurrency.format(newPrice)}",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
              SizedBox(width: 5.0),
              Text("(${formatCurrency.format(oldPrice)})",
                  style: TextStyle(color: Colors.black54, fontSize: 13.0)),
            ],
          )
        ],
      ),
    );
  }
}
