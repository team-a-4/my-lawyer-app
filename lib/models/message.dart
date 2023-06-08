class Action {
  String actionTitle;
  String actionUrl;

  Action({
    required this.actionTitle,
    required this.actionUrl,
  });
}

class Message {
  final String content;
  // i need to store a json object here
  Map<String, dynamic> json_data;

  Message({
    required this.content,
    this.json_data = const {},
  });

  bool containsActions() {
    print(json_data.containsKey('form_data'));
    return json_data.containsKey('form_data');
  }

  String getActionTitle() {
    print(json_data['form_data']['title']);
    return json_data['form_data']['title'];
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
}
