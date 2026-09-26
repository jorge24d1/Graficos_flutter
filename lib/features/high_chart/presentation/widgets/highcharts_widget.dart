import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart' as windows_webview;

/// Carga y cachea el código fuente de Highcharts (core + módulos) una sola
/// vez desde los assets, para inyectarlo inline en el HTML del WebView.
class HighchartsJsLoader {
  static String? _core;
  static String? _more;
  static String? _stock;
  static String? _funnel;
  static String? _heatmap;
  static String? _sankey;
  static String? _treemap;

  static Future<String> load() async {
    _core ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts.js',
    );
    _more ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts-more.js',
    );
    _stock ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts-stock.js',
    );
    _funnel ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts-funnel.js',
    );
    _heatmap ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts-heatmap.js',
    );
    _sankey ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts-sankey.js',
    );
    _treemap ??= await rootBundle.loadString(
      'lib/features/high_chart/presentation/Data/js/highcharts-treemap.js',
    );
    return '$_core\n$_more\n$_stock\n$_funnel\n$_heatmap\n$_sankey\n$_treemap';
  }
}

/// Permite ejecutar JavaScript adicional sobre un chart ya renderizado
/// (por ejemplo, para agregar puntos en vivo con addPoint), sin importar
/// si por debajo se está usando webview_flutter o webview_windows.
class HighchartsController {
  final WebViewController? _webController;
  final windows_webview.WebviewController? _windowsController;

  HighchartsController._(this._webController, this._windowsController);

  Future<void> runJs(String script) async {
    final windowsController = _windowsController;
    if (windowsController != null) {
      await windowsController.executeScript(script);
    } else {
      await _webController!.runJavaScript(script);
    }
  }
}

class HighchartsWidget extends StatefulWidget {
  final Map<String, dynamic> options;
  final double height;

  /// Se llama una vez que el chart terminó de renderizarse por primera
  /// vez, entregando un controller para poder ejecutar JS adicional
  /// (usado por ejemplo por el chart de tiempo real).
  final void Function(HighchartsController controller)? onReady;

  const HighchartsWidget({
    super.key,
    required this.options,
    this.height = 320,
    this.onReady,
  });

  @override
  State<HighchartsWidget> createState() => _HighchartsWidgetState();
}

class _HighchartsWidgetState extends State<HighchartsWidget> {
  bool get _isWindows => !kIsWeb && Platform.isWindows;

  // Android / iOS / macOS / Web
  WebViewController? _controller;

  // Windows
  windows_webview.WebviewController? _windowsController;

  bool _ready = false;
  Object? _initError;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final highchartsJs = await HighchartsJsLoader.load();
      final html = _buildHtml(widget.options, highchartsJs);

      if (_isWindows) {
        final controller = windows_webview.WebviewController();
        await controller.initialize();
        await controller.loadStringContent(html);
        _windowsController = controller;
      } else {
        final controller = WebViewController();
        // webview_flutter_web no implementa estos dos métodos: en un
        // <iframe> de navegador el JS siempre está activo y el fondo
        // se maneja distinto, así que solo se llaman fuera de web.
        if (!kIsWeb) {
          controller
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(Colors.transparent);
        }
        controller.loadHtmlString(html);
        _controller = controller;
      }

      if (!mounted) return;
      setState(() => _ready = true);

      widget.onReady?.call(HighchartsController._(_controller, _windowsController));
    } catch (e) {
      if (!mounted) return;
      setState(() => _initError = e);
    }
  }

  @override
  void didUpdateWidget(covariant HighchartsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      HighchartsJsLoader.load().then((highchartsJs) {
        final html = _buildHtml(widget.options, highchartsJs);
        if (_isWindows) {
          _windowsController?.loadStringContent(html);
        } else {
          _controller?.loadHtmlString(html);
        }
      });
    }
  }

  @override
  void dispose() {
    _windowsController?.dispose();
    super.dispose();
  }

  String _buildHtml(Map<String, dynamic> options, String highchartsJs) {
    final optionsJson = jsonEncode(options);
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background: transparent;
      overflow: hidden;
    }
    #container { width: 100%; height: 100%; }
  </style>
</head>
<body>
  <div id="container"></div>
  <script>
$highchartsJs
  </script>
  <script>
    // Por defecto Highcharts muestra fechas/horas en UTC. Esto lo cambia
    // para que use la hora local del dispositivo en todos los charts.
    Highcharts.setOptions({ time: { useUTC: false } });

    // Se guarda en window.chart para poder ejecutarle JS adicional
    // después (addPoint, update, etc.) desde Flutter.
    window.chart = Highcharts.chart('container', $optionsJson);
  </script>
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    if (_initError != null) {
      return SizedBox(
        height: widget.height,
        child: Center(child: Text('Error cargando Highcharts: $_initError')),
      );
    }

    if (!_ready) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_isWindows) {
      return SizedBox(
        height: widget.height,
        child: windows_webview.Webview(_windowsController!),
      );
    }

    return SizedBox(
      height: widget.height,
      child: WebViewWidget(controller: _controller!),
    );
  }
}