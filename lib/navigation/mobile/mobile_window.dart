import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiet/extension.dart';
import 'package:window_manager/window_manager.dart';

import '../../providers/navigator_provider.dart';
import '../common/navigator.dart';
import 'widgets/bottom_bar.dart';

class MobileWindow extends StatelessWidget {
  const MobileWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform.isDesktop()) {
      return const _MobileWindowOnDesktopWrapper(
        child: _MobileWindowLayout(),
      );
    }
    return const _MobileWindowLayout();
  }
}

class _MobileWindowLayout extends StatelessWidget {
  const _MobileWindowLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: const AnimatedAppBottomBar(
        child: AppNavigator(),
      ),
    );
  }
}

// show mobile window on desktop. (for debug)
class _MobileWindowOnDesktopWrapper extends HookConsumerWidget {
  const _MobileWindowOnDesktopWrapper({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useMemoized(() {
      WindowManager.instance.setMinimumSize(Size.zero);
      WindowManager.instance.setSize(const Size(375, 667 + 40), animate: true);
    });
    return Column(
      children: [
        Material(
          child: SizedBox(
            height: 40,
            child: Stack(
              children: [
                Row(
                  children: [
                    if (defaultTargetPlatform == TargetPlatform.macOS)
                      const SizedBox(width: 40),
                    BackButton(
                      onPressed: () {
                        ref.read(navigatorProvider.notifier).back();
                      },
                    ),
                  ],
                ),
                const Center(child: Text('mobile')),
              ],
            ),
          ),
        ),
        Expanded(child: AspectRatio(aspectRatio: 9 / 16, child: child)),
      ],
    );
  }
}
