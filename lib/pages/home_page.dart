import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/local_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widget/custom_search_delegate.dart';
import '../widget/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allTasks = <Task>[];
    getAllTaskFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal.shade300,
        title: GestureDetector(
          onTap: () {
            addTaskBottomSheet(context);
          },
          child: const Text(
            "title",
            style: TextStyle(color: Colors.black),
          ).tr(),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              searchPage();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              addTaskBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var currentListItem = _allTasks[index];
                return Dismissible(
                  background: const Row(
                    children: [
                      Icon(Icons.delete),
                      Text("remove_task"),
                    ],
                  ),
                  key: Key(currentListItem.id.toString()),
                  onDismissed: (direction) async {
                    _allTasks.removeAt(index);
                    await _localStorage.deleteTask(task: currentListItem);
                    setState(() {});
                  },
                  child: TaskItem(task: currentListItem),
                );
              },
              itemCount: _allTasks.length,
            )
          : Center(
              child: const Text("empty_task_list").tr(),
            ),
    );
  }

  void addTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 22),
              decoration: InputDecoration(
                hintText: "add_task".tr(),
                border: InputBorder.none,
              ),
              onSubmitted: (value) async {
                if (value.isNotEmpty) {
                  Navigator.of(context).pop();
                  var time = DateTime.now();
                  var newTaskToBeAdded =
                      Task.create(name: value, createdAt: time);
                  _allTasks.insert(0, newTaskToBeAdded);
                  await _localStorage.addTask(task: newTaskToBeAdded);
                  setState(() {});
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> getAllTaskFromDb() async {
    _allTasks = await _localStorage.getAllTasks();
    setState(() {});
  }

  void searchPage() {
    showSearch(
      context: context,
      delegate: CustomSearchDelegate(allTasks: _allTasks),
    );
  }
}
