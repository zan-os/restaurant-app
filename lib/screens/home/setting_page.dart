import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Settings"),
      ),
      child: SafeArea(
        child: Material(
          child: ListTile(
            title: Text('Scheduling Notification'),
            trailing: ChangeNotifierProvider(
              create: (_) => SchedulingProvider(),
              child: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: scheduled.isScheduled,
                    onChanged: (value) async {
                      scheduled.scheduledNews(value);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
