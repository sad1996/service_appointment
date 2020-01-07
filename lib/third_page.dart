import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/bottom_list_item.dart';
import 'package:service_appointment/cart_page.dart';
import 'package:service_appointment/fourth_page.dart';
import 'package:service_appointment/model/service.dart';
import 'package:service_appointment/popular_services_page.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:vibrate/vibrate.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> with TickerProviderStateMixin {
  _ThirdPageState();

  AnimationController _animationController;
  AnimationController _appBarAnimationController;
  var duration = Duration(milliseconds: 500);
  bool isAdded = false;
  TabController tabController;
  PageController pageController;
  int tabIndex = 0, page = 2;
  double sliderValue = 10;
  List<String> miles = [
    '15k',
    '22.50k',
    '30k',
    '37.50k',
    '40k',
    '42.50k',
    '47.50k',
    '50k'
  ];

  List<ServiceModel> popularServices = [
    ServiceModel(
      id: 4,
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      id: 4,
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      id: 4,
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      id: 4,
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      id: 4,
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
  ];

  List<ServiceModel> allServices = [
    ServiceModel(
      id: 5,
      serviceTitle: "Inspect brakes / abs and advise",
      serviceCharge: 24.95,
    ),
    ServiceModel(
      id: 5,
      serviceTitle: "Perform brake fluid exchange",
      serviceCharge: 139.95,
    ),
    ServiceModel(
      id: 5,
      serviceTitle:
          "Replace front brake pads, advantage pads more on some vehicles",
      serviceCharge: 159.95,
    ),
  ];
  FocusNode focusNode = FocusNode();
  AppBar appBar;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: page, viewportFraction: 0.8);
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    tabController.addListener(() {
      setState(() {
        tabIndex = tabController.index;
      });
    });
    _appBarAnimationController = AnimationController(
        vsync: this, duration: duration, reverseDuration: duration);
    _appBarAnimationController.addListener(() {
      setState(() {});
    });
    _animationController = AnimationController(
        vsync: this, duration: duration, reverseDuration: duration);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    var media = MediaQuery.of(context);
    Size size = media.size;
    BookingProvider booking = Provider.of<BookingProvider>(context);

    appBar = AppBar(
      backgroundColor: theme.primaryColor,
      leading: IconButton(
          icon: Icon(FeatherIcons.chevronLeft),
          onPressed: () => onBackPressed(booking)),
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AnimatedCrossFade(
              duration: duration,
              crossFadeState: _appBarAnimationController.value > 0
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              sizeCurve: Curves.decelerate,
              firstChild: IgnorePointer(
                ignoring: _appBarAnimationController.value > 0,
                child: GestureDetector(
                  onTap: () {
                    _appBarAnimationController.forward();
                    _animationController.reverse();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Material(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: <Widget>[
                            Text(booking.selectedMake.name,
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0,
                                )),
                            Text(
                                booking.selectedYear.toString() +
                                    ' ' +
                                    booking.selectedVehicleModel.name,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xfffafafa),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.009999999776482582,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              secondChild: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('Vehicle Profile',
                    style: textTheme.subhead.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            FeatherIcons.user,
            size: 20,
          ),
          onPressed: () {},
        ),
        SizedBox(width: 7)
      ],
      bottom: focusNode.hasFocus
          ? PreferredSize(
              child: SizedBox(),
              preferredSize: Size.fromHeight(10),
            )
          : PreferredSize(
              child: Container(
                height: IntTween(
                        begin: tabIndex == 0 ? 140 : 70,
                        end: (size.height -
                                (media.padding.top + media.padding.bottom + 70))
                            .toInt())
                    .animate(_appBarAnimationController)
                    .value
                    .toDouble(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (_appBarAnimationController.value != 0.0)
                      Expanded(
                        child: Opacity(
                          opacity: _appBarAnimationController.value,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                height: 55,
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 48,
                                        width: 48,
                                        padding: EdgeInsets.only(left: 10),
                                        alignment: Alignment.centerRight,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Pigment.fromString(
                                                    '#2b2c36'))),
                                        child: Image.asset(
                                          booking.selectedVehicleModel.asset,
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              booking.selectedYear.toString() +
                                                  ' ' +
                                                  booking.selectedMake.name,
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Color(0xffffffff),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 2,
                                              )),
                                          Text(
                                            booking.selectedVehicleModel.name,
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing:
                                                  -0.01999999955296516,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Material(
                                      type: MaterialType.circle,
                                      elevation: 15,
                                      color: theme.secondaryHeaderColor,
                                      child: InkWell(
                                        onTap: () {
                                          _appBarAnimationController.reverse();
                                          _animationController.forward();
                                        },
                                        customBorder: CircleBorder(),
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  decoration: new BoxDecoration(
                                      color: Color(0xff4e515a),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                          top: 25,
                                          bottom: 25,
                                          right: 25,
                                          left: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text("Select your trim",
                                              style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    -0.01999999955296516,
                                              )),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                              "To ensure smooth operation, we recommend performing Maintenance Services based on your booking.selectedVehicle's current mileage, and view detailed Maintenance Services.",
                                              style: TextStyle(
                                                color: Color(0xffb9c1d3),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 0,
                                              )),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Divider(
                                              height: 1,
                                              color: Color(0xff1c1c28)),
                                          ListItem(type: "Model", value: "LT1"),
                                          Divider(
                                              height: 1,
                                              color: Color(0xff1c1c28)),
                                          ListItem(
                                              type: "Transmission",
                                              value: "6-speed manual"),
                                          Divider(
                                              height: 1,
                                              color: Color(0xff1c1c28)),
                                          ListItem(
                                              type: "Drive type", value: "RWD"),
                                          Divider(
                                              height: 1,
                                              color: Color(0xff1c1c28)),
                                          ListItem(
                                              type: "Engine",
                                              value: "6.2L V8 engine"),
                                          Divider(
                                              height: 1,
                                              color: Color(0xff1c1c28)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (_appBarAnimationController.value > 0.8)
                                GestureDetector(
                                  onTap: () {
                                    _appBarAnimationController.reverse();
                                    _animationController.forward();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 40,
                                        right: 20,
                                        top: 10,
                                        bottom: 30 + media.padding.bottom / 2),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Maintenance",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Color(0xff4e515a),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing:
                                                  -0.01999999955296516,
                                            )),
                                        SizedBox(width: 40),
                                        Text("Service",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Color(0xff4e515a),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing:
                                                  -0.01999999955296516,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                    else
                      Flexible(
                        child: AnimatedContainer(
                          height: tabIndex == 0 ? 140 : 70,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                height: 55,
                                child: Theme(
                                  data: ThemeData(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                  ),
                                  child: TabBar(
                                      controller: tabController,
                                      indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                              color: theme.accentColor,
                                              width: 3),
                                          insets: EdgeInsets.only(
                                              right: 60, left: 17)),
                                      indicatorColor: theme.accentColor,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Color(0xff4e515a),
                                      isScrollable: true,
                                      onTap: (tabIndex) {
                                        print(tabIndex);
                                        if (booking.canVibrate)
                                          Vibrate.feedback(FeedbackType.light);
                                        if (tabIndex == 0 && focusNode.hasFocus)
                                          focusNode.unfocus();
                                      },
                                      tabs: [
                                        'Maintenance',
                                        "Service",
                                      ]
                                          .map((tab) => Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 4),
                                                child: Text(tab,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      letterSpacing:
                                                          -0.01999999955296516,
                                                    )),
                                              ))
                                          .toList()),
                                ),
                              ),
                              if (tabIndex == 0) ...{
                                Container(
                                  padding: EdgeInsets.only(top: 45),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Material(
                                        child: Container(
                                          height: 42,
                                          width: 100,
                                          decoration: new BoxDecoration(
                                              color: theme.secondaryHeaderColor,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                    '${booking.selectedMiles.toStringAsFixed(1)}k',
                                                    style: TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      letterSpacing:
                                                          -0.009999999776482582,
                                                    )),
                                              ),
                                              Text('Miles',
                                                  style: TextStyle(
                                                    color: Color(0xffffffff),
                                                    fontSize: 8,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 0.5,
                                        height: 30,
                                        color: Color(0xff3a405a),
                                        margin: EdgeInsets.only(left: 20),
                                      ),
                                      Expanded(
                                        child: Center(),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 68,
                                  right: 0,
                                  left: 135,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      activeTrackColor: theme.accentColor,
                                      inactiveTrackColor:
                                          theme.secondaryHeaderColor,
                                      valueIndicatorColor: theme.accentColor,
                                      activeTickMarkColor: Colors.transparent,
                                      inactiveTickMarkColor: Colors.transparent,
                                      overlayColor:
                                          theme.accentColor.withOpacity(0.2),
                                      thumbColor: theme.accentColor,
                                      trackHeight: 7,
                                      showValueIndicator:
                                          ShowValueIndicator.always,
                                    ),
                                    child: Slider(
                                      value: booking.selectedMiles,
                                      min: 10,
                                      max: 50,
                                      divisions: 25,
                                      label:
                                          '     ${booking.selectedMiles.toStringAsFixed(1)}k     ',
                                      onChanged: booking.setMiles,
                                    ),
                                  ),
                                )
                              }
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
              preferredSize: tabIndex == 0
                  ? SizeTween(
                          begin: Size.fromHeight(140),
                          end: Size.fromHeight(size.height -
                              (media.padding.top + media.padding.bottom)))
                      .animate(_appBarAnimationController)
                      .value
                  : SizeTween(
                          begin: Size.fromHeight(70),
                          end: Size.fromHeight(size.height -
                              (media.padding.top + media.padding.bottom)))
                      .animate(_appBarAnimationController)
                      .value,
            ),
    );
    return WillPopScope(
      onWillPop: () => onBackPressed(booking),
      child: GestureDetector(
        onTap: focusNode.hasFocus
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : null,
        child: Scaffold(
          appBar: appBar,
          backgroundColor: theme.primaryColor,
          resizeToAvoidBottomPadding: true,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: IntTween(
                              begin: 0,
                              end: (size.height -
                                      (appBar.preferredSize.height +
                                          media.padding.top))
                                  .toInt())
                          .animate(_animationController)
                          .value
                          .toDouble(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Color(0xfff8f8f8),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: SafeArea(
                            child: TabBarView(
                              controller: tabController,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                'Maintenance',
                                'Service',
                              ].map((tab) {
                                if (tab == 'Maintenance')
                                  return SingleChildScrollView(
                                    padding: EdgeInsets.only(bottom: 170),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            height: 280,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: booking.primaryServices
                                                  .map((service) {
                                                bool isInCart = booking
                                                    .addedServiceList
                                                    .contains(service);
                                                return Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20),
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            elevation: 2,
                                                            shadowColor:
                                                                Colors.white24,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 15),
                                                                  child: Image
                                                                      .asset(
                                                                    service
                                                                        .serviceAsset,
                                                                    height: 65,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          service
                                                                              .serviceTitle,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff1f2136),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontStyle:
                                                                                FontStyle.normal,
                                                                            letterSpacing:
                                                                                0,
                                                                          )),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                          service
                                                                              .serviceCost,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff28293d),
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontStyle:
                                                                                FontStyle.normal,
                                                                            letterSpacing:
                                                                                -0.5,
                                                                          )),
                                                                      Text(
                                                                          "${service.items} Items",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xff007bfe),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FontStyle.normal,
                                                                            letterSpacing:
                                                                                0,
                                                                          )),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Material(
                                                            type: MaterialType
                                                                .circle,
                                                            color: Colors.white,
                                                            elevation: 8,
                                                            shadowColor: kIsWeb
                                                                ? Colors.black
                                                                    .withOpacity(
                                                                        0.01)
                                                                : Colors
                                                                    .black26,
                                                            child: InkWell(
                                                              onTap:
                                                                  () async {},
                                                              customBorder:
                                                                  CircleBorder(),
                                                              child: Container(
                                                                child:
                                                                    Container(
                                                                  child: Radio(
                                                                    value:
                                                                        service,
                                                                    groupValue:
                                                                        booking.radioValue(
                                                                            service),
                                                                    onChanged:
                                                                        (selected) {
                                                                      if (!isInCart) {
                                                                        if (booking
                                                                            .canVibrate)
                                                                          Vibrate.feedback(
                                                                              FeedbackType.light);
                                                                        booking.checkAndInsert(
                                                                            service);
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    "Popular Services" +
                                                        '   ' +
                                                        "${page + 1}/${popularServices.length}",
                                                    style: TextStyle(
                                                      color: Color(0xffb9c1d3),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      letterSpacing: 0,
                                                    )),
                                                FlatButton(
                                                  onPressed:
                                                      showPopularServicesView,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Text("View All",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff007bfe),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          letterSpacing:
                                                              -0.01166666640589634,
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              height: 112,
                                              child: PageView.builder(
                                                  controller: pageController,
                                                  itemCount:
                                                      popularServices.length,
                                                  onPageChanged: (page) async {
                                                    if (booking.canVibrate)
                                                      Vibrate.feedback(
                                                          FeedbackType.light);
                                                    setState(
                                                        () => this.page = page);
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    ServiceModel service =
                                                        popularServices[index];
                                                    bool isInCart = booking
                                                        .addedServiceList
                                                        .contains(service);
                                                    return Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child:
                                                            AnimatedContainer(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          height: page == index
                                                              ? 112
                                                              : 90,
                                                          decoration:
                                                              new BoxDecoration(),
                                                          child: Material(
                                                            color: Color(
                                                                0xffffffff),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            elevation: 2,
                                                            shadowColor:
                                                                Colors.white24,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                      width: 64,
                                                                      height:
                                                                          64,
                                                                      decoration: new BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              Color(0xffe5ebf3))),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                            popularServices[index]
                                                                                .serviceTitle,
                                                                            maxLines:
                                                                                2,
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            softWrap:
                                                                                true,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xff1f2136),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontStyle: FontStyle.normal,
                                                                              letterSpacing: 0,
                                                                            )),
                                                                        if (page ==
                                                                            index) ...{
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Flexible(
                                                                            child: Text(popularServices[index].serviceCost,
                                                                                style: TextStyle(
                                                                                  color: Color(0xff28293d),
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontStyle: FontStyle.normal,
                                                                                  letterSpacing: -0.5,
                                                                                )),
                                                                          )
                                                                        }
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Material(
                                                                    type: MaterialType
                                                                        .circle,
                                                                    color: Colors
                                                                        .white,
                                                                    elevation:
                                                                        8,
                                                                    shadowColor: kIsWeb
                                                                        ? Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.01)
                                                                        : Colors
                                                                            .black26,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        if (booking
                                                                            .canVibrate)
                                                                          Vibrate.feedback(
                                                                              FeedbackType.light);
                                                                        booking.addOrRemoveServiceToCart(
                                                                            service);
                                                                      },
                                                                      customBorder:
                                                                          CircleBorder(),
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Icon(
                                                                          isInCart
                                                                              ? Icons.remove
                                                                              : Icons.add,
                                                                          color: isInCart
                                                                              ? theme.errorColor
                                                                              : Pigment.fromString('#2b2c36'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ));
                                                  })),
                                        ]),
                                  );
                                else {
                                  if (_appBarAnimationController.value < 0.5)
                                    return Stack(children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 40),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              topRight: Radius.circular(50)),
                                          child: ListView.separated(
                                            padding: EdgeInsets.only(
                                                top: 40,
                                                bottom: 170,
                                                right: 10,
                                                left: 10),
                                            shrinkWrap: true,
                                            itemCount: allServices.length,
                                            itemBuilder: (context, index) {
                                              ServiceModel service =
                                                  allServices[index];
                                              bool isInCart = booking
                                                  .addedServiceList
                                                  .contains(service);

                                              return ListTile(
                                                title: Text(
                                                    service.serviceTitle,
                                                    style: TextStyle(
                                                      color: isInCart
                                                          ? Color(0xff66718a)
                                                          : Color(0xff2b2c36),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      letterSpacing: -0.5,
                                                    )),
                                                subtitle: Text(
                                                    service.serviceCost,
                                                    style: TextStyle(
                                                      color: isInCart
                                                          ? Color(0xff66718a)
                                                          : Color(0xff28293d),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      letterSpacing: -0.5,
                                                    )),
                                                trailing: Material(
                                                  type: MaterialType.circle,
                                                  color: Colors.white,
                                                  elevation: 8,
                                                  shadowColor: kIsWeb
                                                      ? Colors.black
                                                          .withOpacity(0.01)
                                                      : Colors.black26,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (booking.canVibrate)
                                                        Vibrate.feedback(
                                                            FeedbackType.light);
                                                      booking
                                                          .addOrRemoveServiceToCart(
                                                              service);
                                                    },
                                                    customBorder:
                                                        CircleBorder(),
                                                    child: Container(
                                                        width: 42,
                                                        height: 42,
                                                        child: Icon(
                                                          isInCart
                                                              ? Icons.remove
                                                              : Icons.add,
                                                          color: isInCart
                                                              ? theme.errorColor
                                                              : theme
                                                                  .primaryColor,
                                                        )),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                height: 0.5,
                                                color: Color(0xffd7dce4),
                                                indent: 14,
                                                endIndent: 14,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 20,
                                            bottom: 25),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade100,
                                                  spreadRadius: 3,
                                                  blurRadius: 3)
                                            ]),
                                        height: 45,
                                        child: TextField(
                                          focusNode: focusNode,
                                          onTap: () {
                                            if (booking.canVibrate)
                                              Vibrate.feedback(
                                                  FeedbackType.light);
                                          },
                                          style: TextStyle(
                                              color: Color(0xff2f3047)),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 11),
                                              hintText:
                                                  'Search service or describe issues',
                                              hintStyle: textTheme.body1
                                                  .copyWith(
                                                      color: Pigment.fromString(
                                                          '#b9c1d3')),
                                              suffixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                child: IconButton(
                                                  icon: Icon(
                                                    FeatherIcons.search,
                                                    size: 18,
                                                    color: Color(0xff2f3047),
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              )),
                                        ),
                                      ),
                                    ]);
                                  else
                                    return SizedBox();
                                }
                              }).toList(),
                            ),
                          )))),
              bottomBar(true)
            ],
          ),
        ),
      ),
    );
  }

  showPopularServicesView() async {
    var media = MediaQuery.of(context);
    Size size = media.size;
    double getTopPadding() =>
        (100 -
            ((((appBar.preferredSize.height + media.padding.top) -
                        appBar.bottom.preferredSize.height +
                        10) /
                    size.height) *
                100)) /
        100;
    BookingProvider booking =
        Provider.of<BookingProvider>(context, listen: false);
    if (booking.canVibrate) await Vibrate.feedback(FeedbackType.light);
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Material(
                child: Stack(
                  children: <Widget>[
                    DraggableScrollableSheet(
                        initialChildSize: 0.65,
                        minChildSize: 0.5,
                        maxChildSize: getTopPadding(),
                        builder: (context, controller) {
                          return PopularServicesPage(
                            scrollController: controller,
                            onClosed: () {
                              Navigator.pop(context);
                            },
                          );
                        }),
                    bottomBar(true)
                  ],
                ),
              ),
            ));
  }

  showCartView() async {
    var media = MediaQuery.of(context);
    Size size = media.size;
    double getTopPadding() =>
        (100 -
            ((((appBar.preferredSize.height + media.padding.top) -
                        appBar.bottom.preferredSize.height +
                        10) /
                    size.height) *
                100)) /
        100;
    BookingProvider booking =
        Provider.of<BookingProvider>(context, listen: false);
    if (booking.canVibrate) await Vibrate.feedback(FeedbackType.light);
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Material(
                child: Stack(
                  children: <Widget>[
                    DraggableScrollableSheet(
                        initialChildSize: 0.65,
                        minChildSize: 0.5,
                        maxChildSize: getTopPadding(),
                        builder: (context, controller) {
                          return CartPage(
                            scrollController: controller,
                            onClosed: () {
                              Navigator.of(context).pop();
                            },
                          );
                        }),
                    bottomBar(false)
                  ],
                ),
              ),
            ));
  }

  bottomBar(bool canTap) {
    final ThemeData theme = Theme.of(context);
    var media = MediaQuery.of(context);

    if (_appBarAnimationController.value == 0)
      return Align(
        alignment: Alignment.bottomCenter,
        child: Consumer<BookingProvider>(
          builder: (context, booking, _) => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 70 + media.padding.bottom / 2,
                padding: EdgeInsets.only(
                    right: 20, left: 10, bottom: media.padding.bottom / 2),
                decoration: new BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    if (canTap) ...{
                      BoxShadow(
                          color: Color(0x51000000),
                          offset: Offset(0, 8),
                          blurRadius: 16,
                          spreadRadius: 0),
                      BoxShadow(
                          color: Color(0x0a000000),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0)
                    }
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: canTap ? showCartView : null,
                        onVerticalDragUpdate: (drag) =>
                            canTap ? showCartView : null,
                        onHorizontalDragUpdate: (drag) =>
                            canTap ? showCartView : null,
                        child: Material(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  FeatherIcons.shoppingBag,
                                  color: theme.accentColor,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                    "${(booking.addedServiceList == null || int.parse(booking.cartCount) == 0) ? "No" : booking.cartCount} services added",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                    )),
                              ),
                              SizedBox(width: 20),
                              Text(booking.cartTotal,
                                  style: TextStyle(
                                    color: Color(0xfffafafa),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.01666666629413763,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      type: MaterialType.circle,
                      color: theme.accentColor,
                      elevation: 7,
                      child: InkWell(
                        onTap: () {
                          if (tabController.index == 0) {
                            setState(() {
                              tabController.animateTo(1,
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeIn);
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FourthPage()));
                          }
                        },
                        customBorder: CircleBorder(),
                        child: Container(
                            width: 42,
                            height: 42,
                            padding: EdgeInsets.all(10),
                            child: Image.asset('assets/icons/arrow_right.png')),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    else
      return SizedBox();
  }

  Future<bool> onBackPressed(BookingProvider booking) {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
      return Future.value(false);
    } else if (_appBarAnimationController.value != 0) {
      _appBarAnimationController.reverse();
      _animationController.forward();
      return Future.value(false);
    } else {
      if (tabController.index != 0) {
        setState(() {
          tabController.animateTo(0,
              duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
        });
        return Future.value(false);
      } else {
        booking.clearAddedServices();
        Navigator.pop(context);
      }
    }
  }
}
