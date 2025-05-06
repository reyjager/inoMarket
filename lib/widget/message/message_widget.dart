import 'package:inomarket/themes/theme_service.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final MessageType type;
  final Widget? child;
  final String content;

  const MessageWidget({
    super.key,
    required this.content,
    this.child,
    this.type = MessageType.info,
  });

  IconData _getIcon() {
    switch (type) {
      case MessageType.info:
        return Icons.info;
      case MessageType.warning:
        return Icons.warning_rounded;
      case MessageType.danger:
        return Icons.dangerous;
    }
  }

  MaterialColor? _getColor() {
    switch (type) {
      case MessageType.info:
        return ThemeService.currentColorScheme.infoColor;
      case MessageType.warning:
        return ThemeService.currentColorScheme.warningColor;
      case MessageType.danger:
        return ThemeService.currentColorScheme.dangerColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getColor()?[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _getIcon(),
            color: _getColor(),
            size: 45,
          ),
          Expanded(
            child: child ??
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    content,
                    style: ThemeService.smallText,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

enum MessageType {
  info,
  warning,
  danger,
}
