import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

enum ToastPosition { top, bottom }

enum ToastShape { pill, squared }

class Toast {
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

  Toast({
    required this.title,
    this.duration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutExpo,
    this.reverseCurve,
    this.subtitle,
    this.icon,
    this.isDestructive = false,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.position = ToastPosition.top,
    this.padding,
    this.shape = ToastShape.pill,
    this.iconColor,
    this.titleMaxLines = 1,
    this.subtitleMaxLines = 1,
  });

  void show(BuildContext context) {
    Toasts._enqueue(this, context);
  }
}

class Toasts {
  static final List<Toast> _toastsQueue = [];
  static bool _isShowingToast = false;

  static void _enqueue(Toast toast, BuildContext context) {
    _toastsQueue.add(toast);
    if (!_isShowingToast) {
      _showNextToast(context);
    }
  }

  static void showFromToast(BuildContext context, Toast toast) {
    _enqueue(toast, context);
  }

  static void show(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 3),
    Duration? transitionDuration = const Duration(milliseconds: 700),
    Curve curve = Curves.easeOutExpo,
    Curve? reverseCurve,
    String? subtitle,
    IconData? icon,
    bool isDestructive = false,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    ToastPosition position = ToastPosition.top,
    EdgeInsets? padding,
    ToastShape shape = ToastShape.pill,
    Color? iconColor,
    int titleMaxLines = 1,
    int subtitleMaxLines = 1,
  }) {
    final toast = Toast(
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
    );

    _enqueue(toast, context);
  }

  static void _showNextToast(BuildContext context) {
    if (_toastsQueue.isEmpty) {
      _isShowingToast = false;
      return;
    }

    _isShowingToast = true;
    final toast = _toastsQueue.removeAt(0);

    OverlayEntry? currentOverlay;
    currentOverlay = OverlayEntry(
      builder: (context) => _ToastWidget(
        title: toast.title,
        duration: toast.duration,
        transitionDuration: toast.transitionDuration,
        curve: toast.curve,
        reverseCurve: toast.reverseCurve,
        isDestructive: toast.isDestructive,
        subtitle: toast.subtitle,
        titleMaxLines: toast.titleMaxLines,
        subtitleMaxLines: toast.subtitleMaxLines,
        titleTextStyle: toast.titleTextStyle,
        subtitleTextStyle: toast.subtitleTextStyle,
        position: toast.position,
        padding: toast.padding,
        shape: toast.shape,
        iconColor: toast.iconColor,
        icon: toast.icon,
        onDismiss: () {
          currentOverlay?.remove();
          currentOverlay = null;
          _showNextToast(context);
        },
      ),
    );

    Overlay.of(context).insert(currentOverlay!);
  }
}

class _ToastWidget extends StatefulWidget {
  final String title;
  final Duration duration;
  final Duration? transitionDuration;
  final Curve curve;
  final Curve? reverseCurve;
  final VoidCallback onDismiss;
  final IconData? icon;
  final String? subtitle;
  final bool isDestructive;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final ToastPosition position;
  final EdgeInsets? padding;
  final ToastShape shape;
  final Color? iconColor;
  final int titleMaxLines;
  final int subtitleMaxLines;

  const _ToastWidget({
    required this.title,
    required this.duration,
    required this.onDismiss,
    required this.isDestructive,
    required this.curve,
    required this.shape,
    this.reverseCurve,
    this.icon,
    this.subtitle,
    this.transitionDuration,
    this.titleTextStyle,
    this.subtitleTextStyle,
    required this.position,
    this.padding,
    this.iconColor,
    required this.titleMaxLines,
    required this.subtitleMaxLines,
  });

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
    _animationController = AnimationController(duration: widget.transitionDuration, vsync: this);

    _offsetAnimation = Tween<Offset>(begin: Offset(0, widget.position == ToastPosition.top ? -1 : 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.curve,
            reverseCurve: widget.reverseCurve ?? widget.curve.flipped,
          ),
        );

    _animationController.forward();

    Future.delayed(widget.duration, () {
      if (mounted) _dismissAlert();
    });

    _scrollController.addListener(() {
      if (_scrollController.offset > 30 && widget.position == ToastPosition.top) {
        _dismissAlert();
      }

      if (_scrollController.offset < -30 && widget.position == ToastPosition.bottom) {
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
    final double baseVerticalPadding = widget.subtitle != null ? 9 : 15;

    if (widget.subtitle == null && widget.icon == null) {
      return EdgeInsets.symmetric(vertical: baseVerticalPadding + 3, horizontal: baseHorizontalPadding + 20);
    }
    if (widget.icon == null && widget.subtitle != null) {
      return EdgeInsets.symmetric(horizontal: baseHorizontalPadding + 20, vertical: baseVerticalPadding);
    }
    if (widget.icon != null && widget.subtitle != null) {
      return EdgeInsets.symmetric(horizontal: baseHorizontalPadding, vertical: baseVerticalPadding);
    }
    if (widget.icon != null && widget.subtitle == null) {
      return EdgeInsets.symmetric(horizontal: baseVerticalPadding, vertical: baseVerticalPadding);
    }

    return const EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context) {
    final double iconSize = widget.icon != null ? 24.0 : 0;

    return Positioned(
      left: 0,
      top: widget.position == ToastPosition.top ? 0 : null,
      bottom: widget.position == ToastPosition.bottom ? MediaQuery.of(context).viewPadding.bottom : null,
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
                clipBehavior: widget.shape == ToastShape.squared ? Clip.none : Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: widget.shape == ToastShape.squared
                      ? const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Corners.md)))
                      : const StadiumBorder(),
                  shadows: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 4)),
                  ],
                ),
                child: Material(
                  color: context.theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: widget.padding ?? getPadding(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null)
                          Icon(
                            widget.icon,
                            color:
                                widget.iconColor ??
                                (widget.isDestructive ? context.colors.error : context.colors.primary),
                            size: iconSize,
                          ),
                        if (widget.icon != null) const Gap(Insets.sm),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.title,
                                maxLines: widget.titleMaxLines,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    widget.titleTextStyle ??
                                    context.text.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.colors.onSurfaceVariant,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              if (widget.subtitle != null) ...[
                                const Gap(Insets.xs),
                                Text(
                                  widget.subtitle!,
                                  maxLines: widget.subtitleMaxLines,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      widget.subtitleTextStyle ??
                                      context.text.labelMedium?.copyWith(
                                        color: context.colors.onSurfaceVariant.withOpacity(0.8),
                                      ),
                                  textAlign: TextAlign.center,
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
