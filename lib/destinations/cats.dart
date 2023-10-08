import 'package:flutter/cupertino.dart';

class NewsCats extends StatefulWidget {
  const NewsCats({super.key});

  @override
  State<NewsCats> createState() => _NewsCatsState();
}

class _NewsCatsState extends State<NewsCats> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [];
        },
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      color: CupertinoColors.activeBlue,
                    );
                  }),
            )
          ],
        ));
  }
}
