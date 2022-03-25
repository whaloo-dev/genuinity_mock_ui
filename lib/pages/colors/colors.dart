import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorMap = <String, Color>{
      "primary": colorScheme.primary,
      "onPrimary": colorScheme.onPrimary,
      "primaryContainer": colorScheme.primaryContainer,
      "onPrimaryContainer": colorScheme.onPrimaryContainer,
      "secondary": colorScheme.secondary,
      "onSecondary": colorScheme.onSecondary,
      "secondaryContainer": colorScheme.secondaryContainer,
      "onSecondaryContainer": colorScheme.onSecondaryContainer,
      "tertiary": colorScheme.tertiary,
      "onTertiary": colorScheme.onTertiary,
      "tertiaryContainer": colorScheme.tertiaryContainer,
      "onTertiaryContainer": colorScheme.onTertiaryContainer,
      "error": colorScheme.error,
      "errorContainer": colorScheme.errorContainer,
      "onError": colorScheme.onError,
      "onErrorContainer": colorScheme.onErrorContainer,
      "background": colorScheme.background,
      "onBackground": colorScheme.onBackground,
      "surface": colorScheme.surface,
      "onSurface": colorScheme.onSurface,
      "surfaceVariant": colorScheme.surfaceVariant,
      "onSurfaceVariant": colorScheme.onSurfaceVariant,
      "onInverseSurface": colorScheme.onInverseSurface,
      "inverseSurface": colorScheme.inverseSurface,
      "outline": colorScheme.outline,
      "inversePrimary": colorScheme.inversePrimary,
      "shadow": colorScheme.shadow,
    };

    return Center(
      child: Column(
        children:
            colorMap.entries.where((entry) => !entry.key.startsWith("on")).map(
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
  }
}
