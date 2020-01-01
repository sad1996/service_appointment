import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';
import 'package:service_appointment/model/service.dart';
import 'package:service_appointment/provider/booking_provider.dart';
import 'package:vibrate/vibrate.dart';

class PopularServicesPage extends StatefulWidget {
  const PopularServicesPage({Key key, this.scrollController, this.onClosed})
      : super(key: key);

  final ScrollController scrollController;
  final VoidCallback onClosed;

  @override
  _PopularServicesPageState createState() => _PopularServicesPageState();
}

class _PopularServicesPageState extends State<PopularServicesPage>
    with TickerProviderStateMixin {
  var duration = Duration(milliseconds: 1000);
  AnimationController _animationController;

  List<ServiceModel> popularServices = [
    ServiceModel(
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
    ServiceModel(
      serviceTitle: 'Fuel induction and Injection system service',
      serviceCharge: 199.95,
    ),
  ];

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
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 3)
          ]),
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Popular Services",
                        style: TextStyle(
                          color: Color(0xffb9c1d3),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0,
                        )),
                    FlatButton(
                      onPressed: widget.onClosed,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text("Close",
                            style: TextStyle(
                              color: Color(0xff007bfe),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              letterSpacing: -0.01166666640589634,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 80 + media.padding.bottom / 2),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: popularServices.length,
                itemBuilder: (context, index) {
                  ServiceModel service = popularServices[index];
                  bool isInCart = booking.addedServiceList.contains(service);

                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Material(
                      elevation: 1,
                      color: Pigment.fromString('#F8F8F8'),
                      shadowColor: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 124,
                            decoration: new BoxDecoration(
                                color: Color(0xffe5ebf3),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8))),
                            child: Center(),
                          ),
                          ListTile(
                            title: Text("Inspect brakes / abs and advise",
                                style: TextStyle(
                                  color: Color(0xff2b2c36),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.5,
                                )),
                            subtitle: Text("\$24.95",
                                style: TextStyle(
                                  color: Color(0xff28293d),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.5,
                                )),
                            trailing: Material(
                              type: MaterialType.circle,
                              color: Colors.white,
                              elevation: 8,
                              shadowColor: Colors.white24,
                              child: InkWell(
                                onTap: () async {
                                  if (booking.canVibrate)
                                    Vibrate.feedback(FeedbackType.light);
                                  booking.addOrRemoveServiceToCart(service);
                                },
                                customBorder: CircleBorder(),
                                child: Container(
                                    width: 42,
                                    height: 42,
                                    child: Icon(
                                      isInCart ? Icons.remove : Icons.add,
                                      color: isInCart
                                          ? theme.errorColor
                                          : theme.primaryColor,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
