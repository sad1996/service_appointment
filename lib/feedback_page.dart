import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/ensure_visibility.dart';
import 'package:service_appointment/model/model_default.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:service_appointment/widget/animated_emoji.dart';
import 'package:vibrate/vibrate.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<ModelDefault> feedbackList = [
    ModelDefault('Great', 'assets/icons/feedback/good.png'),
    ModelDefault('Happy', 'assets/icons/feedback/happy.png'),
    ModelDefault('Confused', 'assets/icons/feedback/confused.png'),
    ModelDefault('Down', 'assets/icons/feedback/angry.png')
  ];
  TextEditingController feedbackController = TextEditingController();
  PageController mainPageController = PageController(initialPage: 0);
  int mainPage = 0;
  PageController feedbackPageController =
      PageController(viewportFraction: 0.5, initialPage: 1);
  int feedbackPage = 1;
  ModelDefault selectedFeedback;
  bool isClosed = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedbackController.addListener(() => setState(() {}));
    focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    var media = MediaQuery.of(context);
    Size size = media.size;
    BookingProvider booking =
        Provider.of<BookingProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xff2f313b),
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: focusNode.hasFocus
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : null,
        child: AnimatedOpacity(
          opacity: isClosed ? 0 : 1,
          duration: Duration(milliseconds: 500),
          child: Material(
            child: Stack(
              children: <Widget>[
                PageView.builder(
                    controller: mainPageController,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    onPageChanged: (page) {
                      setState(() {
                        this.mainPage = page;
                      });
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      if (index == 0)
                        return Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 250,
                                margin: EdgeInsets.only(top: 70),
                                child: PageView.builder(
                                    controller: feedbackPageController,
                                    onPageChanged: (page) {
                                      if (booking.canVibrate)
                                        Vibrate.feedback(FeedbackType.light);
                                      setState(() {
                                        this.feedbackPage = page;
                                      });
                                    },
                                    itemCount: feedbackList.length,
                                    itemBuilder: (context, index) {
                                      ModelDefault feedback =
                                          feedbackList[index];
                                      bool isCurrentItem =
                                          feedbackPage == index;
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30, horizontal: 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (booking.canVibrate)
                                              Vibrate.feedback(
                                                  FeedbackType.light);
                                            mainPageController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.linear);
                                            setState(() {
                                              selectedFeedback = feedback;
                                            });
                                          },
                                          child: Material(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                AnimatedContainer(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  height:
                                                      isCurrentItem ? 120 : 60,
                                                  child: Opacity(
                                                    opacity:
                                                        isCurrentItem ? 1 : 0.6,
                                                    child: Image.asset(
                                                      feedback.asset,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      isCurrentItem ? 15 : 30,
                                                ),
                                                Text(feedback.name,
                                                    style: isCurrentItem
                                                        ? TextStyle(
                                                            color: Color(
                                                                0xffffffff),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            letterSpacing:
                                                                -0.5714285714285714,
                                                          )
                                                        : TextStyle(
                                                            color: Color(
                                                                0xffb9c1d3),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            letterSpacing: -0.5,
                                                          )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            SafeArea(
                              child: Container(
                                margin: EdgeInsets.only(top: 110),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Text(
                                          "How was your appointment booking experience?",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: -0.857142857142857,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      else
                        return Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              child: Center(),
                            ),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeOut,
                              opacity: focusNode.hasFocus ? 0 : 1,
                              child: SafeArea(
                                child: Container(
                                  margin: EdgeInsets.only(top: 110),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(30),
                                        child: Text(
                                            "Would you like to eloborate on what happened?",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.857142857142857,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(30),
                                margin: EdgeInsets.only(top: 70),
                                height: size.height / 2.5,
                                child: EnsureVisibleWhenFocused(
                                  focusNode: focusNode,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: 1,
                                          decoration: new BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffb9c1d3),
                                                  width: 1))),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: !focusNode.hasFocus
                                              ? () {
                                                  FocusScope.of(context)
                                                      .requestFocus(focusNode);
                                                }
                                              : null,
                                          child: Material(
                                            child: TextField(
                                              maxLines: null,
                                              focusNode: focusNode,
                                              controller: feedbackController,
                                              textAlignVertical:
                                                  TextAlignVertical.top,
                                              style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.5,
                                              ),
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 30, top: 0),
                                                  hintText: 'Hmm, well',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xffb9c1d3),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: -0.5,
                                                  ),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (feedbackController.text.isEmpty)
                              Positioned(
                                bottom: media.padding.bottom + 30,
                                right: 0,
                                left: 0,
                                child: Center(
                                  child: Material(
                                    child: InkWell(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text("No Thanks".toUpperCase(),
                                            style: TextStyle(
                                              color: Color(0xff818389),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0,
                                            )),
                                      ),
                                      onTap: () {
                                        if (booking.canVibrate)
                                          Vibrate.feedback(FeedbackType.light);
                                        setState(() {
                                          if (focusNode.hasFocus)
                                            focusNode.unfocus();
                                          setState(() {
                                            isClosed = true;
                                          });
                                          Future.delayed(
                                              Duration(milliseconds: 600), () {
                                            booking.clearAll();
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst);
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            else
                              Positioned(
                                  bottom: media.padding.bottom +
                                      (focusNode.hasFocus ? 15 : 30),
                                  right: 30,
                                  left: 30,
                                  child: Material(
                                    color: Color(0xff00e1c2),
                                    borderRadius: BorderRadius.circular(32),
                                    child: InkWell(
                                      onTap: () {
                                        if (booking.canVibrate)
                                          Vibrate.feedback(FeedbackType.light);
                                        if (focusNode.hasFocus)
                                          focusNode.unfocus();
                                        setState(() {
                                          isClosed = true;
                                        });
                                        Future.delayed(
                                            Duration(milliseconds: 600), () {
                                          booking.clearAll();
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(32),
                                      child: Container(
                                        height: 55,
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: Text("Submit",
                                            style: TextStyle(
                                              color: Color(0xff3a405a),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: 0,
                                            )),
                                      ),
                                    ),
                                  ))
                          ],
                        );
                    }),
                SafeArea(
                    child: Container(
                        height: 150,
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(left: 30),
                                  child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeOut,
                                      opacity: focusNode.hasFocus ? 0.1 : 1,
                                      child: AnimatedEmoji())),
                              if (mainPage != 1)
                                Material(
                                  child: InkWell(
                                    onTap: () {
                                      if (booking.canVibrate)
                                        Vibrate.feedback(FeedbackType.light);
                                      Navigator.of(context).pop();
                                    },
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 25),
                                      child: Text("Close",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic,
                                            letterSpacing: -0.01166666640589634,
                                          )),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ])))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
