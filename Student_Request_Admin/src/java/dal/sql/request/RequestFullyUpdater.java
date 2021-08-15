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
package dal.sql.request;

import dal.sql.Connections;
import dal.sql.Updatable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.request.RequestFully;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 20, 2021 9:44:28 PM
 *
 */
class RequestFullyUpdater implements RequestUpdatable {

    private Connections connectioner;

    public RequestFullyUpdater(Connections connectioner) {
        this.connectioner = connectioner;
    }

    @Override
    public void update(RequestFully t, int type) {
        String query = "";

        if (type == Updatable.MYSELT) {
            query = "EXEC stp_UpdateApplicationByMe ?,?,?,?";
        } else {
            query = "EXEC stp_UpdateApplication ?,?,?,?";
        }

        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, t.getRequestId());
                statement.setBoolean(2, t.getStatus());
                statement.setInt(3, t.getSolved().getId());
                statement.setString(4, t.getSolution());
                statement.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(RequestFullyUpdater.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
