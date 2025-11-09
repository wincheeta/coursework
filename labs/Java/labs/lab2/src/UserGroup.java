import java.util.ArrayList; // import the ArrayList class
import java.util.Iterator;


public class UserGroup {
    private ArrayList<User> users;

    public UserGroup() {
        this.users = new ArrayList<User>();
    }

    public ArrayList<User> getUsers() {
        return users;
    }

    public void addSampleData() {
        for (Integer i = 0; i < 10; i++) {
            User temp = new User(i.toString(),"user","joe");
            users.add(temp);
        }
    }

    public User getUser(int id) {
        return this.users.get(id);
    }

    public void printUsernames() {
        Iterator<User> it = users.iterator();
        while (it.hasNext()) {
            User temp = it.next();
            System.out.println(temp.getUsername()+" "+temp.getUserType());
        }
    }

    public void removeFirstUser() {
        this.users.remove(0);
    }

    public void removeLastUser() {
        this.users.remove(this.users.size()-1);
    }

    public void removeUser(String username) {
        Iterator<User> it = users.iterator();
        while (it.hasNext()) {
            User temp = it.next();
            if (temp.getUsername().equals(username)) {
                it.remove();
            }
        }
    }

    public Iterator<User> getUserIterator() {
        return users.iterator();
    }

    public void addUser(User user) {
        this.users.add(user);
    }

    public static void main(String[] args) {
        UserGroup userGroup = new UserGroup();
        userGroup.addSampleData();
        userGroup.printUsernames();

        UserGroup administrators = new UserGroup();
        Iterator<User> it = administrators.getUserIterator();
        while (it.hasNext()) {
            User temp = it.next();
            if (temp.getUserType().equals("admin")) {
                administrators.addUser(temp);
            }
        }
        administrators.printUsernames();
    }
}