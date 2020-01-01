import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, @required this.type, @required this.value})
      : super(key: key);
  final String type;
  final String value;

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme.copyWith(
        headline: theme.textTheme.headline.copyWith(
            color: brightness == Brightness.dark
                ? Colors.white
                : theme.primaryColor),
        body1: theme.textTheme.body1.copyWith(
            color: brightness == Brightness.dark
                ? Colors.white
                : theme.primaryColor),
        body2: theme.textTheme.body2.copyWith(
            color: brightness == Brightness.dark
                ? Colors.white70
                : theme.primaryColor),
        title: theme.textTheme.title.copyWith(
            color: brightness == Brightness.dark
                ? Colors.white
                : theme.primaryColor));

    return ListTile(
      onTap: () {
        showDemoActionSheet(
          context: context,
          child: CupertinoActionSheet(
            title: Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Select your ${type.toLowerCase()}',
                style: textTheme.headline
                    .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            message: Text(
              'Please select the ${type.toLowerCase()} from the options below.',
              style: textTheme.body2,
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  'Option 1',
                  style: textTheme.title,
                ),
                onPressed: () {
                  Navigator.of(context).pop('option1');
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Option 2',
                  style: textTheme.title,
                ),
                onPressed: () {
                  Navigator.of(context).pop('option2');
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Option 3',
                  style: textTheme.title,
                ),
                onPressed: () {
                  Navigator.of(context).pop('option3');
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Option 4',
                  style: textTheme.title,
                ),
                onPressed: () {
                  Navigator.of(context).pop('option4');
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                'Cancel',
                style: textTheme.title.copyWith(color: theme.errorColor),
              ),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, 'cancel'),
            ),
          ),
        );
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: Text(type,
          style: TextStyle(
            color: Color(0xffb9c1d3),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 0,
          )),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(value,
              style: TextStyle(
                color: Color(0xffb9c1d3),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              )),
          SizedBox(
            width: 25,
          ),
          Icon(
            FeatherIcons.chevronDown,
            color: Color(0xffb9c1d3),
          )
        ],
      ),
    );
  }
}