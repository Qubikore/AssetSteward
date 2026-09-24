import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/widgets.dart';

abstract class ContextMenuItem {
  const ContextMenuItem();
}

class ContextMenuAction extends ContextMenuItem {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isDestructive;
  final VoidCallback? onTap;
  final bool autoClose;

  const ContextMenuAction({
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.isDestructive = false,
    this.onTap,
    this.autoClose = true,
  });
}

class ContextMenuGroup extends ContextMenuItem {
  final String? title;
  final List<ContextMenuItem> items;

  const ContextMenuGroup({this.title, required this.items});
}

class ContextMenuToggle extends ContextMenuItem {
  final String title;
  final Widget? leading;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ContextMenuToggle({required this.title, required this.value, required this.onChanged, this.leading});
}

class ContextMenuRadio<T> extends ContextMenuItem {
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const ContextMenuRadio({required this.title, required this.value, required this.groupValue, required this.onChanged});
}

class ContextMenuSubmenu extends ContextMenuItem {
  final String title;
  final Widget? leading;
  final List<ContextMenuItem> items;

  const ContextMenuSubmenu({required this.title, required this.items, this.leading});
}

class ContextMenuDivider extends ContextMenuItem {
  const ContextMenuDivider();
}


enum ContextMenuAlignment { start, center, end }
enum ContextMenuPosition { top, bottom, auto }

class ContextMenu extends StatefulWidget {
  final Widget Function(BuildContext context, VoidCallback open)? buttonBuilder;
  final Widget? child;
  final List<ContextMenuItem> items;
  final double width;
  final bool isSubmenu;
  final ContextMenuAlignment alignment;
  final ContextMenuPosition position;

  const ContextMenu({
    super.key,
    this.buttonBuilder,
    this.child,
    required this.items,
    this.width = 240.0,
    this.isSubmenu = false,
    this.alignment = ContextMenuAlignment.start,
    this.position = ContextMenuPosition.auto,
  });

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  void _toggle() {
    _isOpen ? _close() : _open();
  }

  void _open() {
    final RenderBox renderBox = _triggerKey.currentContext!.findRenderObject() as RenderBox;
    final Size triggerSize = renderBox.size;
    final Offset triggerPos = renderBox.localToGlobal(Offset.zero);
    final Size screenSize = MediaQuery.of(context).size;

    bool openUpward = false;
    if (!widget.isSubmenu) {
      final double spaceBelow = screenSize.height - triggerPos.dy - triggerSize.height;
      if (widget.position == ContextMenuPosition.top) {
        openUpward = true;
      } else if (widget.position == ContextMenuPosition.bottom) {
        openUpward = false;
      } else {
        openUpward = spaceBelow < 300;
      }
    }

    final Alignment targetAnchor = widget.isSubmenu
        ? Alignment.topLeft
        : (openUpward ? Alignment.topLeft : Alignment.bottomLeft);

    final Alignment followerAnchor = widget.isSubmenu
        ? Alignment.topLeft
        : (openUpward ? Alignment.bottomLeft : Alignment.topLeft);

    final Offset offset = _calculateOffset(
      triggerSize: triggerSize,
      triggerPos: triggerPos,
      screenSize: screenSize,
      menuWidth: widget.width,
      openUpward: openUpward,
    );

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return DefaultTextStyle(
          style: context.text.bodyMedium!,
          child: Stack(
            children: [
              Positioned.fill(
                child: widget.isSubmenu
                    ? Listener(behavior: HitTestBehavior.translucent, onPointerDown: (_) => _close())
                    : GestureDetector(onTap: _close, behavior: HitTestBehavior.translucent),
              ),
              Positioned(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  targetAnchor: targetAnchor,
                  followerAnchor: followerAnchor,
                  offset: offset,
                  child: _ContextMenuPanel(width: widget.width, items: widget.items, onClose: _close),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  Offset _calculateOffset({
    required Size triggerSize,
    required Offset triggerPos,
    required Size screenSize,
    required double menuWidth,
    required bool openUpward,
  }) {
    if (widget.isSubmenu) {
      double dx = triggerSize.width + 8;
      if (triggerPos.dx + triggerSize.width + menuWidth + 8 > screenSize.width - 8) {
        dx = -menuWidth - 8;
      }
      final double spaceBelow = screenSize.height - triggerPos.dy;
      double dy = 0;
      final double estimatedHeight = widget.items.length * 40.0 + 16.0;
      if (spaceBelow < estimatedHeight + 8) {
        dy = -(estimatedHeight - triggerSize.height);
      }
      return Offset(dx, dy);
    }

    double dx = 0;
    switch (widget.alignment) {
      case ContextMenuAlignment.start:
        dx = 0;
        break;
      case ContextMenuAlignment.center:
        dx = (triggerSize.width - menuWidth) / 2;
        break;
      case ContextMenuAlignment.end:
        dx = triggerSize.width - menuWidth;
        break;
    }

    final double globalX = triggerPos.dx + dx;
    if (globalX + menuWidth > screenSize.width - 8) {
      dx -= (globalX + menuWidth - (screenSize.width - 8));
    }
    if (globalX < 8) {
      dx += (8 - globalX);
    }

    return Offset(dx, openUpward ? -4 : 4);
  }

  void _close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _triggerKey,
        onTap: widget.buttonBuilder != null ? null : _toggle,
        behavior: HitTestBehavior.translucent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child:
              widget.buttonBuilder?.call(context, _open) ??
              widget.child ??
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.outline, strokeAlign: BorderSide.strokeAlignOutside),
                  shape: BoxShape.circle,
                ),
                child: const Icon(HIStroke.moreVertical, size: 20),
              ),
        ),
      ),
    );
  }
}

class _ContextMenuPanel extends StatelessWidget {
  final double width;

  final List<ContextMenuItem> items;
  final VoidCallback onClose;

  const _ContextMenuPanel({required this.width, required this.items, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outlineVariant),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(color: const Color(0xFF000000).withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildItems(context, items),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context, List<ContextMenuItem> items) {
    final List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      widgets.add(_buildItem(context, item));
    }
    return widgets;
  }

  Widget _buildItem(BuildContext context, ContextMenuItem item) {
    if (item is ContextMenuDivider) {
      return Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 4), color: context.colors.outline);
    }

    if (item is ContextMenuGroup) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                item.title!.toUpperCase(),
                style: context.text.labelSmall!.copyWith(
                  color: context.colors.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ..._buildItems(context, item.items),
        ],
      );
    }

    if (item is ContextMenuSubmenu) {
      return ContextMenu(
        items: item.items,
        isSubmenu: true,
        buttonBuilder: (context, open) => _HoverableMenuItem(
          onTap: open,
          child: Row(
            children: [
              if (item.leading != null) ...[
                IconTheme.merge(
                  data: IconThemeData(size: 18, color: context.colors.onSurface),
                  child: item.leading!,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(item.title, style: context.text.bodyMedium!.copyWith(color: context.colors.onSurface)),
              ),
              const SizedBox(width: 12),
              const Icon(HIStroke.arrowRight01, size: 16),
            ],
          ),
        ),
      );
    }

    if (item is ContextMenuAction) {
      return _HoverableMenuItem(
        onTap: () {
          item.onTap?.call();
          if (item.autoClose) onClose();
        },
        child: Row(
          children: [
            if (item.leading != null) ...[
              IconTheme.merge(
                data: IconThemeData(
                  size: 18,
                  color: item.isDestructive ? context.colors.error : context.colors.onSurface,
                ),
                child: item.leading!,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: context.text.bodyMedium!.copyWith(
                      color: item.isDestructive ? context.colors.error : context.colors.onSurface,
                    ),
                  ),
                  if (item.subtitle != null)
                    Text(
                      item.subtitle!,
                      style: context.text.labelSmall!.copyWith(color: context.colors.onSurfaceVariant),
                    ),
                ],
              ),
            ),
            if (item.trailing != null) ...[const SizedBox(width: 12), item.trailing!],
          ],
        ),
      );
    }

    if (item is ContextMenuToggle) {
      return _HoverableMenuItem(
        onTap: () {
          item.onChanged(!item.value);
        },
        child: Row(
          spacing: 12,
          children: [
            Icon(
              item.value ? HIStroke.checkmarkCircle02 : HIStroke.checkmarkCircle02,
              size: 18,
              color: item.value ? context.colors.primary : context.colors.onSurface,
            ),

            Expanded(child: Text(item.title, style: context.text.bodyMedium)),

            Text(
              item.value ? 'ON' : 'OFF',
              style: context.text.labelSmall!.copyWith(
                color: item.value ? context.colors.primary : context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    if (item is ContextMenuRadio) {
      final bool selected = item.value == item.groupValue;
      return _HoverableMenuItem(
        onTap: () {
          item.onChanged(item.value);
        },
        child: Row(
          children: [
            Expanded(child: Text(item.title, style: context.text.bodyMedium)),
            const SizedBox(width: 12),
            Icon(selected ? HIStroke.tick02 : null, size: 18, color: context.colors.primary),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}

class _HoverableMenuItem extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _HoverableMenuItem({required this.child, this.onTap});

  @override
  State<_HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<_HoverableMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: _isHovered ? context.colors.primary.withValues(alpha: 0.1) : null),
          child: widget.child,
        ),
      ),
    );
  }
}
