import 'package:after_layout/after_layout.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/cart_page.dart';
import 'package:service_appointment/ensure_visibility.dart';
import 'package:service_appointment/feedback_page.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:service_appointment/utils/animation_transition.dart';
import 'package:vibrate/vibrate.dart';

class FifthPage extends StatefulWidget {
  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage>
    with TickerProviderStateMixin, AfterLayoutMixin<FifthPage> {
  _FifthPageState();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var duration = Duration(milliseconds: 1000);
  AnimationController _animationController;
  bool isFirstTime = true;
  TextEditingController commentController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isSubmitted = false;
  bool canPop = true;
  AppBar appBar;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: duration,
        reverseDuration: Duration(milliseconds: 500));
    _animationController.addListener(() {
      setState(() {
        if (_animationController.value == 1) isFirstTime = false;
      });
    });
    _animationController.forward();
    focusNode.addListener(() => setState(() {}));
    commentController.addListener(() {
      setState(() {});
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    showGeneralDialog<bool>(
        context: context,
        barrierColor: Colors.black38,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: Duration(milliseconds: 600),
        transitionBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            AnimationTransition.fromBottom(
                animation, secondaryAnimation, child),
        pageBuilder: (context, _, __) => SimpleDialog(
              elevation: 0,
              backgroundColor: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 438,
                  decoration: new BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/thank_you_icon.png',
                        height: 120,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Thank You!",
                          style: TextStyle(
                            color: Color(0xff1c1c28),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.01999999955296516,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "We take pride in serving you at Innovation Motors.An appointment confirmation has been sent to your email jayvijayan@tekion.com",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xffb9c1d3),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0,
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FutureBuilder<bool>(
                        future:
                            Future.delayed(Duration(seconds: 11), () => true),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data)
                            return SizedBox(
                              height: 40,
                            );
                          else
                            return Material(
                              color: Color(0xff00e1c2),
                              borderRadius: BorderRadius.circular(32),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(false);
                                },
                                borderRadius: BorderRadius.circular(32),
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Text("Ok",
                                      style: TextStyle(
                                        color: Color(0xff3a405a),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0,
                                      )),
                                ),
                              ),
                            );
                        },
                      )
                    ],
                  ),
                )
              ],
            )).then((canPop) => setState(() => this.canPop = canPop));
    Future.delayed(Duration(seconds: 12), () {
      if (canPop == null || canPop) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
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

    appBar = AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
            icon: Icon(FeatherIcons.chevronLeft), onPressed: onBackPressed),
        title: Text('Appointment Summary',
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
          child: SizedBox(),
          preferredSize: Size.fromHeight(10),
        ));
    return WillPopScope(
      onWillPop: onBackPressed,
      child: GestureDetector(
        onTap: focusNode.hasFocus
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : null,
        child: Opacity(
          opacity: isFirstTime ? _animationController.value : 1,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: theme.primaryColor,
            appBar: appBar,
            resizeToAvoidBottomPadding: true,
            body: Stack(
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
                      color: Pigment.fromString('#F8F8F8'),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 100),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 30),
                                    child: Image.asset(
                                      booking.selectedVehicleModel.asset,
                                      height: 100,
                                      width: 120,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "${booking.selectedMake.name}\n${booking.selectedYear.toString()} ${booking.selectedVehicleModel.name}",
                                        style: TextStyle(
                                          color: Color(0xff3a405a),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                  ),
                                  Container(
                                      width: 1,
                                      height: 64,
                                      decoration: new BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffd7dce4),
                                              width: 1))),
                                  InkWell(
                                    onTap: () => showCartView(booking),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Stack(
                                            children: <Widget>[
                                              IconButton(
                                                onPressed: null,
                                                icon: Icon(
                                                  FeatherIcons.shoppingBag,
                                                  color: theme.primaryColor,
                                                  size: 30,
                                                ),
                                              ),
                                              if (booking.addedServiceList !=
                                                      null &&
                                                  booking.addedServiceList
                                                          .length >
                                                      0)
                                                Positioned(
                                                  top: 0,
                                                  right: 5,
                                                  child: Material(
                                                    color: theme.accentColor,
                                                    type: MaterialType.circle,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6.0),
                                                      child: Text(
                                                          booking.cartCount,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff3a405a),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            letterSpacing: 0,
                                                          )),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              (booking.addedServiceList !=
                                                          null &&
                                                      booking.addedServiceList
                                                              .length >
                                                          0)
                                                  ? "Added\nServices"
                                                  : "No\nServices\nAdded",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xff3a405a),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 0,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 1),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              DateFormat("EEEE")
                                                  .format(booking.selectedDate),
                                              maxLines: 1,
                                              softWrap: true,
                                              style: textTheme.caption.copyWith(
                                                  fontSize: 6,
                                                  color: theme.errorColor),
                                            ),
                                          ),
                                          Text(
                                            DateFormat("dd")
                                                .format(booking.selectedDate),
                                            style: textTheme.title.copyWith(
                                                color: theme.disabledColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    title: Text("Date & Time",
                                        style: TextStyle(
                                          color: Color(0xff818388),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                    subtitle: Text(
                                        "${DateFormat("EEE, MMM dd").format(booking.selectedDate)}  " +
                                            booking.selectedTimeSlot,
                                        style: TextStyle(
                                          color: Color(0xff1f2136),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      padding: EdgeInsets.all(3),
                                      child: Image.asset(
                                          booking.selectedAdvisor.asset),
                                    ),
                                    title: Text("Service Advisor",
                                        style: TextStyle(
                                          color: Color(0xff818388),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                    subtitle: Text(booking.selectedAdvisor.name,
                                        style: TextStyle(
                                          color: Color(0xff1f2136),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      padding: EdgeInsets.all(3),
                                      child: Image.asset(
                                          booking.selectedTransportType.asset),
                                    ),
                                    title: Text("Transportation",
                                        style: TextStyle(
                                          color: Color(0xff818388),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                    subtitle: Text(
                                        booking.selectedTransportType.title,
                                        style: TextStyle(
                                          color: Color(0xff1f2136),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      padding: EdgeInsets.all(7),
                                      child: Image.asset(
                                          'assets/icons/navigate.png'),
                                    ),
                                    title: Text("Location",
                                        style: TextStyle(
                                          color: Color(0xff818388),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0,
                                        )),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                          '4300 John Monego Court\nDublin CA 94568',
                                          style: TextStyle(
                                            color: Color(0xff1f2136),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 0,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  EnsureVisibleWhenFocused(
                                    focusNode: focusNode,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 25),
                                          decoration: isSubmitted
                                              ? null
                                              : BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: focusNode.hasFocus
                                                          ? Pigment.fromString(
                                                              '#66718a')
                                                          : Pigment.fromString(
                                                              '#b9c1d3')),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                          child: ConstrainedBox(
                                            constraints:
                                                BoxConstraints(minHeight: 100),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color:
                                                            Pigment.fromString(
                                                                '#1f2136'),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    enabled: !isSubmitted,
                                                    focusNode: focusNode,
                                                    maxLines: null,
                                                    onTap: () {
                                                      if (booking.canVibrate)
                                                        Vibrate.feedback(
                                                            FeedbackType.light);
                                                    },
                                                    controller:
                                                        commentController,
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        25),
                                                        labelText:
                                                            'Additional Comments',
                                                        labelStyle: textTheme
                                                            .subhead
                                                            .copyWith(
                                                                color: Pigment
                                                                    .fromString(
                                                                        '#66718a')),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                                if (isSubmitted &&
                                                    commentController
                                                        .text.isNotEmpty)
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        if (isSubmitted) {
                                                          setState(() {
                                                            isSubmitted = false;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (focusNode.hasFocus)
                                          SizedBox(
                                            height: 100,
                                          ),
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
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: new BoxDecoration(
                      color: Color(0xff2f313b),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      boxShadow: [
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
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("How was your booking experience?",
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        if (focusNode.hasFocus)
                          Material(
                            color: commentController.text.isEmpty
                                ? theme.disabledColor
                                : Color(0xff00e1c2),
                            borderRadius: BorderRadius.circular(32),
                            child: InkWell(
                              onTap: () {
                                if (commentController.text.isNotEmpty) {
                                  if (booking.canVibrate)
                                    Vibrate.feedback(FeedbackType.light);
                                  setState(() {
                                    isSubmitted = true;
                                  });
                                  if (focusNode.hasFocus) focusNode.unfocus();
                                }
                              },
                              borderRadius: BorderRadius.circular(32),
                              child: Container(
                                height: 45,
                                width: 170,
                                alignment: Alignment.center,
                                child: Text("Submit",
                                    style: TextStyle(
                                      color: commentController.text.isEmpty
                                          ? Colors.white
                                          : Color(0xff3a405a),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                    )),
                              ),
                            ),
                          )
                        else
                          Material(
                            color: Color(0xff00e1c2),
                            borderRadius: BorderRadius.circular(32),
                            child: InkWell(
                              onTap: showFeedbackDialog,
                              borderRadius: BorderRadius.circular(32),
                              child: Container(
                                height: 45,
                                width: 170,
                                alignment: Alignment.center,
                                child: Text("Give Feedback",
                                    style: TextStyle(
                                      color: Color(0xff3a405a),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                    )),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showFeedbackDialog() {
    Navigator.push(
        context,
        PageRouteBuilder(
            fullscreenDialog: true,
            opaque: false,
            barrierColor:  Color(0xff2f313b),
            barrierDismissible: false,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                AnimationTransition.fromBottom(
                    animation, secondaryAnimation, child),
            pageBuilder: (context, _, __) => FeedbackPage()));
  }

  showCartView(BookingProvider booking) async {
    final ThemeData theme = Theme.of(context);
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
                            isEditable: false,
                          );
                        }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Consumer<BookingProvider>(builder: (context, booking, _)=>Container(
                        height: 70 + media.padding.bottom / 2,
                        padding: EdgeInsets.only(
                            right: 20,
                            left: 10,
                            bottom: media.padding.bottom / 2),
                        decoration: new BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
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
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
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
                                  Container(
                                      width: 42,
                                      height: 42,
                                      padding: EdgeInsets.all(10),
                                      margin:
                                      EdgeInsets.symmetric(horizontal: 10),
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
                                          letterSpacing: -0.01666666629413763,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future<bool> onBackPressed() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
      return Future.value(false);
    } else {
      Navigator.pop(context);
    }
  }
}
