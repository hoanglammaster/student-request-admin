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
****************************************************************
 */
package model.user;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021 9:25:47 AM
 *
 */
public interface User{

    public static final int ADMIN = 1;
    public static final int TEACHER = 2;
    public static final int STAFF = 3;
    public static final int STUDENT = 4;

    public int getId();
    
    public void setId(int id);
    
    public String getUserName();

    public void setUserName(String userName);

    public String getPassword();

    public void setPassword(String password);

    public int getRole();

    public void setRole(int role);

}
