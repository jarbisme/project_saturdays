import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_saturdays/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:project_saturdays/src/styles/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DayTitle extends StatelessWidget {
  const DayTitle({
    Key? key,
  }) : super(key: key);

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final month = capitalize(DateFormat.MMM(Localizations.localeOf(context).languageCode)
            .format(state.sabbath!.endDateTime.toLocal())
            .replaceAll(".", ""));

        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Opacity(
                    opacity: 0,
                    child: Text(month, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(state.sabbath!.endDateTime.toLocal().day.toString(),
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  ),
                  Text(month,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: state.isSaturday ? Colors.white : kPrimaryColor)),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.titleWidget,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1),
              ),
            ],
          ),
        );
      },
    );
  }
}
