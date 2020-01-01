import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/ensure_visibility.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:service_appointment/second_page.dart';
import 'package:vibrate/vibrate.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AfterLayoutMixin<FirstPage> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    BookingProvider booking = Provider.of<BookingProvider>(context, listen: false);
    booking.firstTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    BookingProvider booking = Provider.of<BookingProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              "assets/images/oem-s-logo.png",
              height: 35,
            ),
            Container(
              margin: EdgeInsets.only(left: 17, right: 20),
              height: 40,
              width: 1,
              color: Pigment.fromString('#e6e8eb'),
            ),
            Image.asset(
              "assets/images/innovationmotorgroup.png",
              height: 30,
            )
          ],
        ),
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/icons/menu.png",
              height: 25,
              width: 25,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 7)
        ],
      ),
      body: GestureDetector(
        onTap: focusNode.hasFocus
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            : null,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                bottom: 30,
                right: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/footer.png',
                  height: 30,
                )),
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AnimatedContainer(
                    height: focusNode.hasFocus ? 0 : 160,
                    duration: Duration(milliseconds: 100),
                    margin:
                        EdgeInsets.only(bottom: focusNode.hasFocus ? 10 : 35),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/banner.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Service\nAppointments',
                    style: textTheme.display1.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Pigment.fromString('#2b2c36')),
                  ),
                  SizedBox(height: 20),
                  EnsureVisibleWhenFocused(
                    focusNode: focusNode,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          style: TextStyle(
                              color: Pigment.fromString('#1f2136'),
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                          focusNode: focusNode,
                          controller: booking.firstTextController,
                          onTap: (){
                            if (booking.canVibrate)
                              Vibrate.feedback(FeedbackType.light);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                gapPadding: 8,
                                borderSide: BorderSide(width: 0.5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                gapPadding: 8,
                                borderSide: BorderSide(width: 1)),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            labelText: 'Enter your phone or email*',
                            labelStyle: textTheme.subhead
                                .copyWith(color: Pigment.fromString('#66718a')),
                          ),
                        ),
                        SizedBox(height: 35),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(bottom: 20),
                          child: RaisedButton(
                            color: booking.firstTextController.text.isEmpty
                                ? theme.disabledColor
                                : theme.accentColor,
                            elevation: 0,
                            focusElevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                                width: 120,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'Start',
                                    style: textTheme.title.copyWith(
                                        color: booking.firstTextController.text.isEmpty
                                            ? Colors.white
                                            : theme.primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                            onPressed: booking.firstTextController.text.isEmpty
                                ? null
                                : () {
                              if (booking.canVibrate)
                                Vibrate.feedback(FeedbackType.light);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SecondPage(),
                                            fullscreenDialog: true));
                                  },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
