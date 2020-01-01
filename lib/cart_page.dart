import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/model/service.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:vibrate/vibrate.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key, this.scrollController, this.onClosed})
      : super(key: key);

  final ScrollController scrollController;
  final VoidCallback onClosed;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  var duration = Duration(milliseconds: 1000);
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: duration,
        reverseDuration: Duration(milliseconds: 500));
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
    return Container(
      height: IntTween(begin: 0, end: size.height.toInt())
          .animate(CurvedAnimation(
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut,
              parent: _animationController))
          .value
          .toDouble(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color(0xff2f313b),
          ),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Stack(
          children: <Widget>[
            ListView.separated(
              padding: EdgeInsets.only(
                  top: 90, left: 10, bottom: 80 + media.padding.bottom / 2),
              controller: widget.scrollController,
              itemCount: booking.addedServiceList.length,
              itemBuilder: (context, index) {
                ServiceModel service = booking.addedServiceList[index];

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(service.serviceTitle,
                              style: TextStyle(
                                color: Color(0xffb9c1d3),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                letterSpacing: -0.5,
                              )),
                        ),
                      ),
                      Text(service.serviceCost,
                          style: TextStyle(
                            color: Color(0xffb9c1d3),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.5,
                          ))
                    ],
                  ),
                  trailing: IconButton(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(
                        FeatherIcons.trash,
                        color: Color(0xffb9c1d3),
                        size: 20,
                      ),
                    ),
                    onPressed: () {
                      if (booking.canVibrate)
                        Vibrate.feedback(FeedbackType.light);
                      booking.addOrRemoveServiceToCart(service);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: Color(0xff15161e),
                height: 1,
                indent: 15,
                endIndent: 30,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 25),
              alignment: Alignment.centerLeft,
              height: 55,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 48,
                      width: 48,
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Pigment.fromString('#2b2c36'))),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            letterSpacing: -0.01999999955296516,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: GestureDetector(
                onTap: widget.onClosed,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
      ),
    );
  }
}
