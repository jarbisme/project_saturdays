import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';
import 'package:project_saturdays/src/styles/colors.dart';

import '../bloc/home_bloc.dart';

class NoConnectionBanner extends StatefulWidget {
  const NoConnectionBanner({
    super.key,
  });

  @override
  State<NoConnectionBanner> createState() => _NoConnectionBannerState();
}

class _NoConnectionBannerState extends State<NoConnectionBanner> {
  late bool isShowing;
  late bool isSaturday;

  @override
  void initState() {
    super.initState();
    var state = BlocProvider.of<HomeBloc>(context).state;
    isShowing = state.sabbath!.source == Source.local;
    isSaturday = state.isSaturday;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        setState(() {
          if (state.sabbath != null) {
            isShowing = state.sabbath!.source == Source.local;
          }
          isSaturday = state.isSaturday;
        });
      },
      child: isShowing
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: isSaturday ? Colors.white.withOpacity(0.6) : const Color(0xFF8C96A0),
                          ),
                          children: [
                            const TextSpan(
                              text: 'It appears that there is not an internet connection. ',
                            ),
                            TextSpan(
                              text: 'Pull down to refresh',
                              style: TextStyle(color: isSaturday ? Colors.white : kPrimaryColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isShowing = false;
                          });
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
