import 'package:flutter/cupertino.dart';

class ProgressBar extends StatelessWidget {
  final Color backgroundColor;
  final double progress;

  const ProgressBar({
    Key key,
    this.backgroundColor = CupertinoColors.systemGrey4,
    @required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthProgress = MediaQuery.of(context).size.width *
        0.65 *
        (progress <= 1 ? progress : 1);
    Color progressColor = progress <= 0.5
        ? CupertinoColors.systemGreen
        : progress <= 0.75
            ? CupertinoColors.systemYellow
            : progress <= 0.9
                ? CupertinoColors.systemOrange
                : CupertinoColors.systemRed;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: SizedBox(
        height: 10.0,
        width: MediaQuery.of(context).size.width * 0.65,
        child: Stack(
          children: [
            Container(
              color: backgroundColor,
            ),
            Container(
              width: widthProgress,
              color: progressColor,
            ),
          ],
        ),
      ),
    );
  }
}
