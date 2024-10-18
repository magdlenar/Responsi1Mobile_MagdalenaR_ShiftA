import 'package:flutter/material.dart';
import '../bloc/wisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/wisata.dart';
import 'wisata_page.dart';

class WisataForm extends StatefulWidget {
  final Wisata? wisata;

  const WisataForm({Key? key, this.wisata}) : super(key: key);

  @override
  _WisataFormState createState() => _WisataFormState();
}

class _WisataFormState extends State<WisataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH WISATA";
  String tombolSubmit = "SIMPAN";
  final _destinationTextboxController = TextEditingController();
  final _locationTextboxController = TextEditingController();
  final _attractionTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.wisata != null) {
      setState(() {
        judul = "UBAH WISATA";
        tombolSubmit = "UBAH";
        _destinationTextboxController.text = widget.wisata!.destination ?? '';
        _locationTextboxController.text = widget.wisata!.location ?? '';
        _attractionTextboxController.text = widget.wisata!.attraction ?? '';
      });
    } else {
      judul = "TAMBAH WISATA";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.yellow[700], // Warna kuning terang
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _destinationTextField(),
                _locationTextField(),
                _attractionTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox untuk Destination
  Widget _destinationTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Destination",
        labelStyle: TextStyle(color: Colors.black), // Teks warna hitam
      ),
      keyboardType: TextInputType.text,
      controller: _destinationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Destination harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox untuk Location
  Widget _locationTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Location",
        labelStyle: TextStyle(color: Colors.black), // Teks warna hitam
      ),
      keyboardType: TextInputType.text,
      controller: _locationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Location harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox untuk Attraction
  Widget _attractionTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Attraction",
        labelStyle: TextStyle(color: Colors.black), // Teks warna hitam
      ),
      keyboardType: TextInputType.text,
      controller: _attractionTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Attraction harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.yellow[700], // Warna kuning terang
      ),
      child: Text(
        tombolSubmit,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.wisata != null) {
              // Kondisi update wisata
              ubah();
            } else {
              // Kondisi tambah wisata
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    Wisata createWisata = Wisata(
      id: null,
      destination: _destinationTextboxController.text,
      location: _locationTextboxController.text,
      attraction: _attractionTextboxController.text,
    );

    WisataBloc.addWisata(wisata: createWisata).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const WisataPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    Wisata updateWisata = Wisata(
      id: widget.wisata!.id!,
      destination: _destinationTextboxController.text,
      location: _locationTextboxController.text,
      attraction: _attractionTextboxController.text,
    );

    WisataBloc.updateWisata(wisata: updateWisata).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const WisataPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }
}
