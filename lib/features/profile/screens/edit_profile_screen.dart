import 'package:amplify_recipe/shared/constants/constants.dart';
import 'package:amplify_recipe/thems/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/constants/gaps.dart';
import '../../../shared/utils/form_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _dobController;

  @override
  void initState() {
    _dobController = TextEditingController(text: "20 April 1999");
    super.initState();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Laura Harper",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  gapH8,
                  TextFormField(
                    initialValue: "Laura Harper",
                    onSaved: (fullName) {
                      // name = fullName!;
                    },
                    validator: FormUtils.requireFieldValidator,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: "Enter your name"),
                  ),
                  gapH16,
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  gapH8,
                  TextFormField(
                    initialValue: "Laura@mai.com",
                    onSaved: (email) {},
                    validator: FormUtils.emailValidator,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(hintText: "test@mail.com"),
                  ),
                  gapH16,
                  Text(
                    "Place of Birth",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  gapH8,
                  TextFormField(
                    initialValue: "Jakarta",
                    onSaved: (birthPlace) {},
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: "Jakarta"),
                  ),
                  gapH16,
                  Text(
                    "Date of Birth",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  gapH8,
                  TextFormField(
                    controller: _dobController,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        _dobController.text =
                            DateFormat('dd MMMM yyyy').format(selectedDate);
                      }
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter your DOB"),
                  ),
                  gapH16,
                  Text(
                    "Gender",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  gapH8,
                  DefaultTabController(
                    initialIndex: 0,
                    length: 2,
                    child: TabBar(
                      onTap: (index) {
                        // index == 0 male, 1 means female
                      },
                      unselectedLabelColor: AppColors.bodyText,
                      labelColor: AppColors.text,
                      indicator: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        border: Border.all(color: AppColors.primary),
                        color: AppColors.inputfieldBg,
                      ),
                      tabs: const [
                        Tab(text: "Male"),
                        Tab(text: "Female"),
                      ],
                    ),
                  ),
                  gapH24,
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Save Change"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
