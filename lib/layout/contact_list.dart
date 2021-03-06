import 'package:agenda/database/agenda_database.dart';
import 'package:agenda/model/contact.dart';
import 'package:agenda/widgets/my_contact_item.dart';
import 'package:appbar_textfield/appbar_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Future _contacts;
  
  getContacts() async {
    var contacts = await DBProvider.db.fetchContacts();
    return contacts;
  }

  @override
  void initState() {
    super.initState();
    _contacts = getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTextField(
        centerTitle: true,
        title: Text('Minha Agenda'),
        
      ),
      body: FutureBuilder<dynamic>(
        future: _contacts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return MyContactItem(
                        contactItem: snapshot.data[i],
                        onClick: () {
                          selectedContact = snapshot.data[i];
                          Navigator.of(context).pushNamed('/info');
                        },
                      );
                    },
                  )
                ],
              ),
            );
          }
        },),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/create');
        },
      ),
    );
  }
}
