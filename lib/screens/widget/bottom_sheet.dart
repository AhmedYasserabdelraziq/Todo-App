import 'package:flutter/material.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';

buildBottomSheet(
    TasksViewModel viewModel, BuildContext context, VoidCallback? function) {
  return showBottomSheet(
      backgroundColor: Colors.grey[200],
      elevation: 30,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (c) {
        return bottomSheetContent(viewModel, function);
      }).closed.then((value) {
    viewModel.closeUpdatedBottomSheet();
    print(viewModel.update);
  });
}

bottomSheetContent(TasksViewModel viewModel, VoidCallback? function) {
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
                hintText: 'Todo title',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: .75,
                    color: Colors.white,
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
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  label: Text('description'),
                  hintText: 'add todo description'),
            ),
          ),
          viewModel.update
              ? ElevatedButton(onPressed:()=> function, child: const Text('update'))
              : Container()
        ],
      ),
    ),
  );
}
