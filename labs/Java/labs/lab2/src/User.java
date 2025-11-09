public class User {
    private String username;
    private String name;
    private String userType;

    public User(String username, String userType, String name) {
        this.username = username;
        this.name = name;
        this.userType = userType;
    }

    public String getUsername() {
        return username;
    }

    public String getUserType() {
        return this.userType;
    }

    public String getName() {
        return this.name;
    }

    public void setUserType(String userType) {
    this.userType = userType;
    }
}