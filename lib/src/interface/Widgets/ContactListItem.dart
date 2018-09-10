part of dcvsapp;

class ContactItemWidget extends StatefulWidget{
  final Contact contact;
  final VoidCallback onCall;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  ContactItemWidget({
    Key key,
    @required this.contact,
    this.onCall,
    this.onDelete,
    this.onEdit,
}) : assert(contact != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() => new _ContactItemWidgetState();
}

class _ContactItemWidgetState extends State<ContactItemWidget>{

  @override
  Widget build(BuildContext context){
   return new Row(
     children: <Widget>[
       new GestureDetector(
         onTap: widget.onCall,
         child: new Container(
           child: new Text(widget.contact.name),
         ),
       ),
       new FlatButton(onPressed: widget.onEdit, child: new Text("Edit")),
       new FlatButton(onPressed: widget.onDelete, child: new Text("Delete")),
     ],
   );
  }
}