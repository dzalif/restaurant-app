import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/platform_widget.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool? _isSchedule;

  @override
  void initState() {
    super.initState();

    _initPrefs();
  }


  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingsPage.settingsTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(SettingsPage.settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Scheduling Restaurant'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(value: scheduled.isScheduled ?? _isSchedule ?? false, onChanged: (value) async {
                  if (Platform.isIOS) {
                    customDialog(context);
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('is_scheduled', value);
                    scheduled.scheduledNews();
                  }
                });
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  void _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isScheduled = prefs.getBool('is_scheduled');

    if (isScheduled == null) {
      setState(() {
        _isSchedule = false;
      });
    } else {
      setState(() {
        _isSchedule = isScheduled;
      });
    }
  }
}
