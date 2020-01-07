import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isSelected: false,
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onDateSelected,
      child: new Container(
        padding: new EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        child: new Material(
          elevation: isSelected ? 1.0 : 0.0,
          color: isSelected
                  ? Color(0xff3a405a)
                  : Colors.transparent,
          shape: isSelected
                  ? RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(21))
                  : null,
          child: Stack(
            children: <Widget>[
              Container(
                height: 64,
                child: new Center(
                  child: Text(Utils.formatDay(date).toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? Color(0xffffffff) : Color(0xff66718a),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.009999999776482582,

                      )
                  )
                ),
              ),
              if(Utils.isSameDay(date, DateTime.now()))
              Positioned(bottom: 7,
                right: 0,
                left: 0,
                child: Container(
                    width: 7,
                    height: 7,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                        color: Color(0xff2fedd3)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
