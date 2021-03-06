import 'package:flutter/material.dart';
import 'package:kaiteki/account_manager.dart';
import 'package:kaiteki/model/post_filters/sensitive_post_filter.dart';
import 'package:kaiteki/ui/widgets/icon_landing_widget.dart';
import 'package:kaiteki/ui/widgets/timeline.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    var container = Provider.of<AccountManager>(context);
    var timelineKey = ValueKey(container.currentAccount.hashCode);

    if (!container.loggedIn) {
      return const Center(
        child: IconLandingWidget(
          Mdi.key,
          'You need to be signed in to view your timeline',
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Timeline(
          key: timelineKey,
          adapter: container.adapter,
          filters: [SensitivePostFilter()],
        ),
      ),
    );
  }
}
