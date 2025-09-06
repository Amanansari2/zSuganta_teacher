import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:z_tutor_suganta/utils/theme/provider/theme_provider.dart';
import 'package:z_tutor_suganta/widgets/containers/circular_container.dart';
import 'package:z_tutor_suganta/widgets/containers/curved_edges/curved_edges_widget.dart';

import '../../utils/constants/app_colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {

  final Widget child;

  const PrimaryHeaderContainer({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {

    final dark = context.watch<ThemeProvider>().isDarkMode;

    return CurvedEdgesWidget(
      child: Container(
        color: dark ? AppColors.blue : AppColors.orange,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
                top: -150,
                left: 250,
                child: CircularContainer(
                  backgroundColor: AppColors.white.withOpacity(0.2),
                )
            ),
            Positioned(
                top: 100,
                left: 300,
                child: CircularContainer(
                  backgroundColor: AppColors.white.withOpacity(0.1),
                )
            ),
            child,

          ],
        ),
      ),
    );
  }
}
