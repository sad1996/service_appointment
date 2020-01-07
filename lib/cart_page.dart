import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/model/service.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:vibrate/vibrate.dart';

class CartPage extends StatefulWidget {
  const CartPage(
      {Key key, this.scrollController, this.isEditable = true, this.onClosed})
      : super(key: key);

  final ScrollController scrollController;
  final bool isEditable;
  final VoidCallback onClosed;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    var media = MediaQuery.of(context);
    Size size = media.size;
    BookingProvider booking = Provider.of<BookingProvider>(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
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
              if (booking.addedServiceList.length > 0)
                AnimatedList(
                  key: _listKey,
                  padding: EdgeInsets.only(
                      top: 90,
                      left: 10,
                      bottom: 80 + media.padding.bottom / 2,
                      right: widget.isEditable ? 0 : 10),
                  controller: widget.scrollController,
                  initialItemCount: booking.addedServiceList.length,
                  itemBuilder: (context, index, animation) {
                    ServiceModel service = booking.addedServiceList[index];
                    return _buildItem(service, booking, index, animation);
                  },
                )
              else
                Align(
                  alignment: Alignment.center,
                  child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/icons/cart_empty.png',
                        height: size.height / 5,
                      )),
                ),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 25),
                  alignment: Alignment.centerLeft,
                  color: Color(0xff2f313b),
                  height: 80,
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
                              border: Border.all(
                                  color: Pigment.fromString('#2b2c36'))),
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
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildItem(ServiceModel service, BookingProvider booking, int index,
      Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: <Widget>[
          ListTile(
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
            trailing: widget.isEditable
                ? IconButton(
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
                      _listKey.currentState.removeItem(
                        0,
                        (BuildContext context, Animation animation) =>
                            _buildItem(service, booking, index, animation),
                        duration: const Duration(milliseconds: 200),
                      );
                      booking.addOrRemoveServiceToCart(service);
                    },
                  )
                : null,
          ),
          if (index != booking.addedServiceList.length - 1)
            Divider(
              color: Color(0xff15161e),
              height: 1,
              indent: 15,
              endIndent: widget.isEditable ? 30 : 15,
            )
        ],
      ),
    );
  }
}
