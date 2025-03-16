import 'package:flutter/material.dart';
import 'database_helper.dart';

class Practica5 extends StatefulWidget {
  const Practica5({Key? key}) : super(key: key);

  @override
  Practica5State createState() => Practica5State();
}

class Practica5State extends State<Practica5> {
  final DatabaseHelper5 _dbHelper = DatabaseHelper5(); // INSTANCIA DE BASE DE DATOS
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  List<Map<String, dynamic>> _users = [];

  /// **Añadir un nuevo usuario a la base de datos**
  Future<void> _addUser() async {
    if (_nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rellena todos los campos antes de agregar un usuario.')),
      );
      return;
    }

    await _dbHelper.insertUser(_nameController.text.trim(), _emailController.text.trim());
    _loadUsers();
    _nameController.clear();
    _emailController.clear();
  }

  /// **Cargar usuarios desde la base de datos**
  Future<void> _loadUsers() async {
    final users = await _dbHelper.getUsers();
    setState(() => _users = users);
  }

  /// **Eliminar un usuario de la base de datos**
  Future<void> _deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
    _loadUsers();
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite Usuarios")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/A1.png"),  // Ruta de la imagen
            fit: BoxFit.cover,  // Asegura que la imagen cubra todo el fondo
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// **Campo de texto para el Nombre**
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              /// **Campo de texto para el Email**
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// **Botón para agregar un usuario**
              ElevatedButton(
                onPressed: _addUser,
                child: Text("Agregar Usuario"),
              ),
              const SizedBox(height: 20),

              /// **Lista de Usuarios**
              Expanded(
                child: _users.isEmpty
                    ? Center(child: Text("No hay usuarios en la base de datos."))
                    : ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(_users[index]['name'], style: TextStyle(fontSize: 18)),
                            subtitle: Text(_users[index]['email'], style: TextStyle(fontSize: 16, color: Colors.grey)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteUser(_users[index]['id']),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
