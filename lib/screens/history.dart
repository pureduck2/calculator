import 'dart:convert';

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
    return SafeArea(
        child: Center(child: Text(AppLocalizations.of(context)!.emptyHistory)));
  }

  Widget withHistory(BuildContext context, List<HistoryItem> history) {
    var background = Theme
        .of(context)
        .colorScheme
        .background;

    return SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: history.length,
          separatorBuilder: (BuildContext context, int i) =>
          const SizedBox(height: 10),
          itemBuilder: (BuildContext context, int i) =>
              ListTile(
                tileColor: background,
                title: Text(history[i].result),
                subtitle: Text(history[i].equation),
              ),
        ));
  }

  Future<List<HistoryItem>> getHistory() async {
    final history = await SharedPreferences.getInstance();
    final List<String> items = history.getStringList('history') ?? [];
    return Future.value(items.map((item) => HistoryItem.fromJson(jsonDecode(item))).toList());
  }

  Future<void> clearHistory() async {
    final history = await SharedPreferences.getInstance();
    await history.setStringList('history', []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.history),
          actions: [
            IconButton(
                onPressed: () {
                  clearHistory();
                  // Refresh history
                  setState(() {});
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => setState(() => args.clear()),
        //   child: const Icon(Icons.delete),
        // ),
        // body: args.isEmpty
        //     ? empty(context)
        //     : withHistory(context, args.reversed.toList())
        body: FutureBuilder<List<HistoryItem>>(
          future: getHistory(),
          builder: (BuildContext context, AsyncSnapshot<List<HistoryItem>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                debugPrint(snapshot.error.toString());
              }

              final history = snapshot.data;
              return history!.isEmpty ? empty(context) : withHistory(context, history.reversed.toList());
            }
          },
        )
    );
  }
}
