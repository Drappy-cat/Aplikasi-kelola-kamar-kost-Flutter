import 'package:flutter/material.dart';
import 'package:tes/shared/models/dosen.dart';
import 'package:tes/shared/models/mahasiswa.dart';
import 'package:tes/shared/models/person.dart';
import 'package:tes/shared/services/dummy_service.dart';

class AddEditScreen extends StatefulWidget {
  final Person? person; // Jika null, berarti mode Tambah. Jika tidak, mode Edit.

  const AddEditScreen({super.key, this.person});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _nimNidnCtrl;

  String _selectedRole = 'Mahasiswa';
  bool get _isEditMode => widget.person != null;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.person?.nama ?? '');
    _emailCtrl = TextEditingController(text: widget.person?.email ?? '');

    String nimNidn = '';
    if (widget.person is Mahasiswa) {
      nimNidn = (widget.person as Mahasiswa).nim;
      _selectedRole = 'Mahasiswa';
    } else if (widget.person is Dosen) {
      nimNidn = (widget.person as Dosen).nidn;
      _selectedRole = 'Dosen';
    }
    _nimNidnCtrl = TextEditingController(text: nimNidn);
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _nimNidnCtrl.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    final id = _isEditMode ? widget.person!.id : 'new_${DateTime.now().millisecondsSinceEpoch}';
    final nama = _namaCtrl.text;
    final email = _emailCtrl.text;
    final nimNidn = _nimNidnCtrl.text;

    Person newPerson;
    if (_selectedRole == 'Mahasiswa') {
      newPerson = Mahasiswa(id: id, nama: nama, email: email, nim: nimNidn);
    } else {
      newPerson = Dosen(id: id, nama: nama, email: email, nidn: nimNidn);
    }

    if (_isEditMode) {
      // TODO: Tambahkan logika edit di DummyService
    } else {
      DummyService.addPerson(newPerson);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Data' : 'Tambah Data'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF72585), Color(0xFF5B2EBC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaCtrl,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => (v == null || !v.contains('@')) ? 'Email tidak valid' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'Peran'),
                items: const [
                  DropdownMenuItem(value: 'Mahasiswa', child: Text('Mahasiswa')),
                  DropdownMenuItem(value: 'Dosen', child: Text('Dosen')),
                ],
                onChanged: _isEditMode ? null : (value) {
                  if (value != null) {
                    setState(() => _selectedRole = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nimNidnCtrl,
                decoration: InputDecoration(labelText: _selectedRole == 'Mahasiswa' ? 'NIM' : 'NIDN'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saveForm,
                  child: Text(_isEditMode ? 'Simpan Perubahan' : 'Tambah Data'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
