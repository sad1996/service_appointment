import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/model/model_default.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:vibrate/vibrate.dart';

class AdvisorsPage extends StatefulWidget {
  const AdvisorsPage({Key key, this.scrollController, this.onClosed})
      : super(key: key);

  final ScrollController scrollController;
  final VoidCallback onClosed;

  @override
  _AdvisorsPageState createState() => _AdvisorsPageState(scrollController);
}

class _AdvisorsPageState extends State<AdvisorsPage>
    with TickerProviderStateMixin {
  _AdvisorsPageState(this.scrollController);

  final ScrollController scrollController;
  AnimationController advisorListAnimationController;
  var duration = Duration(milliseconds: 500);
  List<ModelDefault> advisors = [
    ModelDefault('Any Service Advisor', 'assets/images/avatars/avtr_any.png'),
    ModelDefault('Harold Shelton', 'assets/images/avatars/avtr_1.png'),
    ModelDefault('Warren Powers', 'assets/images/avatars/avtr_2.png'),
    ModelDefault('Alfred Estarada', 'assets/images/avatars/avtr_3.png'),
  ];

  @override
  void initState() {
    super.initState();
    advisorListAnimationController =
        AnimationController(duration: duration, vsync: this);
  }

  @override
  void dispose() {
    advisorListAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    var media = MediaQuery.of(context);
    Size size = media.size;
    return Consumer<BookingProvider>(
      builder: (context, booking, _) => GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Color(0xff2f313c),
          ),
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ListView.separated(
                  padding: EdgeInsets.only(
                      top: 70,
                      left: 10,
                      right: 10,
                      bottom: 80 + media.padding.top / 2),
                  controller: widget.scrollController,
                  itemCount: advisors.length,
                  itemBuilder: (context, index) {
                    var count = advisors.length;
                    var animation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: advisorListAnimationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    );
                    advisorListAnimationController.forward();
                    ModelDefault advisor = advisors[index];
                    return AnimatedBuilder(
                        animation: advisorListAnimationController,
                        builder: (BuildContext context, Widget child) {
                          bool isSelected = booking.selectedAdvisor == advisor;
                          return FadeTransition(
                              opacity: animation,
                              child: new Transform(
                                  transform: new Matrix4.translationValues(
                                      0.0, 50 * (1.0 - animation.value), 0.0),
                                  child: Center(
                                    child: Container(
                                      width: 240,
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Hero(
                                              tag: advisor.name,
                                              child: InkWell(
                                                onTap: () async {
                                                  if (booking.canVibrate)
                                                    Vibrate.feedback(
                                                        FeedbackType.light);
                                                  booking.setAdvisor(advisor);
                                                  Future.delayed(duration,
                                                      widget.onClosed);
                                                },
                                                child: Material(
                                                  color: theme
                                                      .secondaryHeaderColor,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: Container(
                                                    height: 50,
                                                    width: 240,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 15),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Image.asset(
                                                              advisor.asset),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(advisor.name,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffffffff),
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
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (isSelected)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Container(
                                                  width: 28,
                                                  height: 28,
                                                  child: Material(
                                                    type: MaterialType.circle,
                                                    color: theme.accentColor,
                                                    shadowColor: Colors.white24,
                                                    elevation: 7,
                                                    child: Icon(
                                                      FeatherIcons.checkCircle,
                                                      color: Colors.white,
                                                      size: 13,
                                                    ),
                                                  )),
                                            )
                                        ],
                                      ),
                                    ),
                                  )));
                        });
                  },
                  separatorBuilder: (_, __) => SizedBox(
                    height: 20,
                  ),
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 20),
                  color: Color(0xff2f313c),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Choose Service Advisor",
                          style: TextStyle(
                            color: Color(0xffb9c1d3),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xff2f313c),
                    Color(0xff2f313c).withOpacity(0.5),
                    Color(0xff2f313c).withOpacity(0.1)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  height: 3,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        if (booking.canVibrate)
                          Vibrate.feedback(FeedbackType.light);
                        widget.onClosed();
                      },
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(20)),
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        child: Text("Close",
                            style: TextStyle(
                              color: Color(0xff007bfe),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              letterSpacing: -0.01166666640589634,
                            )),
                      ),
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
}
