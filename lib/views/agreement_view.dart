import 'package:flutter/material.dart';


import '../widgets/custom_app_bar/custom_app_bar.dart';
import '../bodies/agreement_body/agreement_body.dart';


class AgreementView extends StatelessWidget {
  AgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: CustomAppBar(),
        ),
      body: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate(
                        [AgreementBody()])),
              ],
            ),
    );
  }
}