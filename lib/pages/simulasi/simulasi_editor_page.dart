import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/router/app_routes.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/theme/app_spacing.dart';
import 'package:voltar/theme/app_typography.dart';
import 'package:voltar/widgets/app_icon.dart';
import 'package:voltar/widgets/volt_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Halaman full-screen WebView untuk membuka Simulator Sirkuit Velxio.
///
/// Route ini berada di atas AppShell (`parentNavigatorKey` root), jadi
/// VoltFloatingNavBar tidak tampil dan halaman wajib menyediakan tombol
/// kembali sendiri.
class SimulasiEditorPage extends StatefulWidget {
  const SimulasiEditorPage({
    super.key,
    this.projectName = 'Simulator Velxio',
    this.isTemplate = false,
    this.initialUrl,
  });

  static const String defaultUrl = 'https://velxio.dev';
  static const String velxioUrl =
      'https://velxio.dev/project/0ccf9202-1d4b-4a26-b9d8-ea8d1a100c91';

  final String projectName;
  final bool isTemplate;
  final String? initialUrl;

  @override
  State<SimulasiEditorPage> createState() => _SimulasiEditorPageState();
}

class _SimulasiEditorPageState extends State<SimulasiEditorPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _errorMessage;

  String get _targetUrl {
    final String? url = widget.initialUrl?.trim();
    if (url != null && url.isNotEmpty) {
      return url;
    }
    return SimulasiEditorPage.defaultUrl;
  }

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    if (WebViewPlatform.instance == null) {
      // ponytail: di lingkungan flutter test tanpa platform WebView native, tetap tampilkan loading tanpa crash
      return;
    }

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _errorMessage = null;
            });
          },
          onPageFinished: (String url) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            if (error.isForMainFrame == false) return;
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _errorMessage =
                  'Gagal memuat simulator Velxio (${error.description}). Periksa koneksi internet Anda.';
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_targetUrl));

    _controller = controller;
  }

  void _reload() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    if (_controller != null) {
      _controller!.loadRequest(Uri.parse(_targetUrl));
    } else {
      _initWebView();
    }
  }

  void _close() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(AppRoutes.simulasi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const AppIcon.arrowLeft(color: AppColors.textPrimary),
          onPressed: _close,
        ),
        title: const Text(
          'Simulator Velxio',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: TextButton(
              onPressed: _reload,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryDark,
                textStyle: AppTypography.label,
              ),
              child: const Text('Muat Ulang'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (_controller != null && _errorMessage == null)
              WebViewWidget(
                key: const Key('velxio_webview'),
                controller: _controller!,
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.pagePadding),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.wifi_off_rounded,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Text(
                        'Koneksi Terputus',
                        style: AppTypography.title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _errorMessage!,
                        style: AppTypography.bodyMuted,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      VoltButton(
                        label: 'Coba Lagi',
                        onPressed: _reload,
                      ),
                    ],
                  ),
                ),
              ),
            if (_isLoading)
              const ColoredBox(
                color: AppColors.background,
                child: Center(
                  child: CircularProgressIndicator(
                    key: Key('velxio_loading_indicator'),
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }



}
