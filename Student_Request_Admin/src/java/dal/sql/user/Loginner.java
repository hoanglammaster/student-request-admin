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
package dal.sql.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.user.User;
import model.util.encrypt.PasswordAuthentication;
import dal.sql.Connections;
import java.util.Optional;
import model.user.UserFactory;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 6, 2021 12:31:31 AM
 *
 */
class Loginner implements Loginable{

    private Connections connectioner;
    private PasswordAuthentication authenticator;

    public Loginner(Connections connectioner, PasswordAuthentication authenticator) {
        this.connectioner = connectioner;
        this.authenticator = authenticator;
    }

    

    @Override
    public Optional<User> login (String userName, String password) {
        String query = "SELECT * FROM Users WHERE UserName = ?";
        try {
            Connection connection = connectioner.getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, userName);
                try (ResultSet result = statement.executeQuery()) {
                    if (result.next()) {
                        
                        if (authenticator.authentic(password, result.getString("UserPassword"))) {
                            User user = UserFactory.getDefaultUser(userName, password);
                            
                            user.setRole(result.getInt("RoleId"));
                            user.setId(result.getInt("UserId"));
                            
                            return Optional.of(user);
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Loginner.class.getName()).log(Level.SEVERE, "Login Failed", ex);
        }
        return Optional.empty();
    }

}
