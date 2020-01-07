import 'package:flutter/foundation.dart';
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
  _PopularServicesPageState createState() =>
      _PopularServicesPageState(scrollController);
}

class _PopularServicesPageState extends State<PopularServicesPage>
    with TickerProviderStateMixin {
  _PopularServicesPageState(this.scrollController);

  final ScrollController scrollController;

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
  int scrolledIndex = 0;

  void scrollListenerWithItemHeight() {
    int itemHeight = 150; // including padding above and below the list item
    double scrollOffset = scrollController.offset;
    int firstVisibleItemIndex = scrollOffset < itemHeight
        ? 0
        : ((scrollOffset - itemHeight) / itemHeight).ceil();
    setState(() {
      scrolledIndex = firstVisibleItemIndex;
    });
  }

  // use this if total item count is known
  void scrollListenerWithItemCount() {
    int itemCount = popularServices.length;
    double scrollOffset = scrollController.position.pixels;
    double viewportHeight = scrollController.position.viewportDimension;
    double scrollRange = scrollController.position.maxScrollExtent -
        scrollController.position.minScrollExtent;
    int firstVisibleItemIndex =
        (scrollOffset / (scrollRange + viewportHeight) * itemCount).floor();
    setState(() {
      if (scrollOffset == scrollController.position.maxScrollExtent)
        scrolledIndex = popularServices.length - 1;
      else
        scrolledIndex = firstVisibleItemIndex + 1;
    });
  }

  AnimationController listAnimationController;
  var duration = Duration(milliseconds: 500);

  @override
  void dispose() {
    listAnimationController.dispose();
    scrollController.removeListener(scrollListenerWithItemCount);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listAnimationController =
        AnimationController(duration: duration, vsync: this);
    scrollController.addListener(scrollListenerWithItemCount);
  }

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
          color: Pigment.fromString('#f8f8f8'),
        ),
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              ListView.builder(
                padding: EdgeInsets.only(
                    top: 60,
                    left: 10,
                    right: 10,
                    bottom: 80 + media.padding.top / 2),
                controller: widget.scrollController,
                itemCount: popularServices.length,
                itemBuilder: (context, index) {
                  ServiceModel service = popularServices[index];
                  bool isInCart = booking.addedServiceList.contains(service);

    var count = popularServices.length;
    var animation = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
    parent: listAnimationController,
    curve: Interval((1 / count) * index, 1.0,
    curve: Curves.fastOutSlowIn),
    ),
    );
    listAnimationController.forward();
    return AnimatedBuilder(
    animation: listAnimationController,
    builder: (BuildContext context, Widget child) {
    return FadeTransition(
    opacity: animation,
    child: new Transform(
    transform: new Matrix4.translationValues(
    0.0, 50 * (1.0 - animation.value), 0.0),
    child:  Padding(
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
                          Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                            child: ListTile(
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
                                shadowColor: kIsWeb
                                    ? Colors.black.withOpacity(0.001)
                                    : Colors.black26,
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
                          ),
                        ],
                      ),
                    ),
                  )));});
                },
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 20),
                color: Pigment.fromString('#F8F8F8'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        "Popular Services" +
                            '   ' +
                            "${scrolledIndex + 1}/${popularServices.length}",
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
                  Pigment.fromString('#f8f8f8'),
                  Pigment.fromString('#f8f8f8').withOpacity(0.5),
                  Pigment.fromString('#f8f8f8').withOpacity(0.1)
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
    );
  }
}
