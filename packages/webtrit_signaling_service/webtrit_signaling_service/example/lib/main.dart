import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signaling Service Example',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const SignalingDemoPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo page
// ---------------------------------------------------------------------------

class SignalingDemoPage extends StatefulWidget {
  const SignalingDemoPage({super.key});

  @override
  State<SignalingDemoPage> createState() => _SignalingDemoPageState();
}

class _SignalingDemoPageState extends State<SignalingDemoPage> {
  final _service = WebtritSignalingService();

  final _coreUrlCtrl = TextEditingController(text: 'wss://demo.webtrit.com');
  final _tenantIdCtrl = TextEditingController(text: 'default');
  final _tokenCtrl = TextEditingController();

  StreamSubscription<SignalingModuleEvent>? _sub;

  bool _serviceRunning = false;
  String _connectionStatus = 'idle';
  String? _handshakeSummary;
  final List<String> _eventLog = [];

  @override
  void dispose() {
    _sub?.cancel();
    _service.dispose();
    _coreUrlCtrl.dispose();
    _tenantIdCtrl.dispose();
    _tokenCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Service control
  // -------------------------------------------------------------------------

  Future<void> _startService() async {
    final config = SignalingServiceConfig(
      coreUrl: _coreUrlCtrl.text.trim(),
      tenantId: _tenantIdCtrl.text.trim(),
      token: _tokenCtrl.text.trim(),
    );

    _sub = _service.events.listen(_onEvent, onError: (Object err) => _appendLog('ERROR: $err'));

    await _service.start(config);

    if (mounted) setState(() => _serviceRunning = true);
  }

  Future<void> _stopService() async {
    await _sub?.cancel();
    _sub = null;
    await _service.dispose();

    if (mounted) {
      setState(() {
        _serviceRunning = false;
        _connectionStatus = 'idle';
        _handshakeSummary = null;
      });
    }
  }

  // -------------------------------------------------------------------------
  // Event handler
  // -------------------------------------------------------------------------

  void _onEvent(SignalingModuleEvent event) {
    setState(() {
      switch (event) {
        case SignalingConnecting():
          _connectionStatus = 'connecting...';
          _appendLog('[connecting]');
        case SignalingConnected():
          _connectionStatus = 'connected';
          _appendLog('[connected]');
        case SignalingConnectionFailed(:final error, :final isRepeated, :final recommendedReconnectDelay):
          _connectionStatus = 'failed';
          _appendLog(
            '[connection_failed] repeated=$isRepeated delay=${recommendedReconnectDelay.inSeconds}s err=$error',
          );
        case SignalingDisconnecting():
          _connectionStatus = 'disconnecting...';
          _appendLog('[disconnecting]');
        case SignalingDisconnected(:final code, :final knownCode, :final recommendedReconnectDelay):
          _connectionStatus = 'disconnected';
          _appendLog('[disconnected] code=$code known=$knownCode delay=${recommendedReconnectDelay?.inSeconds}s');
        case SignalingHandshakeReceived(:final handshake):
          _handshakeSummary =
              'status=${handshake.registration.status.name}  '
              'keepalive=${handshake.keepaliveInterval.inSeconds}s  '
              'lines=${handshake.lines.length}';
          _appendLog('[handshake] ${_handshakeSummary!}');
        case SignalingProtocolEvent(:final event):
          _appendLog('[protocol] ${event.runtimeType}');
      }
    });
  }

  void _appendLog(String line) {
    _eventLog.insert(0, '${DateTime.now().toIso8601String().substring(11, 23)}  $line');
    if (_eventLog.length > 200) _eventLog.removeLast();
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signaling Service Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ConfigCard(
              coreUrlCtrl: _coreUrlCtrl,
              tenantIdCtrl: _tenantIdCtrl,
              tokenCtrl: _tokenCtrl,
              enabled: !_serviceRunning,
            ),
            const SizedBox(height: 12),
            _StatusCard(status: _connectionStatus, handshake: _handshakeSummary),
            const SizedBox(height: 12),
            _ControlRow(running: _serviceRunning, onStart: _startService, onStop: _stopService),
            const SizedBox(height: 12),
            Expanded(child: _EventLogView(events: _eventLog)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _ConfigCard extends StatelessWidget {
  const _ConfigCard({
    required this.coreUrlCtrl,
    required this.tenantIdCtrl,
    required this.tokenCtrl,
    required this.enabled,
  });

  final TextEditingController coreUrlCtrl;
  final TextEditingController tenantIdCtrl;
  final TextEditingController tokenCtrl;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Connection', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: coreUrlCtrl,
              enabled: enabled,
              decoration: const InputDecoration(labelText: 'Core URL', border: OutlineInputBorder(), isDense: true),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tenantIdCtrl,
              enabled: enabled,
              decoration: const InputDecoration(labelText: 'Tenant ID', border: OutlineInputBorder(), isDense: true),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tokenCtrl,
              enabled: enabled,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Token', border: OutlineInputBorder(), isDense: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.status, required this.handshake});

  final String status;
  final String? handshake;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'connected' => Colors.green,
      'connecting...' => Colors.orange,
      'failed' || 'disconnected' => Colors.red,
      _ => Colors.grey,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(Icons.circle, color: color, size: 14),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status, style: Theme.of(context).textTheme.bodyMedium),
                  if (handshake != null) ...[
                    const SizedBox(height: 2),
                    Text(handshake!, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlRow extends StatelessWidget {
  const _ControlRow({required this.running, required this.onStart, required this.onStop});

  final bool running;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: running ? null : onStart,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: running ? onStop : null,
            icon: const Icon(Icons.stop),
            label: const Text('Stop'),
          ),
        ),
      ],
    );
  }
}

class _EventLogView extends StatelessWidget {
  const _EventLogView({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Text('Event log', style: Theme.of(context).textTheme.titleSmall),
          ),
          const Divider(height: 1),
          Expanded(
            child: events.isEmpty
                ? const Center(
                    child: Text('No events yet', style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: events.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                      child: Text(
                        events[i],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
