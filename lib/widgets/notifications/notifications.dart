import 'package:flutter/material.dart';

import './single-notification.dart';

class Notifications extends StatefulWidget {
  final List notifications;
  final Function refresh;
  final Function deleteNotification;

  Notifications(this.notifications, this.refresh, this.deleteNotification);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var indexes = [-1, -1, -1];
  int calculateDifference(int date) {
    var notifDate = DateTime.fromMillisecondsSinceEpoch(date);
    DateTime now = DateTime.now();
    return DateTime(notifDate.year, notifDate.month, notifDate.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  void calculateDateIndexes() {
    for (var i = 0; i < widget.notifications.length; i++) {
      var notification = widget.notifications[i];
      var difference = calculateDifference(notification['createdAt']['\$date']);
      if (difference == 0) {
        if (indexes[0] != -1) {
          continue;
        } else {
          indexes[0] = i;
        }
      }
      if (difference == -1) {
        if (indexes[1] != -1) {
          continue;
        } else {
          indexes[1] = i;
        }
      }
      if (difference <= -2) {
        if (indexes[2] != -1) {
          continue;
        } else {
          indexes[2] = i;
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    calculateDateIndexes();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: widget.notifications.length,
        itemBuilder: (_, i) {
          var notification = widget.notifications[i];
          if (i == indexes[0]) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  width: double.infinity,
                  color: Colors.grey.shade900,
                  child: Text(
                    'Bugün',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SingleNotification(
                  notification,
                  widget.refresh,
                  widget.deleteNotification,
                ),
              ],
            );
          } else if (indexes.length > 1 && i == indexes[1]) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  width: double.infinity,
                  color: Colors.grey.shade900,
                  child: Text(
                    'Dün',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SingleNotification(
                  notification,
                  widget.refresh,
                  widget.deleteNotification,
                ),
              ],
            );
          } else if (indexes.length > 2 && i == indexes[2]) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                  width: double.infinity,
                  color: Colors.grey.shade900,
                  child: Text(
                    'Daha Eski',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SingleNotification(
                  notification,
                  widget.refresh,
                  widget.deleteNotification,
                ),
              ],
            );
          } else {
            return SingleNotification(
              notification,
              widget.refresh,
              widget.deleteNotification,
            );
          }
        },
      ),
    );
  }
}
