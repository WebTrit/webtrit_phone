import 'dart:convert';
import 'web_view_container.dart';

/// Injects a console wrapper that forwards console.* messages through a JS channel.
class ConsoleLoggingInjectionStrategy extends JavaScriptInjectionStrategy {
  ConsoleLoggingInjectionStrategy({String channelName = 'WebtritConsoleLogChannel'})
      : super.raw(
          _buildScript(channelName),
          label: '[WebtritConsoleLogChannel]',
          returnResult: true,
        );

  static String _buildScript(String channelName) {
    final ch = jsonEncode(channelName);

    return '''
(function() {
  if (window.__webtritConsoleWrapped) return 'ConsoleLog:already';
  window.__webtritConsoleWrapped = true;

  function safeToString(v) {
    try {
      if (v === undefined) return 'undefined';
      if (v === null) return 'null';
      if (typeof v === 'string') return v;
      return JSON.stringify(v);
    } catch (e) {
      return '[Unserializable]';
    }
  }

  function postJson(channelName, obj) {
    try {
      const s = JSON.stringify(obj);
      (window[channelName] || globalThis[channelName]).postMessage(s);
    } catch (e) {
      try {
        (window[channelName] || globalThis[channelName]).postMessage(
          JSON.stringify({ event: 'ERROR', data: { message: 'postMessage failed', error: String(e) } })
        );
      } catch (_) {}
    }
  }

  function wrapConsole(method, level) {
    const original = console[method];
    console[method] = function(...args) {
      const msg = args.map(safeToString).join(' ');
      postJson($ch, {
        event: level,
        data: {
          message: msg,
          args: args.map(a => {
            try { return typeof a === 'string' ? a : JSON.stringify(a); }
            catch { return '[Unserializable]'; }
          })
        }
      });
      try { original.apply(console, args); } catch (_) {}
    };
  }

  wrapConsole('log',   'LOG');
  wrapConsole('info',  'INFO');
  wrapConsole('warn',  'WARN');
  wrapConsole('error', 'ERROR');
  wrapConsole('debug', 'DEBUG');

  return 'ConsoleLog:ok';
})();
''';
  }
}
