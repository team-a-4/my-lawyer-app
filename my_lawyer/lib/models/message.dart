import 'package:flutter/material.dart';

class Action {
  String actionTitle;
  String actionUrl;

  Action({
    required this.actionTitle,
    required this.actionUrl,
  });
}

class TextController {}

class Field {
  String fieldTitle;
  String fieldType;
  TextEditingController textController;

  Field({
    required this.fieldTitle,
    required this.fieldType,
    required this.textController,
  });
}

//
//
///
////
////
/////
////
////
////
////
////
////

class Message {
  final String content;
  Map<String, dynamic> json_data;
  List<Field> fields = [];

  Message({
    required this.content,
    this.json_data = const {},
  });

  bool containsForm() {
    bool containsForm = false;
    if (json_data.containsKey('form')) {
      containsForm = true;
    }
    print(containsForm);
    return containsForm;
  }

  bool containsActions() {
    bool containsActions = false;
    if (json_data.containsKey('form_data')) {
      if (json_data['form_data'].containsKey('actions')) {
        containsActions = true;
      }
    }
    return containsActions;
  }

  bool containLinks() {
    bool containsLinks = false;
    if (json_data.containsKey('link')) {
      containsLinks = true;
    }
    return containsLinks;
  }

  String getLink() {
    return json_data['link'];
  }

  String getActionTitle() {
    return json_data['form_data']['title'];
  }

  String getFormTitle() {
    return json_data['form']['title'];
  }

// form_data = {"title" : "Do you wish to fill a claim form?","actions":[{"data":"yes", "action":"fill_insurance_claim"},{"data":"no", "action":"cancel"}]}
  List<Action> getActionOptions() {
    List<Action> actions = [];
    for (var action in json_data['form_data']['actions']) {
      actions.add(Action(
        actionTitle: action['data'],
        actionUrl: action['action'],
      ));
    }
    return actions;
  }

  List<Field> getFormFields() {
    List<Field> fields = [];
    for (var field in json_data['form']['fields']) {
      fields.add(Field(
        fieldTitle: field[0],
        fieldType: field[1],
        textController: TextEditingController(),
      ));
    }
    return fields;
  }
}
