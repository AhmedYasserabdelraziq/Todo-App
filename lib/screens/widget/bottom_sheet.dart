import 'package:flutter/material.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';
import 'package:todo_app/utils/colors.dart';

buildBottomSheet(TasksViewModel viewModel, BuildContext context) {
  return showBottomSheet(
      backgroundColor: AppColors.bottomSheetColor,
      elevation: 30,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (c) {
        return bottomSheetContent(viewModel, context);
      }).closed.then((value) {
    viewModel.closeUpdatedBottomSheet();
    viewModel.reset();
    print(viewModel.update);
  });
}

bottomSheetContent(TasksViewModel viewModel, BuildContext context) {
  return SizedBox(
    height: 300,
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: viewModel.titleTaskController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: .75,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: viewModel.descriptionTaskController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: .75,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                label: Text('description'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return TextButton(
                    onPressed: () async {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 2),
                        lastDate: DateTime(DateTime.now().year + 50),
                      ).then((value) {
                        if (value != null) {
                          print(value);
                          viewModel.setCompleteDate(value);
                          setState(() {});
                        }
                      });
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        if (value != null) {
                          viewModel.currentDateToSelect(value);
                          setState(() {}); // this will rebuild the BottomSheet
                        }
                      });
                    },
                    child: Text(
                      viewModel.dateOfTask != null && viewModel.daytime != null
                          ? '${viewModel.dateOfTask!} : ${viewModel.formatDateTime(viewModel.daytime!)}'
                          : 'No Time Selected',
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    ),
  );
}
