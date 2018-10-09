part of dcvsapp;

class ContactHeaderWidget extends StatelessWidget{
  final VoidCallback addContact;

  ContactHeaderWidget({
    Key key,
    this.addContact,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final List<Widget> children = <Widget>[];
    children.add(new Text("Name | Skype Id | Service Provider"));

    return new Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new Row(children: children),
    );
  }
}