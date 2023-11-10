import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/utils/widgets/spaces.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_bloc.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_state.dart';

import '../bloc/family_screen_event.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  bool? createFamilyIsSelected;
  late TextEditingController familyCodeController;

  @override
  void initState() {
    familyCodeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyBloc, FamilyScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Family'),
            ),
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              createFamilyIsSelected = true;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            color: createFamilyIsSelected == true
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            child: const Center(
                              child: Text('Create Family'),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              createFamilyIsSelected = false;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            color: createFamilyIsSelected == false
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            child: const Center(
                              child: Text('Join Family'),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spaces.VERTICAL_XL,
                    if (createFamilyIsSelected == false)
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Family Code',
                        ),
                      ),
                    Spaces.VERTICAL_XL,
                    ElevatedButton(
                      onPressed: createFamilyIsSelected != null
                          ? onGoButtonTapped
                          : null,
                      child: const Text('Go'),
                    ),
                  ],
                ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        });
  }

  void onGoButtonTapped() {
    if (createFamilyIsSelected!) {
      BlocProvider.of<FamilyBloc>(context).add(
        FamilyScreenCreateFamilyEvent(context.read<AuthBloc>().user!.userID),
      );
    } else {
      BlocProvider.of<FamilyBloc>(context).add(
        FamilyScreenJoinFamilyEvent(
          context.read<AuthBloc>().user!.userID,
          familyCodeController.text,
        ),
      );
    }
  }
}
