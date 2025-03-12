import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../constants/app_dimensions.dart";
import "../../extensions/context_extensions.dart";
import "../../navigation/app_router.dart";
import "../../widgets/footer.dart";
import "../../widgets/logo.dart";
import "../email/data/email_local_repository.dart";
import "../study_in_progress/presentation/study_in_pogrogress_section.dart";

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.microtask(EmailLocalRepository.getEnrolledEmail),
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: const Footer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingBig,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: AppDimensions.heightHuge),
                  child: Logo(),
                ),
                EnrolledEmailConsumer(
                  snapshot: snapshot,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EnrolledEmailConsumer extends StatelessWidget {
  const EnrolledEmailConsumer({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<String?> snapshot;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              final isLogged = snapshot.hasData;
              if (!isLogged) {
                return StudyInPogrogressSection(
                  onPressed: () {
                    unawaited(context.router.push(EmailRoute()));
                  },
                );
              } else {
                return const RedirectWidget(FirstFormRoute());
              }
            }
            return Text(
              "Wystąpił błąd: ${snapshot.error}",
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.error,
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class RedirectWidget extends HookWidget {
  const RedirectWidget(this.route, {super.key});
  final PageRouteInfo<void> route;
  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        Future.microtask(() async {
          if (!context.mounted) return;
          await context.router.replaceAll([route]);
        });
        return null;
      },
      [],
    );
    return const CircularProgressIndicator();
  }
}
