import 'package:flutter/material.dart';
SizedBox buildBottomSheet() {
  return const SizedBox(
    height: 300,
    child: Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: InputDecoration(
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
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
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