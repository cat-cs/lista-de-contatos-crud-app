import 'package:flutter/material.dart';
import 'database-connect/database.dart';
import 'models/contato.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ContatosScreen(),
    );
  }
}

class ContatosScreen extends StatefulWidget {
  const ContatosScreen({super.key});


  @override

  ContatosScreenState createState() => ContatosScreenState();
}

class ContatosScreenState extends State<ContatosScreen> {
  List<Contato> _contatos = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Contato? _contatoEditando;

  @override
  void initState() {
    super.initState();
    _loadContatos();
  }

  // Carregar contatos do banco de dados
  void _loadContatos() async {
    final contatos = await DB.getContatos();
    setState(() {
      _contatos = contatos;
    });
  }


  void _saveContato() async {
    if (_formKey.currentState?.validate() ?? false) {

      Navigator.of(context).pop();

      final nome = _nomeController.text;
      final telefone = _telefoneController.text;
      final email = _emailController.text;

      if (_contatoEditando == null) {

        final novoContato = Contato(nome: nome, telefone: telefone, email: email);
        await DB.insertContato(novoContato);
      } else {

        final atualizadoContato = Contato(
          id: _contatoEditando?.id,
          nome: nome,
          telefone: telefone,
          email: email,
        );
        await DB.updateContato(atualizadoContato);
      }


      _nomeController.clear();
      _telefoneController.clear();
      _emailController.clear();


      _loadContatos();
    }
  }


  // Excluir um contato
  void _deleteContato(int id) async {
    await DB.deleteContato(id);
    _loadContatos(); // Atualizar a lista de contatos
  }

  // Editar um contato
  void _editContato(Contato contato) {
    setState(() {
      _contatoEditando = contato;
      _nomeController.text = contato.nome;
      _telefoneController.text = contato.telefone;
      _emailController.text = contato.email;
    });
    showModalBottomSheet(
      context: context,
      builder: (_) => _buildForm(),
    );
  }

  // Construir o Formulário para adicionar ou editar
  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o nome/apelido do contato';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o telefone do contato';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Insira o email do contato';
                }
                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                    .hasMatch(value)) {
                  return 'Por favor, insira um email válido.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContato,
              child: Text(_contatoEditando == null ? 'Adicionar' : 'Editar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Contatos')),
      body: ListView.builder(
        itemCount: _contatos.length,
        itemBuilder: (context, index) {
          final contato = _contatos[index];
          return ListTile(
            title: Text(contato.nome),
            subtitle: Text(contato.telefone),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteContato(contato.id!),
            ),
            onTap: () => _editContato(contato),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _contatoEditando = null;
            _nomeController.clear();
            _telefoneController.clear();
            _emailController.clear();
          });
          showModalBottomSheet(
            context: context,
            builder: (_) => _buildForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}