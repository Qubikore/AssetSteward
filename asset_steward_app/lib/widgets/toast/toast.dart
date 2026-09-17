import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

enum ToastPosition { top, bottom }

enum ToastShape { pill, squared }

/// A wrapper to provide a global context for toasts.
/// Use this inside the [builder] property of your MaterialApp.
/// Example: `builder: (context, child) => ToastWrapper(child: child!)`
class ToastWrapper extends StatefulWidget {
  final Widget child;
  const ToastWrapper({super.key, required this.child});

  @override
  State<ToastWrapper> createState() => _ToastWrapperState();
}

class _ToastWrapperState extends State<ToastWrapper> {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (ctx) {
            Toast._globalContext = ctx;
            return widget.child;
          },
        ),
      ],
    );
  }
}

class Toast {
  static BuildContext? _globalContext;
  static final List<_ToastData> _toastsQueue = [];
  static bool _isShowingToast = false;

  const Toast._();

  static void _enqueue(_ToastData toast, BuildContext? context) {
    _toastsQueue.add(toast);
    if (!_isShowingToast) {
      _showNextToast(context);
    }
  }

  static void show(
    String title, {
    BuildContext? context,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    Duration? transitionDuration = const Duration(milliseconds: 700),
    Curve curve = Curves.easeOutExpo,
    Curve? reverseCurve,
    IconData? icon,
    bool isDestructive = false,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    ToastPosition position = ToastPosition.top,
    EdgeInsets? padding,
    ToastShape shape = ToastShape.pill,
    Color? iconColor,
    int titleMaxLines = 1,
    int subtitleMaxLines = 2,
  }) {
    _enqueue(
      _ToastData(
        title: title,
        duration: duration,
        transitionDuration: transitionDuration,
        curve: curve,
        reverseCurve: reverseCurve,
        subtitle: subtitle,
        icon: icon,
        isDestructive: isDestructive,
        titleTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        position: position,
        padding: padding,
        shape: shape,
        iconColor: iconColor,
        titleMaxLines: titleMaxLines,
        subtitleMaxLines: subtitleMaxLines,
      ),
      context,
    );
  }

  static void showSuccess(String message, {BuildContext? context, String? title, IconData? icon}) {
    show(
      title ?? 'Success',
      subtitle: message,
      context: context,
      icon: icon ?? Icons.check_circle_outline,
      iconColor: const Color(0xFF4CAF50),
    );
  }

  static void showError(String message, {BuildContext? context, String? title, IconData? icon}) {
    show(
      title ?? 'Error',
      subtitle: message,
      context: context,
      icon: icon ?? Icons.error_outline,
      isDestructive: true,
      iconColor: const Color(0xFFF44336),
    );
  }

  static void showWarning(String message, {BuildContext? context, String? title, IconData? icon}) {
    show(
      title ?? 'Warning',
      subtitle: message,
      context: context,
      icon: icon ?? Icons.warning_amber_outlined,
      iconColor: const Color(0xFFFF9800),
    );
  }

  static void showInfo(String message, {BuildContext? context, String? title, IconData? icon}) {
    show(
      title ?? 'Info',
      subtitle: message,
      context: context,
      icon: icon ?? Icons.info_outline,
      iconColor: const Color(0xFF2196F3),
    );
  }

  static void _showNextToast(BuildContext? context) {
    if (_toastsQueue.isEmpty) {
      _isShowingToast = false;
      return;
    }

    final effectiveContext = context ?? _globalContext;
    if (effectiveContext == null) {
      Chirp.warning('Toast: No context available to show toast. Ensure ToastWrapper is added.');
      _toastsQueue.clear();
      return;
    }

    _isShowingToast = true;
    final toast = _toastsQueue.removeAt(0);

    OverlayEntry? currentOverlay;
    currentOverlay = OverlayEntry(
      builder: (ctx) => _ToastWidget(
        data: toast,
        onDismiss: () {
          currentOverlay?.remove();
          currentOverlay = null;
          _showNextToast(context);
        },
      ),
    );

    Overlay.of(effectiveContext).insert(currentOverlay!);
  }
}

class _ToastData {
  final String title;
  final Duration duration;
  final Duration? transitionDuration;
  final Curve curve;
  final Curve? reverseCurve;
  final String? subtitle;
  final IconData? icon;
  final bool isDestructive;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final ToastPosition position;
  final EdgeInsets? padding;
  final ToastShape shape;
  final Color? iconColor;
  final int titleMaxLines;
  final int subtitleMaxLines;

  _ToastData({
    required this.title,
    required this.duration,
    this.transitionDuration,
    required this.curve,
    this.reverseCurve,
    this.subtitle,
    this.icon,
    required this.isDestructive,
    this.titleTextStyle,
    this.subtitleTextStyle,
    required this.position,
    this.padding,
    required this.shape,
    this.iconColor,
    required this.titleMaxLines,
    required this.subtitleMaxLines,
  });
}

class _ToastWidget extends StatefulWidget {
  final _ToastData data;
  final VoidCallback onDismiss;

  const _ToastWidget({required this.data, required this.onDismiss});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.data.transitionDuration, vsync: this);

    _offsetAnimation =
        Tween<Offset>(begin: Offset(0, widget.data.position == ToastPosition.top ? -1 : 1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.data.curve,
            reverseCurve: widget.data.reverseCurve ?? widget.data.curve.flipped,
          ),
        );

    _animationController.forward();

    Future.delayed(widget.data.duration, () {
      if (mounted) _dismissAlert();
    });

    _scrollController.addListener(() {
      if (_scrollController.offset > 30 && widget.data.position == ToastPosition.top) {
        _dismissAlert();
      }

      if (_scrollController.offset < -30 && widget.data.position == ToastPosition.bottom) {
        _dismissAlert();
      }
    });
  }

  void _dismissAlert() {
    _animationController.reverse().then((_) {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  EdgeInsets getPadding() {
    const double baseHorizontalPadding = 20;
    final double baseVerticalPadding = widget.data.subtitle != null ? 9 : 15;

    if (widget.data.subtitle == null && widget.data.icon == null) {
      return EdgeInsets.symmetric(vertical: baseVerticalPadding + 3, horizontal: baseHorizontalPadding + 20);
    }
    if (widget.data.icon == null && widget.data.subtitle != null) {
      return EdgeInsets.symmetric(horizontal: baseHorizontalPadding + 20, vertical: baseVerticalPadding);
    }
    if (widget.data.icon != null && widget.data.subtitle != null) {
      return EdgeInsets.symmetric(horizontal: baseHorizontalPadding, vertical: baseVerticalPadding);
    }
    if (widget.data.icon != null && widget.data.subtitle == null) {
      return EdgeInsets.symmetric(horizontal: baseVerticalPadding, vertical: baseVerticalPadding);
    }

    return const EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = widget.data.icon != null ? 24.0 : 0;

    return Positioned(
      left: 0,
      top: widget.data.position == ToastPosition.top ? 3 : null,
      bottom: widget.data.position == ToastPosition.bottom ? MediaQuery.of(context).viewPadding.bottom : null,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          controller: _scrollController,
          hitTestBehavior: HitTestBehavior.deferToChild,
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: widget.data.shape == ToastShape.squared ? Clip.none : Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: widget.data.shape == ToastShape.squared
                      ? const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Corners.md)))
                      : const StadiumBorder(),
                  shadows: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 4)),
                  ],
                ),
                child: Material(
                  color: context.theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: widget.data.padding ?? getPadding(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.data.icon != null)
                          Icon(
                            widget.data.icon,
                            color:
                                widget.data.iconColor ??
                                (widget.data.isDestructive ? context.colors.error : context.colors.primary),
                            size: iconSize,
                          ),
                        if (widget.data.icon != null) const Gap(Insets.sm),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.title,
                                maxLines: widget.data.titleMaxLines,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    widget.data.titleTextStyle ??
                                    context.text.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.colors.onSurfaceVariant,
                                    ),
                              ),
                              if (widget.data.subtitle != null) ...[
                                const Gap(Insets.xs),
                                Text(
                                  widget.data.subtitle!,
                                  maxLines: widget.data.subtitleMaxLines,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      widget.data.subtitleTextStyle ??
                                      context.text.labelMedium?.copyWith(
                                        color: context.colors.onSurfaceVariant.withValues(alpha: 0.8),
                                      ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
