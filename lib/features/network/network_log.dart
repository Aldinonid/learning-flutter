import 'package:flutter/material.dart';
import 'package:flutter_module_1/core/network/network_logger.dart';

class NetworkLogPage extends StatefulWidget {
  const NetworkLogPage({super.key});

  @override
  State<NetworkLogPage> createState() => _NetworkLogPageState();
}

class _NetworkLogPageState extends State<NetworkLogPage> {
  final logger = NetworkLogger();

  @override
  void initState() {
    super.initState();
    logger.addListener(_refresh);
  }

  @override
  void dispose() {
    logger.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final logs = logger.logs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() => logger.clear());
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return ExpansionTile(
            title: Text('${log.method} ${log.url}'),
            backgroundColor: log.statusCode == null && log.statusCode != 200 && log.statusCode != 201 ? Colors.redAccent : Colors.greenAccent,
            collapsedBackgroundColor: log.statusCode == null && log.statusCode != 200 && log.statusCode != 201 ? Colors.redAccent : Colors.greenAccent,
            subtitle: Text(
              'Status: ${log.statusCode ?? '-'} | ${log.responseTime}',
              style: const TextStyle(fontSize: 12),
            ),
            children: [
              if (log.requestData != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Request:\n${log.requestData}'),
                ),
              if (log.responseData != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Response:\n${log.responseData}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
