import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/wisata_bloc.dart';
import '/model/wisata.dart';
import '/ui/wisata_detail.dart';
import '/ui/wisata_form.dart';
import 'login_page.dart';

class WisataPage extends StatefulWidget {
  const WisataPage({Key? key}) : super(key: key);

  @override
  _WisataPageState createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700], // Bright yellow for the app bar
        title: const Text(
          'List Wisata',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 24.0,
            color: Colors.black, // Text color black for contrast
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.black), // Black icon for contrast
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WisataForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      ),
                    });
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.yellow[100], // Light yellow background for the entire body
        child: FutureBuilder<List>(
          future: WisataBloc.getWisata(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListWisata(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListWisata extends StatelessWidget {
  final List? list;

  const ListWisata({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemWisata(
          wisata: list![i],
        );
      },
    );
  }
}

class ItemWisata extends StatelessWidget {
  final Wisata wisata;

  const ItemWisata({Key? key, required this.wisata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WisataDetail(wisata: wisata),
          ),
        );
      },
      child: Card(
        color: Colors.yellow[50], // Light yellow card background
        elevation: 5.0, // Slight elevation for shadow effect
        child: ListTile(
          title: Text(
            wisata.destination!,
            style: const TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 18.0,
              color: Colors.black, // Black text color for contrast
            ),
          ),
          subtitle: Text(
            wisata.location!,
            style: const TextStyle(color: Colors.black54), // Subtle black for subtitle
          ),
          trailing: Text(
            wisata.attraction!,
            style: const TextStyle(color: Colors.black87), // Darker black for attraction text
          ),
        ),
      ),
    );
  }
}
