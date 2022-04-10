import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final colorMap = <String, Color>{
        "primary": menuController.theme().colorScheme.primary,
        "onPrimary": menuController.theme().colorScheme.onPrimary,
        "primaryContainer": menuController.theme().colorScheme.primaryContainer,
        "onPrimaryContainer":
            menuController.theme().colorScheme.onPrimaryContainer,
        "secondary": menuController.theme().colorScheme.secondary,
        "onSecondary": menuController.theme().colorScheme.onSecondary,
        "secondaryContainer":
            menuController.theme().colorScheme.secondaryContainer,
        "onSecondaryContainer":
            menuController.theme().colorScheme.onSecondaryContainer,
        "tertiary": menuController.theme().colorScheme.tertiary,
        "onTertiary": menuController.theme().colorScheme.onTertiary,
        "tertiaryContainer":
            menuController.theme().colorScheme.tertiaryContainer,
        "onTertiaryContainer":
            menuController.theme().colorScheme.onTertiaryContainer,
        "error": menuController.theme().colorScheme.error,
        "errorContainer": menuController.theme().colorScheme.errorContainer,
        "onError": menuController.theme().colorScheme.onError,
        "onErrorContainer": menuController.theme().colorScheme.onErrorContainer,
        "background": menuController.theme().colorScheme.background,
        "onBackground": menuController.theme().colorScheme.onBackground,
        "surface": menuController.theme().colorScheme.surface,
        "onSurface": menuController.theme().colorScheme.onSurface,
        "surfaceVariant": menuController.theme().colorScheme.surfaceVariant,
        "onSurfaceVariant": menuController.theme().colorScheme.onSurfaceVariant,
        "onInverseSurface": menuController.theme().colorScheme.onInverseSurface,
        "inverseSurface": menuController.theme().colorScheme.inverseSurface,
        "outline": menuController.theme().colorScheme.outline,
        "inversePrimary": menuController.theme().colorScheme.inversePrimary,
        "shadow": menuController.theme().colorScheme.shadow,
      };
      return Center(
        child: Column(
          children: colorMap.entries
              .where((entry) => !entry.key.startsWith("on"))
              .map(
            (entry) {
              final onkey = "on${entry.key[0].toUpperCase()}"
                  "${entry.key.substring(1)}";
              return colorMap.containsKey(onkey)
                  ? Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 1),
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          color: entry.value,
                          child: Text(
                            onkey,
                            style: TextStyle(
                              color: colorMap[onkey],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(" <- ${entry.key}")
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 1),
                          padding: const EdgeInsets.all(10),
                          width: 200,
                          color: entry.value,
                          child: const Text(""),
                        ),
                        Text(" <- ${entry.key}")
                      ],
                    );
            },
          ).toList(),
        ),
      );
    });
  }
}
