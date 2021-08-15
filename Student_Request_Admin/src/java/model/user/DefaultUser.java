/** **************************************************************
 * Copyright [2021] [FPT University]
 *
 * This file create by [Hoang Lam]
 * If you want to use this file in your project,
 * please contact to <https://www.facebook.com/hoanglammaster>
 * or <hoanglammaster@gmail.com>
 * Do not use without permission
 *
 * “All I know is that I do not know anything”― Socrates
 * ***************************************************************
 */
package model.user;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 16, 2021 6:19:28 AM
 *
 */
public class DefaultUser implements User {

    private int id;
    private String userName;
    private String password;
    private int role;

    public DefaultUser() {
    }

    public DefaultUser(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    @Override
    public String getUserName() {
        return userName;
    }

    @Override
    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public int getRole() {
        return role;
    }

    @Override
    public void setRole(int role) {
        this.role = role;
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

}
