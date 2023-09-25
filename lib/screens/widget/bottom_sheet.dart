import 'package:flutter/material.dart';
import 'package:todo_app/screens/view_model/tasks_view_model.dart';

SizedBox buildBottomSheet(TasksViewModel viewModel) {
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
        ],
      ),
    ),
  );
}
