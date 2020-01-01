import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/model/model_default.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:service_appointment/third_page.dart';
import 'package:vibrate/vibrate.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin {
  bool isFirstTime = true;
  AnimationController makeListAnimationController;
  AnimationController _animationController;
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<int> yearList = List();
  List<List<int>> pages = List();
  var duration = Duration(milliseconds: 500);
  List<ModelDefault> brands = [
    ModelDefault('GMC', 'assets/images/gmc.png'),
    ModelDefault('Chevrolet', 'assets/images/oemSLogoActive.png'),
    ModelDefault('Buick', 'assets/images/buick.png'),
    ModelDefault('Cadillac', 'assets/images/cadillac.png'),
  ];
  int yearPage = 0;
  int mainPage = 0;
  TabController tabController;
  PageController mainPageController;
  PageController yearPageController;
  List<ModelDefault> vehicleModels = [
    ModelDefault('Corvette', 'assets/images/corvette.png'),
    ModelDefault('Spark', 'assets/images/spark.png'),
    ModelDefault('Equinox', 'assets/images/equinox.png'),
    ModelDefault('Camaro', 'assets/images/camaro.png'),
    ModelDefault('Implala', 'assets/images/implala.png'),
    ModelDefault('Malibu', 'assets/images/malibu.png'),
    ModelDefault('Cruze', 'assets/images/cruze.png'),
    ModelDefault('Sonic', 'assets/images/sonic.png'),
    ModelDefault('Corvette', 'assets/images/corvette.png'),
    ModelDefault('Spark', 'assets/images/spark.png'),
    ModelDefault('Equinox', 'assets/images/equinox.png'),
    ModelDefault('Camaro', 'assets/images/camaro.png'),
    ModelDefault('Implala', 'assets/images/implala.png'),
    ModelDefault('Malibu', 'assets/images/malibu.png'),
    ModelDefault('Cruze', 'assets/images/cruze.png'),
    ModelDefault('Sonic', 'assets/images/sonic.png'),
  ];
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    for (int i = 2020; i > 1980; i--) {
      yearList.add(i);
    }
    searchController.addListener(() => setState(() {}));
    pages.add(yearList.sublist(0, 20));
    pages.add(yearList.sublist(20, 40));
    yearPageController = PageController(initialPage: yearPage);
    mainPageController = PageController(initialPage: mainPage);
    tabController = TabController(vsync: this, length: 4, initialIndex: 0);
    tabController.addListener(() => setState(() {}));
    makeListAnimationController =
        AnimationController(duration: duration, vsync: this);
    _animationController = AnimationController(
        vsync: this, duration: duration, reverseDuration: duration);
    _animationController.addListener(() {
      setState(() {
        if (_animationController.value == 1) isFirstTime = false;
      });
    });
    _animationController.forward();
    focusNode.addListener(() {
      if (focusNode.hasFocus)
        _animationController.reverse();
      else
        _animationController.forward();
    });
  }

  @override
  void dispose() {
    makeListAnimationController.dispose();
    _animationController.dispose();
    super.dispose();
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
      title: Text('Select Vehicle',
          style: textTheme.subhead
              .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
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
      bottom: PreferredSize(
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          crossFadeState:
              (booking.selectedMake == null && booking.selectedYear == null)
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstCurve: Curves.easeOut,
          secondCurve: Curves.easeIn,
          firstChild: IgnorePointer(
              ignoring: mainPage != 0,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: theme.secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  focusNode: focusNode,
                  style: TextStyle(color: Colors.white),
                  onTap: () {
                    if (booking.canVibrate)
                      Vibrate.feedback(FeedbackType.light);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Enter or scan VIN (optional)',
                      hintStyle: textTheme.body1
                          .copyWith(color: Pigment.fromString('#b9c1d3')),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: IconButton(
                          icon: Icon(
                            AntDesign.qrcode,
                            color: Pigment.fromString('#b9c1d3'),
                            size: 18,
                          ),
                          onPressed: () {},
                        ),
                      )),
                ),
              )),
          secondChild: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.centerLeft,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: duration,
                        height: booking.selectedMake != null ? 45 : 0,
                        child: Material(
                          color: theme.secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () async {
                              if (booking.canVibrate)
                                Vibrate.feedback(FeedbackType.light);
                              booking.setMake(null);
                              booking.setYear(null);
                              setState(() {
                                if (mainPage != 0)
                                  mainPageController.previousPage(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeInOut);
                              });
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: booking.selectedMake != null
                                ? Container(
                                    height: 45,
                                    padding:
                                        EdgeInsets.only(left: 16, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 50),
                                          child: Image.asset(
                                            booking.selectedMake.asset,
                                            height: 30,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 2),
                                          child: Text(booking.selectedMake.name,
                                              style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
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
                        duration: Duration(milliseconds: 600),
                        height: booking.selectedYear != null ? 45 : 0,
                        child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Material(
                              color: theme.secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(35),
                              child: InkWell(
                                onTap: () async {
                                  if (booking.canVibrate)
                                    Vibrate.feedback(FeedbackType.light);
                                  booking.setYear(null);
                                  if (mainPage != 0)
                                    mainPageController.previousPage(
                                        duration: Duration(milliseconds: 1000),
                                        curve: Curves.easeInOut);
                                },
                                borderRadius: BorderRadius.circular(35),
                                child: booking.selectedYear != null
                                    ? Container(
                                        height: 45,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        alignment: Alignment.center,
                                        child: Text(
                                            booking.selectedYear.toString(),
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing:
                                                  -0.009999999776482582,
                                            )))
                                    : SizedBox(),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                if (mainPage != 0)
                  AnimatedPositioned(
                    right: 0,
                    left: isSearch ? 0 : null,
                    duration: Duration(milliseconds: 2000),
                    child: Container(
                      height: 50,
                      child: Material(
                        shape: isSearch
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))
                            : CircleBorder(),
                        elevation: isSearch ? 0 : 15,
                        color: theme.secondaryHeaderColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (isSearch)
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  autofocus: true,
                                  controller: searchController,
                                  onTap: () {
                                    if (booking.canVibrate)
                                      Vibrate.feedback(FeedbackType.light);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 13),
                                      hintText: 'Search Model/Trim',
                                      hintStyle: textTheme.body1.copyWith(
                                          color: Pigment.fromString('#b9c1d3')),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: IconButton(
                                          icon: Icon(
                                            searchController.text.isEmpty
                                                ? FeatherIcons.search
                                                : Icons.close,
                                            color:
                                                Pigment.fromString('#b9c1d3'),
                                            size: searchController.text.isEmpty
                                                ? 18
                                                : 20,
                                          ),
                                          onPressed: searchController
                                                  .text.isEmpty
                                              ? null
                                              : () {
                                                  searchController.text = '';
                                                },
                                        ),
                                      )),
                                ),
                              )
                            else
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isSearch = !isSearch;
                                  });
                                },
                                customBorder: isSearch
                                    ? RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30))
                                    : CircleBorder(),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    FeatherIcons.search,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(80),
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
        child: Opacity(
          opacity: isFirstTime ? _animationController.value : 1,
          child: Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: appBar,
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Align(
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: isFirstTime ? 0 : 1 - _animationController.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: size.height / 3,
                            padding: EdgeInsets.all(30),
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/images/group4.png',
                              height: size.height / 4,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                "Use the VIN number search.\nWe will add the vehicle for you.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffb9c1d3),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 0,
                                )),
                          )
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: IntTween(
                            begin: 0,
                            end: (size.height -
                                    (appBar.preferredSize.height +
                                        media.padding.top))
                                .toInt())
                        .animate(CurvedAnimation(
                            curve: Curves.easeIn,
                            reverseCurve: Curves.easeOut,
                            parent: _animationController))
                        .value
                        .toDouble(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: mainPage == 0
                          ? Pigment.fromString('#F8F8F8')
                          : Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: PageView.builder(
                          controller: mainPageController,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          onPageChanged: (page) => setState(() {
                                this.mainPage = page;
                              }),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            if (index == 0)
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 800),
                                      height: booking.selectedMake != null
                                          ? 0
                                          : (size.height / 3) + 90,
                                      curve: Curves.easeInOut,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    height: size.height / 3,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Image.asset(
                                                      'assets/images/selection.png',
                                                      height: size.height / 4.5,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 30),
                                                    child: Text(
                                                        "Book Appointment",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff1c1c28),
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          letterSpacing:
                                                              -0.01999999955296516,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/group0.png',
                                            height: size.height / 6,
                                            alignment: Alignment.topLeft,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 25, left: 20, bottom: 5),
                                      child: Text("Make",
                                          style: TextStyle(
                                            color: Color(0xffb9c1d3),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic,
                                            letterSpacing: 0,
                                          )),
                                    ),
                                    if (_animationController.value == 1)
                                      Container(
                                        height: 175,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            itemCount: brands.length,
                                            itemBuilder: (context, index) {
                                              ModelDefault makeModel = brands[index];
                                              bool isSelected = booking
                                                          .selectedMake !=
                                                      null &&
                                                  booking.selectedMake == makeModel;
                                              var count = brands.length;
                                              var animation =
                                                  Tween(begin: 0.0, end: 1.0)
                                                      .animate(
                                                CurvedAnimation(
                                                  parent:
                                                      makeListAnimationController,
                                                  curve: Interval(
                                                      (1 / count) * index, 1.0,
                                                      curve:
                                                          Curves.fastOutSlowIn),
                                                ),
                                              );
                                              makeListAnimationController
                                                  .forward();
                                              return AnimatedBuilder(
                                                  animation:
                                                      makeListAnimationController,
                                                  builder:
                                                      (BuildContext context,
                                                          Widget child) {
                                                    return FadeTransition(
                                                        opacity: animation,
                                                        child: new Transform(
                                                            transform: new Matrix4
                                                                    .translationValues(
                                                                50 *
                                                                    (1.0 -
                                                                        animation
                                                                            .value),
                                                                0.0,
                                                                0.0),
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          15),
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        Container(
                                                                      width: isSelected
                                                                          ? 117
                                                                          : 93,
                                                                      height: isSelected
                                                                          ? 124
                                                                          : 110,
                                                                      child:
                                                                          Material(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        elevation:
                                                                            2,
                                                                        shadowColor:
                                                                            Colors.white24,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            booking.setMake(makeModel);
                                                                            if (booking.canVibrate)
                                                                              Vibrate.feedback(FeedbackType.light);
                                                                          },
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          child:
                                                                              Material(
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                Image.asset(
                                                                                  makeModel.asset,
                                                                                  width: 65,
                                                                                  height: 50,
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(8),
                                                                                  child: Text(makeModel.name,
                                                                                      style: isSelected
                                                                                          ? TextStyle(
                                                                                              color: Color(0xff444f5c),
                                                                                              fontSize: 16,
                                                                                              fontWeight: FontWeight.w700,
                                                                                              fontStyle: FontStyle.normal,
                                                                                              letterSpacing: 0,
                                                                                            )
                                                                                          : TextStyle(
                                                                                              color: Color(0xffb9c1d3),
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.w700,
                                                                                              fontStyle: FontStyle.normal,
                                                                                            )),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (isSelected)
                                                                    Positioned(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      left: 0,
                                                                      child: Container(
                                                                          width: 32,
                                                                          height: 32,
                                                                          child: Material(
                                                                            type:
                                                                                MaterialType.circle,
                                                                            color:
                                                                                theme.accentColor,
                                                                            shadowColor:
                                                                                Colors.white24,
                                                                            elevation:
                                                                                7,
                                                                            child:
                                                                                Icon(
                                                                              FeatherIcons.checkCircle,
                                                                              color: Colors.white,
                                                                              size: 15,
                                                                            ),
                                                                          )),
                                                                    )
                                                                ],
                                                              ),
                                                            )));
                                                  });
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    SizedBox(width: 10)),
                                      ),
                                    Container(
                                        padding: EdgeInsets.only(top: 20),
                                        decoration: new BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            if (booking.selectedMake != null)
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10,
                                                          right: 20,
                                                          left: 20),
                                                      child: new Text("Year",
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
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: Icon(
                                                          FeatherIcons
                                                              .chevronLeft,
                                                          color: yearPage == 1
                                                              ? Pigment
                                                                  .fromString(
                                                                      '#2b2c36')
                                                              : theme
                                                                  .disabledColor,
                                                        ),
                                                        onPressed: yearPage != 1
                                                            ? null
                                                            : () async {
                                                          if (booking.canVibrate)
                                                                  Vibrate.feedback(
                                                                      FeedbackType
                                                                          .light);
                                                                yearPageController.previousPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    curve: Curves
                                                                        .easeIn);
                                                              },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          FeatherIcons
                                                              .chevronRight,
                                                          color: yearPage == 0
                                                              ? Pigment
                                                                  .fromString(
                                                                      '#2b2c36')
                                                              : theme
                                                                  .disabledColor,
                                                        ),
                                                        onPressed: yearPage != 0
                                                            ? null
                                                            : () async {
                                                          if (booking.canVibrate)
                                                                  Vibrate.feedback(
                                                                      FeedbackType
                                                                          .light);
                                                                yearPageController.nextPage(
                                                                    duration: Duration(
                                                                        milliseconds:
                                                                            300),
                                                                    curve: Curves
                                                                        .easeOut);
                                                              },
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            if (booking.selectedMake != null)
                                              Container(
                                                  height: 450,
                                                  child: PageView.builder(
                                                      controller:
                                                          yearPageController,
                                                      onPageChanged: (page) =>
                                                          setState(() {
                                                            this.yearPage =
                                                                page;
                                                          }),
                                                      itemCount: pages.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        List<int> page =
                                                            pages[index];
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 20,
                                                                  right: 20,
                                                                  left: 20),
                                                          child:
                                                              StaggeredGridView
                                                                  .countBuilder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            crossAxisCount: 4,
                                                            staggeredTileBuilder:
                                                                (index) =>
                                                                    StaggeredTile
                                                                        .fit(1),
                                                            itemCount:
                                                                page.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              int year =
                                                                  page[index];
                                                              bool isSelected =
                                                                  booking.selectedYear !=
                                                                          null &&
                                                                      booking.selectedYear ==
                                                                          year;
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10),
                                                                child: Material(
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      if (booking
                                                                              .selectedMake ==
                                                                          null) {
                                                                        showToast(
                                                                            'Please select vehicle make first');
                                                                        if (booking.canVibrate){
                                                                          Vibrate.feedback(
                                                                              FeedbackType.light);
                                                                          await Future.delayed(
                                                                              Duration(milliseconds: 100),
                                                                              () => Vibrate.feedback(FeedbackType.light));
                                                                          await Future.delayed(
                                                                              Duration(milliseconds: 100),
                                                                              () => Vibrate.feedback(FeedbackType.light));
                                                                        }
                                                                      } else {
                                                                        if (booking.canVibrate)
                                                                          Vibrate.feedback(
                                                                              FeedbackType.light);
                                                                        booking.setYear(
                                                                            year);
                                                                        mainPageController.nextPage(
                                                                            duration:
                                                                                Duration(milliseconds: 1000),
                                                                            curve: Curves.easeInOut);
                                                                      }
                                                                    },
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          50,
                                                                      decoration: new BoxDecoration(
                                                                          color: isSelected
                                                                              ? Color(0xff3a405a)
                                                                              : Colors.transparent,
                                                                          borderRadius: BorderRadius.circular(30)),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Material(
                                                                        child: Text(
                                                                            year
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(
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
                                        )),
                                  ],
                                ),
                              );
                            else
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if (isSearch)
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          right: 14,
                                          left: 20,
                                          bottom: 13),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                  booking.selectedMake.name +
                                                      ' ' +
                                                      booking.selectedYear
                                                          .toString(),
                                                  style: TextStyle(
                                                    color: Color(0xff1c1c28),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing:
                                                        -0.01999999955296516,
                                                  )),
                                            ),
                                          ),
                                          Material(
                                            child: InkWell(
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  'Close',
                                                  textAlign: TextAlign.right,
                                                  style: textTheme.button
                                                      .copyWith(
                                                          color: Colors.blue),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  isSearch = !isSearch;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10, right: 20, left: 20),
                                      child: Stack(
                                        children: <Widget>[
                                          TabBar(
                                              controller: tabController,
                                              indicator: UnderlineTabIndicator(
                                                  borderSide: BorderSide(
                                                      color: theme.accentColor,
                                                      width: 3),
                                                  insets: EdgeInsets.only(
                                                      right: 30, left: 17)),
                                              indicatorColor: theme.accentColor,
                                              labelColor: Color(0xff3a405a),
                                              unselectedLabelColor:
                                                  Color(0xffb9c1d3),
                                              isScrollable: true,
                                              tabs: [
                                                'Cars',
                                                "Suv's",
                                                'Trucks',
                                                'Commercials'
                                              ]
                                                  .map((tab) => Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 4),
                                                        child: Text(tab,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              letterSpacing:
                                                                  -0.01999999955296516,
                                                            )),
                                                      ))
                                                  .toList()),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 50,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                      stops: [
                                                    0.2,
                                                    0.4,
                                                    0.6,
                                                    1,
                                                  ],
                                                      colors: [
                                                    Colors.white,
                                                    Colors.white70,
                                                    Colors.white60,
                                                    Colors.white24,
                                                  ])),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: 50,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      stops: [
                                                    1,
                                                    0.6,
                                                    0.4,
                                                    0.2,
                                                  ],
                                                      colors: [
                                                    Colors.white24,
                                                    Colors.white60,
                                                    Colors.white70,
                                                    Colors.white,
                                                  ])),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  Expanded(
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        TabBarView(
                                          controller: tabController,
                                          physics: isSearch
                                              ? NeverScrollableScrollPhysics()
                                              : AlwaysScrollableScrollPhysics(),
                                          children:
                                              [
                                            'Cars',
                                            "Suv's",
                                            'Trucks',
                                            'Commercials'
                                          ]
                                                  .map((tab) => Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        fit: StackFit.expand,
                                                        children: <Widget>[
                                                          Container(
                                                            child:
                                                                StaggeredGridView
                                                                    .countBuilder(
                                                              shrinkWrap: true,
                                                              crossAxisCount: 2,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          30,
                                                                      right: 10,
                                                                      left: 10),
                                                              staggeredTileBuilder:
                                                                  (index) =>
                                                                      StaggeredTile
                                                                          .fit(
                                                                              1),
                                                              itemCount:
                                                                  vehicleModels.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                ModelDefault model =
                                                                    vehicleModels[
                                                                        index];
                                                                return Container(
                                                                  child:
                                                                      Material(
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                            if (booking.canVibrate)
                                                                          Vibrate.feedback(
                                                                              FeedbackType.light);
                                                                        booking.setVehicleModel(
                                                                            model);
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => ThirdPage()));
                                                                      },
                                                                      highlightColor:
                                                                          Colors
                                                                              .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            135,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Material(
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Expanded(child: Image.asset(model.asset)),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(bottom: 15.0),
                                                                                child: Text(
                                                                                  model.name,
                                                                                  style: TextStyle(
                                                                                    color: Color(0xff1f2136),
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FontStyle.normal,
                                                                                    letterSpacing: 0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                  .toList(),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: IgnorePointer(
                                            ignoring: true,
                                            child: Container(
                                              height: 65,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment.center,
                                                      stops: [
                                                    0.0,
                                                    0.4,
                                                    0.6,
                                                    0.8,
                                                    0.9,
                                                    1
                                                  ],
                                                      colors: [
                                                    Colors.white,
                                                    Colors.white60,
                                                    Colors.white54,
                                                    Colors.white30,
                                                    Colors.white12,
                                                    Colors.white
                                                        .withOpacity(0.05),
                                                  ])),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xff3a405a),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<bool> onBackPressed(BookingProvider booking) {
    if (isSearch) {
      setState(() {
        isSearch = false;
      });
      return Future.value(false);
    } else if (mainPage != 0) {
      print('Coming 2');
      print(mainPage);
      setState(() {
        mainPageController.previousPage(
            duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
      });
      return Future.value(false);
    } else {
      if (_animationController.value != 1) {
        if (focusNode.hasFocus) focusNode.unfocus();
        return Future.value(false);
      } else {
        booking.setMake(null);
        booking.setYear(null);
        booking.setVehicleModel(null);
        Navigator.pop(context);
      }
    }
  }
}
