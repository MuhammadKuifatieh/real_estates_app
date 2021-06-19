import 'package:flutter/material.dart';

class DiscriptionWidget extends StatelessWidget {
  DiscriptionWidget(this.discription);
  final String discription;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discription',
          style: textTheme.subtitle1
              .copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          discription,
          style: textTheme.bodyText2.copyWith(
            color: Colors.black45,
            fontSize: 16.0,
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'more',
              style: textTheme.bodyText2
                  .copyWith(fontSize: 16.0, color: theme.accentColor),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
              color: theme.accentColor,
            ),
          ],
        ),
      ],
    );
  }
}
