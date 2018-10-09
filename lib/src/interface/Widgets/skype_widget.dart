part of dcvsapp;

class SkypeWidget extends StatefulWidget{
  final SkypeItem contact;
  final VoidCallback onCall;
  final VoidCallback onDelete;

  SkypeWidget({
    Key key,
    @required this.contact,
    this.onCall,
    this.onDelete,
}) : assert(contact != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() => new _SkypeWidgetState();
}

class _SkypeWidgetState extends State<SkypeWidget>{

  @override
  Widget build(BuildContext context){

    return new GestureDetector(
          child: new Row(
            children: <Widget>[
              new CircleAvatar(
                radius: 40.0,
                backgroundColor: widget.contact.serviceProvider ? Colors.blue : Colors.amberAccent,
                child: new Text(widget.contact.skypeName),
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 20.0),
              ),
              new Text(widget.contact.skypeId),
              new Padding(
                padding: const EdgeInsets.only(left: 20.0),
              ),
              new Text(
                widget.contact.serviceProvider ? "N / A" : widget.contact.serviceProviderName,
              ),
            ]
          ),
      onTap: (){
            widget.onCall();
            },
        );
  }
}