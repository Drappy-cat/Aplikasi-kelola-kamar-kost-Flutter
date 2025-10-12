import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/services/dummy_service.dart';
import 'package:tes/shared/services/locator.dart';

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
  late TextEditingController _dimensionsCtrl;
  late TextEditingController _imageUrlsCtrl;
  // CONTROLLERS BARU
  late TextEditingController _fasilitasTambahanCtrl;
  late TextEditingController _jumlahKasurCtrl;

  late String _selectedStatus;
  late bool _isPackageFull;
  // STATE BARU
  late bool _isFurnished;

  bool get _isEditMode => widget.room != null;

  final DummyService _dummyService = getIt<DummyService>();

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
    // INISIALISASI CONTROLLERS DAN STATE BARU
    _fasilitasTambahanCtrl = TextEditingController(text: widget.room?.fasilitasTambahan ?? '');
    _isFurnished = widget.room?.isFurnished ?? false;
    _jumlahKasurCtrl = TextEditingController(text: widget.room?.jumlahKasur.toString() ?? '1');
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
    // DISPOSE CONTROLLERS BARU
    _fasilitasTambahanCtrl.dispose();
    _jumlahKasurCtrl.dispose();
    super.dispose();
  }

  void _saveForm() async {
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
      // SIMPAN DATA BARU
      fasilitasTambahan: _fasilitasTambahanCtrl.text.isEmpty ? null : _fasilitasTambahanCtrl.text,
      isFurnished: _isFurnished,
      jumlahKasur: int.tryParse(_jumlahKasurCtrl.text) ?? 1,
    );

    if (_isEditMode) {
      await _dummyService.updateRoom(newRoom);
    } else {
      await _dummyService.addRoom(newRoom);
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Kamar' : 'Tambah Kamar'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
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
              // FIELD INPUT BARU: Fasilitas Tambahan
              TextFormField(
                controller: _fasilitasTambahanCtrl,
                decoration: const InputDecoration(labelText: 'Fasilitas Tambahan (pisahkan dengan koma)', hintText: 'Contoh: Meja, Kursi, Lemari'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              // FIELD INPUT BARU: Jumlah Kasur
              TextFormField(
                controller: _jumlahKasurCtrl,
                decoration: const InputDecoration(labelText: 'Jumlah Kasur'),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty || int.tryParse(v) == null) ? 'Wajib diisi dengan angka' : null,
              ),
              const SizedBox(height: 16),
              // FIELD INPUT BARU: Is Furnished
              SwitchListTile(
                title: const Text('Dilengkapi Furnitur'),
                value: _isFurnished,
                onChanged: (value) {
                  setState(() => _isFurnished = value);
                },
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
