import 'package:flutter/material.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/dummy_service.dart';

class AddEditScreen extends StatefulWidget {
  final Room? room;

  const AddEditScreen({super.key, this.room});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeCtrl;
  late TextEditingController _baseRentCtrl;
  late TextEditingController _wifiCtrl;
  late TextEditingController _waterCtrl;
  late TextEditingController _electricityCtrl;
  late TextEditingController _acCostCtrl;
  late TextEditingController _dimensionsCtrl; // Controller untuk dimensi
  late TextEditingController _imageUrlsCtrl; // Controller untuk URL gambar

  late String _selectedStatus;
  late bool _isPackageFull;

  bool get _isEditMode => widget.room != null;

  @override
  void initState() {
    super.initState();
    _codeCtrl = TextEditingController(text: widget.room?.code ?? '');
    _baseRentCtrl = TextEditingController(text: widget.room?.baseRent.toString() ?? '0');
    _wifiCtrl = TextEditingController(text: widget.room?.wifi.toString() ?? '0');
    _waterCtrl = TextEditingController(text: widget.room?.water.toString() ?? '0');
    _electricityCtrl = TextEditingController(text: widget.room?.electricity.toString() ?? '0');
    _acCostCtrl = TextEditingController(text: widget.room?.acCost.toString() ?? '0');
    _dimensionsCtrl = TextEditingController(text: widget.room?.dimensions ?? '');
    _imageUrlsCtrl = TextEditingController(text: widget.room?.imageUrls.join(', ') ?? '');
    _selectedStatus = widget.room?.status ?? 'Kosong';
    _isPackageFull = widget.room?.packageFull ?? false;
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _baseRentCtrl.dispose();
    _wifiCtrl.dispose();
    _waterCtrl.dispose();
    _electricityCtrl.dispose();
    _acCostCtrl.dispose();
    _dimensionsCtrl.dispose();
    _imageUrlsCtrl.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    final imageUrls = _imageUrlsCtrl.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    final newRoom = Room(
      code: _codeCtrl.text,
      status: _selectedStatus,
      baseRent: int.tryParse(_baseRentCtrl.text) ?? 0,
      wifi: int.tryParse(_wifiCtrl.text) ?? 0,
      water: int.tryParse(_waterCtrl.text) ?? 0,
      electricity: int.tryParse(_electricityCtrl.text) ?? 0,
      acCost: int.tryParse(_acCostCtrl.text) ?? 0,
      packageFull: _isPackageFull,
      dimensions: _dimensionsCtrl.text,
      imageUrls: imageUrls,
      tenantName: widget.room?.tenantName,
      tenantAddress: widget.room?.tenantAddress,
      tenantPhone: widget.room?.tenantPhone,
      rentStartDate: widget.room?.rentStartDate,
    );

    if (_isEditMode) {
      DummyService.updateRoom(newRoom);
    } else {
      DummyService.addRoom(newRoom);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Kamar' : 'Tambah Kamar'),
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
                controller: _codeCtrl,
                decoration: const InputDecoration(labelText: 'Kode Kamar (cth: A-101)'),
                readOnly: _isEditMode,
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
               TextFormField(
                controller: _dimensionsCtrl,
                decoration: const InputDecoration(labelText: 'Dimensi Kamar (cth: 3x4 m)'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status Kamar'),
                items: const [
                  DropdownMenuItem(value: 'Kosong', child: Text('Kosong')),
                  DropdownMenuItem(value: 'Dihuni', child: Text('Dihuni')),
                  DropdownMenuItem(value: 'Maintenance', child: Text('Maintenance')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedStatus = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _baseRentCtrl,
                decoration: const InputDecoration(labelText: 'Sewa Dasar', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _wifiCtrl,
                decoration: const InputDecoration(labelText: 'Biaya WiFi', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _waterCtrl,
                decoration: const InputDecoration(labelText: 'Biaya Air', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _electricityCtrl,
                decoration: const InputDecoration(labelText: 'Biaya Listrik', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _acCostCtrl,
                decoration: const InputDecoration(labelText: 'Biaya Tambahan AC', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlsCtrl,
                decoration: const InputDecoration(labelText: 'URL Gambar (pisahkan dengan koma)', hintText: 'url1, url2, ...'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Paket Full (Termasuk Utilitas)'),
                value: _isPackageFull,
                onChanged: (value) {
                  setState(() => _isPackageFull = value);
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saveForm,
                  child: Text(_isEditMode ? 'Simpan Perubahan' : 'Tambah Kamar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
