import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A reusable in-app browser page used to display a remote URL.
///
/// The URL is passed via the router state extras when pushing the
/// route. A non-null URL must be supplied.
class WebViewPage extends StatefulWidget {
  /// Creates an instance of [WebViewPage].
  const WebViewPage({required this.url, super.key});

  /// The URL to load inside the WebView.
  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AboutConstants.pageBackground,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const _WebViewLoadingOverlay(),
        ],
      ),
    );
  }

  /// Builds the AppBar with a back button.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AboutConstants.pageBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppTheme.moodleDarkGrey,
          size: AppSize.iconMd.r,
        ),
        onPressed: () => Navigator.of(context).pop<void>(),
      ),
      title: Text(
        AppStrings.labelAbout,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: AppSize.fontLg.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// A semi-transparent overlay shown while the WebView is loading.
class _WebViewLoadingOverlay extends StatelessWidget {
  /// Creates an instance of [_WebViewLoadingOverlay].
  const _WebViewLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AboutConstants.pageBackground,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
