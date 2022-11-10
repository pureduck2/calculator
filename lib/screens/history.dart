import 'package:calculator/historyitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Widget empty(BuildContext context) {
    return const SafeArea(child: Center(child: Text('pusto')));
  }

  Widget withHistory(BuildContext context, List<HistoryItem> history) {
    var background = Theme.of(context).colorScheme.background;

    return SafeArea(
        child: ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: history.length,
      separatorBuilder: (BuildContext context, int i) =>
          const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int i) => ListTile(
        tileColor: background,
        title: Text(history[i].result),
        subtitle: Text(history[i].equation),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as List<HistoryItem>;

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.history),
          actions: [
            IconButton(
                onPressed: () => setState(() => args.clear()),
                icon: const Icon(Icons.delete))
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => setState(() => args.clear()),
        //   child: const Icon(Icons.delete),
        // ),
        body: args.isEmpty
            ? empty(context)
            : withHistory(context, args.reversed.toList()));
  }
}
