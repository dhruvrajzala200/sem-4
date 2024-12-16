import 'dart:io';

void main() {
  User userManager = User();
  int choice;

  do {
    print("\n--- User Management System ---");
    print("1. Add User");
    print("2. List All Users");
    print("3. Update User");
    print("4. Delete User");
    print("5. Search User");
    print("6. Exit");
    stdout.write("Enter your choice: ");
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
      // Add User
        stdout.write("Enter Name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter Age: ");
        int age = int.parse(stdin.readLineSync()!);
        stdout.write("Enter Email: ");
        String email = stdin.readLineSync()!;
        userManager.addUserInList(name: name, age: age, email: email);
        break;

      case 2:
      // List All Users
        print("\n--- User List ---");
        List<Map<String, dynamic>> userList = userManager.getUserList();
        if (userList.isNotEmpty) {
          for (int i = 0; i < userList.length; i++) {
            print("ID: $i | Name: ${userList[i]['name']} | Age: ${userList[i]['age']} | Email: ${userList[i]['email']}");
          }
        } else {
          print("No users found.");
        }
        break;

      case 3:
      // Update User
        stdout.write("Enter ID to Update: ");
        int id = int.parse(stdin.readLineSync()!);
        stdout.write("Enter New Name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter New Age: ");
        int age = int.parse(stdin.readLineSync()!);
        stdout.write("Enter New Email: ");
        String email = stdin.readLineSync()!;
        userManager.updateUser(name: name, age: age, email: email, id: id);
        break;

      case 4:
      // Delete User
        stdout.write("Enter ID to Delete: ");
        int id = int.parse(stdin.readLineSync()!);
        userManager.deleteUser(id);
        break;

      case 5:
      // Search User
        stdout.write("Enter Search Query: ");
        String searchQuery = stdin.readLineSync()!;
        print("\n--- Search Results ---");
        userManager.searchDeatil(searchData: searchQuery);
        break;

      case 6:
      // Exit
        print("Exiting the application. Goodbye!");
        break;

      default:
        print("Invalid choice. Please try again.");
        break;
    }
  } while (choice != 6);
}

class User {
  List<Map<String, dynamic>> userList = [];

  // Add User to List
  void addUserInList({required String name, required int age, required String email}) {
    Map<String, dynamic> map = {
      "name": name,
      "age": age,
      "email": email,
    };
    userList.add(map);
    print("User Added: $map");
  }

  // Get All Users
  List<Map<String, dynamic>> getUserList() {
    return userList;
  }

  // Update User by ID
  void updateUser({required String name, required int age, required String email, required int id}) {
    if (id >= 0 && id < userList.length) {
      userList[id] = {
        "name": name,
        "age": age,
        "email": email,
      };
      print("User with ID $id Updated.");
    } else {
      print("Invalid ID. User not found.");
    }
  }

  // Delete User by ID
  void deleteUser(int id) {
    if (id >= 0 && id < userList.length) {
      userList.removeAt(id);
      print("User with ID $id Deleted.");
    } else {
      print("Invalid ID. User not found.");
    }
  }

  // Search User Details
  void searchDeatil({required String searchData}) {
    bool found = false;
    for (var element in userList) {
      if (element["name"].toString().toLowerCase().contains(searchData.toLowerCase()) ||
          element["age"].toString().contains(searchData) ||
          element["email"].toString().toLowerCase().contains(searchData.toLowerCase())) {
        print("Match Found: Name: ${element["name"]}, Age: ${element["age"]}, Email: ${element["email"]}");
        found = true;
      }
    }
    if (!found) {
      print("No Match Found for '$searchData'.");
    }
  }
}
