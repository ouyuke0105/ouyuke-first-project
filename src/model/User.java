package model;

public class User {
    private int id;
    private String username;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String address;
    private boolean isadmin=false;
    private boolean isvalidate=false;
    // ===== 新增：points积分属性（对应数据库user表的points字段，类型int匹配数据库INT）=====
    private int points; // 用int即可，数据库中是NOT NULL DEFAULT 0，默认值0，无需用Integer

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    @Override
    public String toString() {
        return "User [id=" + id + ", username=" + username + ", email=" + email + ", password=" + password + ", name="
                + name + ", phone=" + phone + ", address=" + address + ", isadmin=" + isadmin + ", isvalidate="
                + isvalidate + ", points=" + points + "]"; // 新增：toString中补充points，方便调试
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public boolean isIsadmin() {
        return isadmin;
    }
    public void setIsadmin(boolean isadmin) {
        this.isadmin = isadmin;
    }
    public boolean isIsvalidate() {
        return isvalidate;
    }
    public void setIsvalidate(boolean isvalidate) {
        this.isvalidate = isvalidate;
    }

    // ===== 新增：points属性的get/set方法（必须添加，否则无法获取/设置用户积分）=====
    public int getPoints() {
        return points;
    }
    public void setPoints(int points) {
        this.points = points;
    }

    public User(int id, String username, String email, String password, String name, String phone, String address,
                boolean isadmin, boolean isvalidate) {
        super();
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.isadmin = isadmin;
        this.isvalidate = isvalidate;
        // 新增：积分属性默认值0（贴合数据库DEFAULT 0）
        this.points = 0;
    }
    public User( String username, String email, String password, String name, String phone, String address) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.isadmin = false;
        this.isvalidate = false;
        // 新增：积分属性默认值0（贴合数据库DEFAULT 0）
        this.points = 0;
    }
    public User() {
        super();
        // 新增：积分属性默认值0（贴合数据库DEFAULT 0）
        this.points = 0;
    }
}