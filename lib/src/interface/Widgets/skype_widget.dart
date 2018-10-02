part of dcvsapp;

class SkypeWidget extends StatefulWidget{
  final SkypeItem contact;
  final bool disabled;
  final VoidCallback onCall;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  SkypeWidget({
    Key key,
    @required this.contact,
    this.disabled = false,
    this.onCall,
    this.onDelete,
    this.onUpdate,
}) : assert(contact != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() => new _SkypeWidgetState();
}

class _SkypeWidgetState extends State<SkypeWidget>{

  Widget _buildTitle(BuildContext context){
    final ThemeData theme = Theme.of(context);
    TextStyle titleStyle = theme.textTheme.body1;
    if (widget.disabled) {
      titleStyle = titleStyle.copyWith(color: Colors.grey);
    }

    return new GestureDetector(
      child: new Text(widget.contact.skypeName, style: titleStyle),
      onTap: widget.disabled
      ? null
      : () {
        widget.onCall();
      },
    );
  }

  @override
  Widget build(BuildContext context){
    final Widget titleChild = _buildTitle(context);

    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 2,
          child: titleChild,
        ),
        new IconButton(
          icon: new Icon(Icons.delete),
          onPressed: widget.disabled ? null : widget.onDelete,
        ),
        new IconButton(
          icon: new Icon(Icons.phone),
          onPressed: widget.disabled ? null : widget.onCall,
        ),
      ]
    )
  }

}