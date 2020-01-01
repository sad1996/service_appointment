import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/bottom_list_item.dart';
import 'package:service_appointment/calendar/calendar.dart';
import 'package:service_appointment/cart_page.dart';
import 'package:service_appointment/ensure_visibility.dart';
import 'package:service_appointment/model/model_default.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:vibrate/vibrate.dart';
import 'package:service_appointment/fifth_page.dart';

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _appBarAnimationController;
  AnimationController advisorListAnimationController;
  var duration = Duration(milliseconds: 500);
  bool showCartView = false;
  int slotPage = 0;
  int mainPage = 0;
  int tabIndex = 0;
  bool isTextEnabled = false;
  bool isEmailEnabled = false;
  bool isCalendarExpanded = true;
  List<String> slotList = [
    '8:00 am',
    '8:15 am',
    '8:30 am',
    '8:45 am',
    '9:00 am',
    '9:15 am',
    '9:30 am',
    '9:45 am',
    '10:00 am',
    '10:15 am',
    '10:30 am',
    '10:45 am',
    '11:00 am',
    '11:15 am',
    '11:30 am',
    '11:45 am',
    '12:00 pm',
    '12:15 pm',
    '12:30 pm',
    '12:45 pm',
    '01:00 pm',
    '01:15 pm',
    '01:30 pm',
    '01:45 pm',
    '02:00 pm',
  ];
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  List<List<String>> pages = List();
  TabController tabController;
  PageController timeSlotPageController;
  List<ModelDefault> advisors = [
    ModelDefault('Any Service Advisor', 'assets/images/avatars/avtr_any.png'),
    ModelDefault('Harold Shelton', 'assets/images/avatars/avtr_1.png'),
    ModelDefault('Warren Powers', 'assets/images/avatars/avtr_2.png'),
    ModelDefault('Alfred Estarada', 'assets/images/avatars/avtr_3.png'),
  ];

  List<TransportType> transportTypes = [
    TransportType(
        'Waiter',
        'I will wait at dealership',
        'assets/images/transport_type/waiter.png',
        'assets/images/transport_type/waiter_dark.png'),
    TransportType(
        'Self',
        'I will find my way',
        'assets/images/transport_type/self.png',
        'assets/images/transport_type/self_dark.png'),
    TransportType(
        'Loaner',
        'I need a loaner booking.selectedVehicle',
        'assets/images/transport_type/loaner.png',
        'assets/images/transport_type/loaner_dark.png'),
    TransportType(
        'Valet',
        '\$50 for the service within 50 miles',
        'assets/images/transport_type/valet.png',
        'assets/images/transport_type/valet_dark.png'),
    TransportType(
        'Shuttle Ride',
        'Upto 10 miles, drop off and pickup',
        'assets/images/transport_type/shutter.png',
        'assets/images/transport_type/shutter_dark.png'),
  ];

  @override
  void initState() {
    super.initState();
    pages.add(slotList.sublist(0, 12));
    pages.add(slotList.sublist(12, 24));
    pages.add(slotList.sublist(24, 25));
    advisorListAnimationController =
        AnimationController(duration: duration, vsync: this);
    timeSlotPageController = PageController(initialPage: slotPage);
    tabController =
        TabController(initialIndex: tabIndex, vsync: this, length: 2);
    tabController.addListener(() {
      setState(() {
        tabIndex = tabController.index;
      });
      if (tabIndex == 0) removeFocus();
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
  void dispose() {
    advisorListAnimationController.dispose();
    _appBarAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool get hasFocus => (firstNameFocusNode.hasFocus ||
      lastNameFocusNode.hasFocus ||
      emailFocusNode.hasFocus ||
      phoneFocusNode.hasFocus);

  removeFocus() {
    setState(() {
      if (firstNameFocusNode.hasFocus) firstNameFocusNode.unfocus();
      if (lastNameFocusNode.hasFocus) lastNameFocusNode.unfocus();
      if (emailFocusNode.hasFocus) emailFocusNode.unfocus();
      if (phoneFocusNode.hasFocus) phoneFocusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    var media = MediaQuery.of(context);
    Size size = media.size;
    BookingProvider booking = Provider.of<BookingProvider>(context);

    AppBar appBar = AppBar(
      backgroundColor: theme.primaryColor,
      leading: IconButton(
          icon: Icon(FeatherIcons.chevronLeft),
          onPressed: () => onBackPressed(booking)),
      title: showCartView
          ? Text("Service Cart",
              style: TextStyle(
                color: Color(0xfffafafa),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                letterSpacing: -0.009999999776482582,
              ))
          : AnimatedCrossFade(
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
      bottom: hasFocus || showCartView
          ? PreferredSize(
              child: SizedBox(),
              preferredSize: Size.fromHeight(10),
            )
          : PreferredSize(
              child: Container(
                height: IntTween(
                        begin: 75,
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
                                  child: Material(
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
                                            ListItem(
                                                type: "Model", value: "LT1"),
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
                                                type: "Drive type",
                                                value: "RWD"),
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
                                        Text("Appointment",
                                            style: TextStyle(
                                              color: Color(0xff4e515a),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing:
                                                  -0.01999999955296516,
                                            )),
                                        SizedBox(width: 40),
                                        Text("My Info",
                                            style: TextStyle(
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
                    else if (!hasFocus)
                      Flexible(
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          alignment: Alignment.centerLeft,
                          height: 55,
                          child: Theme(
                            data: ThemeData(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                            ),
                            child: IgnorePointer(
                              ignoring: (booking.selectedAdvisor == null ||
                                  booking.selectedTransportType == null ||
                                  booking.selectedDate == null ||
                                  booking.selectedTimeSlot == null),
                              child: TabBar(
                                controller: tabController,
                                indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        color: theme.accentColor, width: 3),
                                    insets:
                                        EdgeInsets.only(right: 60, left: 17)),
                                indicatorColor: theme.accentColor,
                                labelColor: Colors.white,
                                unselectedLabelColor: Color(0xff4e515a),
                                isScrollable: true,
                                tabs: [
                                  'Appointment',
                                  "My Info",
                                ]
                                    .map((tab) => Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(tab,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    -0.01999999955296516,
                                              )),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              preferredSize: SizeTween(
                      begin: Size.fromHeight(80),
                      end: Size.fromHeight(size.height -
                          (media.padding.top + media.padding.bottom)))
                  .animate(_appBarAnimationController)
                  .value,
            ),
    );
    return WillPopScope(
      onWillPop: () => onBackPressed(booking),
      child: GestureDetector(
        onTap: hasFocus
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : null,
        child: Scaffold(
          appBar: PreferredSize(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                appBar,
                if (showCartView)
                  InkWell(
                      onTap: () {
                        setState(() {
                          showCartView = false;
                        });
                      },
                      child: Container(
                        color: Colors.black45,
                        child: Center(),
                      ))
              ],
            ),
            preferredSize: appBar.preferredSize,
          ),
          backgroundColor: theme.primaryColor,
          resizeToAvoidBottomPadding: true,
          body: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.expand,
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
                    child: Column(
                      children: <Widget>[
                        if (_appBarAnimationController.value == 0)
                          AnimatedCrossFade(
                            crossFadeState: (booking.selectedAdvisor == null &&
                                        booking.selectedTransportType ==
                                            null) ||
                                    hasFocus
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: duration,
                            firstCurve: Curves.easeOut,
                            secondCurve: Curves.easeIn,
                            firstChild: Container(
                              alignment: Alignment.centerLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  children: <Widget>[
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 600),
                                      height: booking.selectedAdvisor != null
                                          ? 50
                                          : 0,
                                      margin: EdgeInsets.only(
                                          bottom: 25, right: 15),
                                      child: Material(
                                        color: theme.secondaryHeaderColor,
                                        borderRadius: BorderRadius.circular(25),
                                        child: InkWell(
                                          onTap: () {
                                            if (booking.canVibrate)
                                              Vibrate.feedback(
                                                  FeedbackType.light);
                                            booking.setAdvisor(null);
                                            setState(() {
                                              if (mainPage != 0) {
                                                mainPage = 0;
                                                if (tabIndex != 0)
                                                  tabController.animateTo(0,
                                                      duration: duration,
                                                      curve: Curves.easeIn);
                                              }
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: booking.selectedAdvisor != null
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(booking
                                                          .selectedAdvisor
                                                          .asset),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 3),
                                                        child: Text(
                                                            booking
                                                                .selectedAdvisor
                                                                .name,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffffffff),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              letterSpacing: 0,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height:
                                          booking.selectedTransportType != null
                                              ? 50
                                              : 0,
                                      margin: EdgeInsets.only(bottom: 25),
                                      child: Material(
                                        color: theme.secondaryHeaderColor,
                                        borderRadius: BorderRadius.circular(25),
                                        child: InkWell(
                                          onTap: () {
                                            if (booking.canVibrate)
                                              Vibrate.feedback(
                                                  FeedbackType.light);
                                            booking.setTransportType(null);
                                            setState(() {
                                              if (mainPage != 0) mainPage = 0;
                                              if (tabIndex != 0)
                                                tabController.animateTo(0,
                                                    duration: duration,
                                                    curve: Curves.easeIn);
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: booking
                                                      .selectedTransportType !=
                                                  null
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2),
                                                        child: Image.asset(booking
                                                            .selectedTransportType
                                                            .darkAsset),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 3),
                                                        child: Text(
                                                            booking
                                                                .selectedTransportType
                                                                .title,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffffffff),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              letterSpacing: 0,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            secondChild: SizedBox(),
                          ),
                        Expanded(
                          child: Container(
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
                                        'Appointment',
                                        'My Info',
                                      ].map((tab) {
                                        if (tab == 'Appointment') {
                                          if (_animationController.value > 0.8)
                                            return AnimatedCrossFade(
                                              duration: duration,
                                              firstChild: Container(
                                                color: Color(0xfff8f8f8),
                                                child: SingleChildScrollView(
                                                  padding: EdgeInsets.only(
                                                      bottom: ((!hasFocus &&
                                                                  tabIndex != 0)
                                                              ? 140
                                                              : 70) +
                                                          media.padding.bottom /
                                                              2),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: <Widget>[
                                                        AnimatedContainer(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          height: booking
                                                                      .selectedAdvisor !=
                                                                  null
                                                              ? 0
                                                              : (size.height /
                                                                      4) +
                                                                  90,
                                                          child: Stack(
                                                            children: <Widget>[
                                                              SingleChildScrollView(
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(
                                                                                  20),
                                                                          bottomRight:
                                                                              Radius.circular(20))),
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                            size.height /
                                                                                4,
                                                                        alignment:
                                                                            Alignment
                                                                                .bottomCenter,
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/appointment.png',
                                                                          height:
                                                                              size.height /
                                                                                  6,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal:
                                                                                  10,
                                                                              vertical:
                                                                                  35),
                                                                          child: Text(
                                                                              "Appointment time slots will be based on the selected service advisor and transportation choices.",
                                                                              textAlign:
                                                                                  TextAlign.center,
                                                                              style: TextStyle(
                                                                                color: Color(0xffb9c1d3),
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontStyle: FontStyle.italic,
                                                                                letterSpacing: 0,
                                                                              )))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Image.asset(
                                                                'assets/images/group0.png',
                                                                height:
                                                                    size.height /
                                                                        6,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            25),
                                                                child: Text(
                                                                    "Service Advisor",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xffb9c1d3),
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      letterSpacing:
                                                                          0,
                                                                    )),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              if (_animationController
                                                                      .value ==
                                                                  1)
                                                                Container(
                                                                  height: 140,
                                                                  child: ListView
                                                                      .separated(
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal:
                                                                                  25,
                                                                              vertical:
                                                                                  10),
                                                                          itemCount: advisors
                                                                              .length,
                                                                          itemBuilder: (context,
                                                                              index) {
                                                                            ModelDefault
                                                                                model =
                                                                                advisors[index];
                                                                            var count =
                                                                                advisors.length;
                                                                            var animation =
                                                                                Tween(begin: 0.0, end: 1.0).animate(
                                                                              CurvedAnimation(
                                                                                parent: advisorListAnimationController,
                                                                                curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                                                                              ),
                                                                            );
                                                                            advisorListAnimationController.forward();
                                                                            return AnimatedBuilder(
                                                                                animation: advisorListAnimationController,
                                                                                builder: (BuildContext context, Widget child) {
                                                                                  return FadeTransition(
                                                                                      opacity: animation,
                                                                                      child: new Transform(
                                                                                          transform: new Matrix4.translationValues(50 * (1.0 - animation.value), 0.0, 0.0),
                                                                                          child: Container(
                                                                                            alignment: Alignment.center,
                                                                                            width: 85,
                                                                                            height: 140,
                                                                                            child: Material(
                                                                                              color: Colors.white,
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                              elevation: 2,
                                                                                              shadowColor: Colors.white24,
                                                                                              child: InkWell(
                                                                                                onTap: () async {
                                                                                                  if (booking.canVibrate) Vibrate.feedback(FeedbackType.light);
                                                                                                  booking.setAdvisor(model);
                                                                                                  setState(() {
                                                                                                    if (booking.selectedTransportType != null) if (mainPage == 0) {
                                                                                                      mainPage = 1;
                                                                                                    }
                                                                                                  });
                                                                                                },
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                child: Material(
                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: <Widget>[
                                                                                                      Image.asset(
                                                                                                        model.asset,
                                                                                                        width: 65,
                                                                                                        height: 50,
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: EdgeInsets.all(8),
                                                                                                        child: Text(model.name,
                                                                                                            maxLines: 2,
                                                                                                            overflow: TextOverflow.ellipsis,
                                                                                                            softWrap: true,
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: TextStyle(
                                                                                                              color: Color(0xff3a405a),
                                                                                                              fontSize: 12,
                                                                                                              fontWeight: FontWeight.w400,
                                                                                                              fontStyle: FontStyle.normal,
                                                                                                              letterSpacing: 0,
                                                                                                            )),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          )));
                                                                                });
                                                                          },
                                                                          separatorBuilder: (context, index) =>
                                                                              SizedBox(width: 13)),
                                                                ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (booking
                                                                .selectedAdvisor !=
                                                            null)
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              25),
                                                                  child: Text(
                                                                      "Transport Type",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xffb9c1d3),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                        letterSpacing:
                                                                            0,
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  height: 80,
                                                                  child: ListView
                                                                      .separated(
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  10,
                                                                              horizontal:
                                                                                  25),
                                                                          itemCount: transportTypes
                                                                              .length,
                                                                          itemBuilder: (context,
                                                                              index) {
                                                                            var transportType =
                                                                                transportTypes[index];

                                                                            return Material(
                                                                              borderRadius: BorderRadius.circular(32),
                                                                              elevation: 2,
                                                                              shadowColor: Colors.white24,
                                                                              color: Colors.white,
                                                                              child: InkWell(
                                                                                onTap: () async {
                                                                                  if (booking.canVibrate)Vibrate.feedback(FeedbackType.light);

                                                                                  booking.setTransportType(transportType);
                                                                                  setState(() {
                                                                                    if (booking.selectedAdvisor != null) if (mainPage == 0) {
                                                                                      mainPage = 1;
                                                                                    }
                                                                                  });
                                                                                },
                                                                                borderRadius: BorderRadius.circular(32),
                                                                                child: Container(
                                                                                  height: 80,
                                                                                  padding: EdgeInsets.only(right: 30),
                                                                                  child: Row(
                                                                                    children: <Widget>[
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                                                                        child: Image.asset(transportType.asset),
                                                                                      ),
                                                                                      Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          Text(transportType.title,
                                                                                              style: TextStyle(
                                                                                                color: Color(0xff1f2136),
                                                                                                fontSize: 14,
                                                                                                fontWeight: FontWeight.w700,
                                                                                                fontStyle: FontStyle.normal,
                                                                                                letterSpacing: 0,
                                                                                              )),
                                                                                          Text(transportType.subTitle,
                                                                                              style: TextStyle(
                                                                                                color: Color(0xff66718a),
                                                                                                fontSize: 10,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FontStyle.normal,
                                                                                                letterSpacing: 0,
                                                                                              ))
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          separatorBuilder: (context, index) =>
                                                                              SizedBox(width: 20)),
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                      ]),
                                                ),
                                              ),
                                              secondChild: Container(
                                                color: isCalendarExpanded
                                                    ? Color(0xfff8f8f8)
                                                    : Colors.white,
                                                child: SingleChildScrollView(
                                                  padding: EdgeInsets.only(
                                                      bottom: 70 +
                                                          media.padding.bottom /
                                                              2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      ConstrainedBox(
                                                        constraints:
                                                            new BoxConstraints(
                                                                maxHeight: double
                                                                    .infinity),
                                                        child: Calendar(
                                                          isExpandable: booking
                                                                  .selectedDate ==
                                                              null,
                                                          initialCalendarDateOverride:
                                                              DateTime.now(),
                                                          onExpanded:
                                                              (isExpanded) {
                                                            setState(() {
                                                              isCalendarExpanded =
                                                                  isExpanded;
                                                            });
                                                          },
                                                          onDateSelected:
                                                              (date) async {
                                                                if (booking.canVibrate)
                                                              Vibrate.feedback(
                                                                  FeedbackType
                                                                      .light);
                                                            booking
                                                                .setDate(date);
                                                          },
                                                        ),
                                                      ),
                                                      if (booking
                                                              .selectedDate ==
                                                          null)
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 40,
                                                                  horizontal:
                                                                      30),
                                                          child: Text(
                                                              "Choose a date to see the available time slot for your Service appointment",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffb9c1d3),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                letterSpacing:
                                                                    0,
                                                              )),
                                                        )
                                                      else
                                                        Container(
                                                          color:
                                                              Color(0xfff8f8f8),
                                                          height: 400,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10,
                                                                        left:
                                                                            25),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child: Text(
                                                                          "Appointment Time",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xffb9c1d3),
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontStyle:
                                                                                FontStyle.italic,
                                                                            letterSpacing:
                                                                                0,
                                                                          )),
                                                                    ),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            FeatherIcons.chevronLeft,
                                                                            color: slotPage > 0 && slotPage < 3
                                                                                ? Pigment.fromString('#2b2c36')
                                                                                : theme.disabledColor,
                                                                          ),
                                                                          onPressed: slotPage == 0
                                                                              ? null
                                                                              : () async {
                                                                            if (booking.canVibrate) Vibrate.feedback(FeedbackType.light);
                                                                                  timeSlotPageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                                                                                },
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            FeatherIcons.chevronRight,
                                                                            color: slotPage < 2
                                                                                ? Pigment.fromString('#2b2c36')
                                                                                : theme.disabledColor,
                                                                          ),
                                                                          onPressed: slotPage > 1
                                                                              ? null
                                                                              : () async {
                                                                            if (booking.canVibrate) Vibrate.feedback(FeedbackType.light);
                                                                                  timeSlotPageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                                                                },
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: PageView
                                                                      .builder(
                                                                          controller:
                                                                              timeSlotPageController,
                                                                          onPageChanged: (page) =>
                                                                              setState(
                                                                                  () {
                                                                                this.slotPage = page;
                                                                              }),
                                                                          itemCount: pages
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            List<String>
                                                                                page =
                                                                                pages[index];
                                                                            return Container(
                                                                              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                                                                              child: StaggeredGridView.countBuilder(
                                                                                shrinkWrap: true,
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                crossAxisCount: 3,
                                                                                mainAxisSpacing: 5,
                                                                                crossAxisSpacing: 15,
                                                                                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                                                                                itemCount: page.length,
                                                                                itemBuilder: (context, index) {
                                                                                  String slot = page[index];
                                                                                  bool isSelected = booking.selectedTimeSlot != null && booking.selectedTimeSlot == slot;
                                                                                  return Container(
                                                                                    margin: EdgeInsets.symmetric(vertical: 10),
                                                                                    child: Material(
                                                                                      child: InkWell(
                                                                                        onTap: () async {
                                                                                          if (booking.canVibrate)Vibrate.feedback(FeedbackType.light);
                                                                                          booking.setTimeSlot(slot);
                                                                                          tabController.animateTo(1, duration: duration, curve: Curves.easeOut);
                                                                                        },
                                                                                        borderRadius: BorderRadius.circular(100),
                                                                                        child: Container(
                                                                                          height: 50,
                                                                                          decoration: new BoxDecoration(border: Border.all(color: !isSelected ? Color(0xff3a405a) : Colors.transparent, width: 1), color: isSelected ? Color(0xff3a405a) : Colors.transparent, borderRadius: BorderRadius.circular(30)),
                                                                                          alignment: Alignment.center,
                                                                                          child: Material(
                                                                                            child: Text(slot,
                                                                                                style: TextStyle(
                                                                                                  color: isSelected ? Colors.white : Color(0xff3a405a),
                                                                                                  fontSize: 14,
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                  fontStyle: FontStyle.normal,
                                                                                                )),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            );
                                                                          }))
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              firstCurve: Curves.easeIn,
                                              secondCurve: Curves.easeOut,
                                              crossFadeState: mainPage == 0
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                            );
                                          else
                                            return SizedBox();
                                        } else {
                                          if (_appBarAnimationController.value <
                                              0.5) {
                                            return SingleChildScrollView(
                                              padding: EdgeInsets.only(
                                                  bottom: ((!hasFocus &&
                                                              tabIndex != 0)
                                                          ? 140
                                                          : 70) +
                                                      media.padding.bottom / 2),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25),
                                                      child: Text(
                                                          "My Information",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffb9c1d3),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            letterSpacing: 0,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25,
                                                              vertical: 15),
                                                      child: Column(
                                                        children: <Widget>[
                                                          EnsureVisibleWhenFocused(
                                                            focusNode:
                                                                firstNameFocusNode,
                                                            child: TextField(
                                                              focusNode:
                                                                  firstNameFocusNode,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff28293d),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                              onTap: () {
                                                                if (booking
                                                                    .canVibrate)
                                                                  Vibrate.feedback(
                                                                      FeedbackType
                                                                          .light);
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  0.5)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  1)),
                                                                      isDense:
                                                                          true,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              17,
                                                                          horizontal:
                                                                              20),
                                                                      labelText:
                                                                          'First Name*',
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff66718a),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        letterSpacing:
                                                                            0,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          EnsureVisibleWhenFocused(
                                                            focusNode:
                                                                lastNameFocusNode,
                                                            child: TextField(
                                                              focusNode:
                                                                  lastNameFocusNode,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff28293d),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                              onTap: () {
                                                                if (booking
                                                                    .canVibrate)
                                                                  Vibrate.feedback(
                                                                      FeedbackType
                                                                          .light);
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  0.5)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  1)),
                                                                      isDense:
                                                                          true,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              17,
                                                                          horizontal:
                                                                              20),
                                                                      labelText:
                                                                          'Last Name*',
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff66718a),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        letterSpacing:
                                                                            0,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          EnsureVisibleWhenFocused(
                                                            focusNode:
                                                                emailFocusNode,
                                                            child: TextField(
                                                              focusNode:
                                                                  emailFocusNode,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff28293d),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                              onTap: () {
                                                                if (booking
                                                                    .canVibrate)
                                                                  Vibrate.feedback(
                                                                      FeedbackType
                                                                          .light);
                                                              },
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              decoration:
                                                                  InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  0.5)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  1)),
                                                                      isDense:
                                                                          true,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              17,
                                                                          horizontal:
                                                                              20),
                                                                      labelText:
                                                                          'Email*',
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff66718a),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        letterSpacing:
                                                                            0,
                                                                      )),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          EnsureVisibleWhenFocused(
                                                            focusNode:
                                                                phoneFocusNode,
                                                            child: TextField(
                                                              focusNode:
                                                                  phoneFocusNode,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff28293d),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                letterSpacing:
                                                                    0,
                                                              ),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onTap: () {
                                                                if (booking
                                                                    .canVibrate)
                                                                  Vibrate.feedback(
                                                                      FeedbackType
                                                                          .light);
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  0.5)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          gapPadding:
                                                                              8,
                                                                          borderSide: BorderSide(
                                                                              width:
                                                                                  1)),
                                                                      isDense:
                                                                          true,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              17,
                                                                          horizontal:
                                                                              20),
                                                                      labelText:
                                                                          'Phone Number*',
                                                                      labelStyle:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff66718a),
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        letterSpacing:
                                                                            0,
                                                                      )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25),
                                                      child: Text(
                                                          "Reminders & Updates",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffb9c1d3),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            letterSpacing: 0,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 25,
                                                                vertical: 15),
                                                        child: Row(children: <
                                                            Widget>[
                                                          CupertinoSwitch(
                                                            onChanged: (value) {
                                                              if (booking
                                                                  .canVibrate)
                                                                Vibrate.feedback(
                                                                    FeedbackType
                                                                        .light);
                                                              setState(() {
                                                                isTextEnabled =
                                                                    value;
                                                              });
                                                            },
                                                            value:
                                                                isTextEnabled,
                                                            activeColor: theme
                                                                .accentColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("Text",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff778699),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                letterSpacing:
                                                                    0,
                                                              )),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          CupertinoSwitch(
                                                            onChanged: (value) {
                                                              if (booking
                                                                  .canVibrate)
                                                                Vibrate.feedback(
                                                                    FeedbackType
                                                                        .light);
                                                              setState(() {
                                                                isEmailEnabled =
                                                                    value;
                                                              });
                                                            },
                                                            value:
                                                                isEmailEnabled,
                                                            activeColor: theme
                                                                .accentColor,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("Email",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff778699),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                letterSpacing:
                                                                    0,
                                                              ))
                                                        ])),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ]),
                                            );
                                          } else
                                            return SizedBox();
                                        }
                                      }).toList(),
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                  )),
              if (showCartView)
                InkWell(
                  onTap: () {
                    setState(() {
                      showCartView = false;
                    });
                  },
                  child: Container(
                    color: Colors.black45,
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                        initialChildSize: 1,
                        minChildSize: 0.5,
                        maxChildSize: 1,
                        builder: (context, controller) {
                          return CartPage(
                            scrollController: controller,
                            onClosed: () {
                              setState(() {
                                showCartView = false;
                              });
                            },
                          );
                        }),
                  ),
                ),
              if (_appBarAnimationController.value == 0)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height:
                            (hasFocus ? 70 : (tabIndex != 0 ? 70 + 70 : 70)) +
                                media.padding.bottom / 2,
                        padding: EdgeInsets.only(
                            top: 12,
                            right: 20,
                            left: 10,
                            bottom: media.padding.bottom / 2),
                        decoration: new BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          boxShadow: [
                            if (!showCartView) ...{
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: showCartView
                                            ? null
                                            : () {
                                                setState(() {
                                                  showCartView = true;
                                                });
                                              },
                                        icon: Icon(
                                          FeatherIcons.shoppingBag,
                                          color: theme.accentColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                      if (tabIndex == 0) ...{
                                        SizedBox(width: 20),
                                        Text(booking.cartTotal,
                                            style: TextStyle(
                                              color: Color(0xfffafafa),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing:
                                                  -0.01666666629413763,
                                            ))
                                      } else ...{
                                        Container(
                                            width: 42,
                                            height: 42,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Image.asset(
                                              'assets/icons/arrow_right.png',
                                              color: theme.accentColor,
                                            )),
                                        Expanded(
                                          child: Text(booking.cartTotal,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Color(0xfffafafa),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing:
                                                    -0.01666666629413763,
                                              )),
                                        )
                                      }
                                    ],
                                  ),
                                ),
                                if (tabIndex == 0)
                                  Material(
                                    type: MaterialType.circle,
                                    color: (booking.selectedAdvisor == null ||
                                            booking.selectedTransportType ==
                                                null ||
                                            booking.selectedDate == null ||
                                            booking.selectedTimeSlot == null)
                                        ? Color(0xff4e515a)
                                        : theme.accentColor,
                                    elevation: (booking.selectedAdvisor ==
                                                null ||
                                            booking.selectedTransportType ==
                                                null ||
                                            booking.selectedDate == null ||
                                            booking.selectedTimeSlot == null)
                                        ? 0
                                        : 7,
                                    child: InkWell(
                                      onTap: (booking.selectedAdvisor == null ||
                                              booking.selectedTransportType ==
                                                  null ||
                                              booking.selectedDate == null ||
                                              booking.selectedTimeSlot == null)
                                          ? null
                                          : () {
                                              if (booking.canVibrate)
                                                Vibrate.feedback(
                                                    FeedbackType.light);
                                              tabController.animateTo(1,
                                                  duration: duration,
                                                  curve: Curves.easeOut);
                                            },
                                      customBorder: CircleBorder(),
                                      child: Container(
                                          width: 42,
                                          height: 42,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            'assets/icons/arrow_right.png',
                                            color: (booking.selectedAdvisor ==
                                                        null ||
                                                    booking.selectedTransportType ==
                                                        null ||
                                                    booking.selectedDate ==
                                                        null ||
                                                    booking.selectedTimeSlot ==
                                                        null)
                                                ? Colors.white24
                                                : null,
                                          )),
                                    ),
                                  )
                              ],
                            ),
                            if (!hasFocus && tabIndex != 0)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Material(
                                  color: Color(0xff00e1c2),
                                  borderRadius: BorderRadius.circular(32),
                                  child: InkWell(
                                    onTap: () {
                                      if (booking.canVibrate)
                                        Vibrate.feedback(FeedbackType.light);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FifthPage(),
                                              fullscreenDialog: true));
                                    },
                                    borderRadius: BorderRadius.circular(32),
                                    child: Container(
                                      height: 55,
                                      width: 308,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Schedule Appointment",
                                              style: TextStyle(
                                                color: Color(0xff2f313b),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 0,
                                              )),
                                          Text(
                                              "${DateFormat("EEE, MMM dd").format(booking.selectedDate)}  " +
                                                  booking.selectedTimeSlot,
                                              style: TextStyle(
                                                color: Color(0xff3a405a),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 0,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed(BookingProvider booking) {
    if (hasFocus) {
      removeFocus();
      return Future.value(false);
    } else if (showCartView) {
      setState(() {
        showCartView = false;
      });
      return Future.value(false);
    } else if (_appBarAnimationController.value != 0) {
      _appBarAnimationController.reverse();
      _animationController.forward();
      return Future.value(false);
    } else if (tabIndex != 0) {
      tabController.animateTo(0, duration: duration, curve: Curves.easeIn);
      return Future.value(false);
    } else if (mainPage != 0) {
      print('Print Page: $mainPage');
      setState(() {
        mainPage = 0;
      });
      return Future.value(false);
    } else {
      booking.setAdvisor(null);
      booking.setTransportType(null);
      booking.setDate(null);
      booking.setTimeSlot(null);
      Navigator.pop(context);
    }
  }
}

class TransportType {
  TransportType(this.title, this.subTitle, this.asset, this.darkAsset);

  final String title;
  final String subTitle;
  final String asset;
  final String darkAsset;
}
