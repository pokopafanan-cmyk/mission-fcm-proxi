// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import '../../../../app/router/route_path.dart';
// // import '../../../theme/app_color.dart';
// // import 'app_text.dart';
// //
// // // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
// // //
// // //   const CustomAppBar({
// // //     super.key,
// // //     this.leading,
// // //     this.title,
// // //   });
// // //
// // //   final Widget? leading;
// // //   final String? title;
// // //
// // //   bool _canShowBackButton(BuildContext context) {
// // //     return context.canPop() && leading == null;
// // //   }
// // //
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AppBar(
// // //       backgroundColor: Colors.transparent,
// // //       leading: _canShowBackButton(context) ?
// // //       IconButton(
// // //         icon: Icon(
// // //           Icons.arrow_back_ios,
// // //           color: const Color(0xFF0973B6),
// // //         //  color: Colors.red,
// // //           size: 20,
// // //         ),
// // //         onPressed: context.pop,
// // //       ) : leading,
// // //       title: title != null ?
// // //       AppText(
// // //         text: title!,
// // //         color: Colors.black,
// // //         fontSize: 16,
// // //         fontWeight: FontWeight.w400,
// // //       ) : null,
// // //       centerTitle: true,
// // //       actions: context.canPop() ? [
// // //         CloseButton(
// // //           onPressed: () => context.goNamed(RoutePath.home.name),
// // //         ),
// // //       ] : null,
// // //     );
// // //   }
// // //
// // //   @override
// // //   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// // // }
// // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
// //   const CustomAppBar({
// //     super.key,
// //     this.leading,
// //     this.title,
// //   });
// //
// //   final Widget? leading;
// //   final String? title;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // 1. On vérifie si on peut faire un retour
// //     final bool canPop = context.canPop();
// //
// //     return AppBar(
// //       backgroundColor: Colors.transparent,
// //       elevation: 0,
// //       centerTitle: true,
// //       // LOGIQUE :
// //       // Si on peut faire retour -> on affiche la flèche (Priorité auto)
// //       // Sinon -> on affiche le leading passé (ou rien si null)
// //       leading: canPop
// //           ? IconButton(
// //         icon: const Icon(
// //           Icons.arrow_back_ios,
// //           color: Color(0xFF0973B6),
// //           size: 20,
// //         ),
// //         onPressed: () => context.pop(),
// //       )
// //           : leading,
// //       title: title != null
// //           ? AppText(
// //         text: title!,
// //         color: Colors.black,
// //         fontSize: 16,
// //         fontWeight: FontWeight.w400,
// //       )
// //           : null,
// //       actions: canPop ? [
// //         CloseButton(
// //           onPressed: () => context.goNamed(RoutePath.home.name),
// //         ),
// //       ] : null,
// //     );
// //   }
// //
// //   @override
// //   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// // }
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../app/router/route_path.dart';
// import 'app_text.dart'; // Import de ton widget de texte
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     this.showCloseBtn = false,
//     this.leading,
//     this.title, // Changé en String? pour utiliser AppText à l'intérieur
//     this.toolbarHeight = 60,
//     this.actions,
//   });
//
//   final bool showCloseBtn;
//   final Widget? leading;
//   final String? title; // Utilisation d'un String pour la cohérence
//   final double toolbarHeight;
//   final List<Widget>? actions;
//
//   // Logique pour décider d'afficher le bouton retour bleu
//   bool _canShowBackButton(BuildContext context) {
//     return context.canPop() && leading == null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white, // Ou Colors.transparent selon ton besoin
//       elevation: 3,
//       shadowColor: Colors.grey.withValues(alpha: 0.2),
//       toolbarHeight: toolbarHeight,
//       centerTitle: true,
//
//       // Gestion intelligente du leading (bouton bleu ios si possible)
//       leading: _canShowBackButton(context)
//           ? IconButton(
//         icon: const Icon(
//           Icons.arrow_back_ios,
//           color: Color(0xFF0973B6), // Ta couleur bleue
//           size: 20,
//         ),
//         onPressed: () => context.pop(),
//       )
//           : leading,
//
//       // Utilisation systématique de AppText pour le titre
//       title: title != null
//           ? AppText(
//         text: title!,
//         color: Colors.black,
//         fontSize: 16,
//         fontWeight: FontWeight.w400,
//       )
//           : null,
//
//       actions: [
//         if (actions != null) ...actions!,
//
//         // Bouton de fermeture qui redirige vers la Home avec GoRouter
//         if (showCloseBtn || context.canPop())
//           CloseButton(
//             onPressed: () => context.goNamed(RoutePath.home.name),
//           ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(toolbarHeight);
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import 'app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.showCloseBtn = false,
    this.leading,
    this.title,
    this.toolbarHeight = 60,
    this.actions,
  });

  final bool showCloseBtn;
  final Widget? leading;
  final String? title;
  final double toolbarHeight;
  final List<Widget>? actions;

  bool _canShowBackButton(BuildContext context) {
    return GoRouter.of(context).canPop() && leading == null;
  }

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      shadowColor: Colors.grey.withValues(alpha: 0.2),
      toolbarHeight: toolbarHeight,
      centerTitle: true,

      // 🔵 Leading automatique ou custom
      leading: _canShowBackButton(context)
          ? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF0973B6),
          size: 20,
        ),
        onPressed: () => context.pop(),
      )
          : leading,

      // 📝 Titre
      title: title != null
          ? AppText(
        text: title!,
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      )
          : null,

      // ❌ Close uniquement quand nécessaire
      actions: [
        if (actions != null) ...actions!,

        if (showCloseBtn && !canPop)
          CloseButton(
            onPressed: () => context.goNamed(RoutePath.home.name),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
