import 'package:flutter/material.dart';

mixin Utils {
  Future<dynamic> push(
    BuildContext context,
    Widget route, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) async {
    return Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => route,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      ),
    );
  }

  void pushName(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  bool isPortrait(context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait;
  }

  AppBar getAppBar({
    required BuildContext context,
    String? title,
    bool centerTitle = true,
    double elevation = 0,
    Color? bgColor,
    Color titleColor = Colors.grey,
    PreferredSizeWidget? widget,
    List<Widget>? actions,
    String? logoUrl,
    int? unreadCount,
    bool hasSearch = false,
    bool hasClose = false,
    bool hasProfile = false,
    Widget? leading,
    VoidCallback? pressBack,
    dynamic popValue,
    void Function()? actionSearch,
    void Function()? actionProfile,
    void Function()? actionNotify,
  }) {
    final _title = title != null ? Text(title) : null;
    final _actions = <Widget>[];

    if (hasClose) {
      _actions.add(_closeBtn(context, popValue));
    }

    return AppBar(
      elevation: elevation,
      backgroundColor: bgColor,
      title: _title,
      centerTitle: centerTitle,
      leading: _leading(context, leading, logoUrl, pressBack, popValue),
      actions: actions ?? _actions,
      bottom: widget,
    );
  }

  static Widget? _leading(
    BuildContext context,
    Widget? leading,
    String? logoUrl,
    VoidCallback? pressBack,
    dynamic popValue,
  ) {
    Widget? _leading;

    if (logoUrl != null) {
      _leading = _logo(logoUrl);
    } else {
      _leading = leading ??
          (pressBack != null ? _backBtn(context, pressBack, popValue) : null);
    }

    return _leading;
  }

  static Widget _logo(String url) {
    return Center(
      child: Container(
        width: 56,
        height: 22,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            // use CachedNetworkImageProvider if need cache image
            image: NetworkImage(
              url,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _backBtn(
      BuildContext context, VoidCallback? pressBack, dynamic popValue) {
    return InkWell(
      onTap: pressBack ??
          () {
            Navigator.of(context).pop(popValue);
          },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  static Widget _closeBtn(BuildContext context, dynamic popValue) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(popValue),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: const Icon(Icons.close, size: 20),
      ),
    );
  }
}
