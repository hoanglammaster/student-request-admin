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
package dal.sql.request;

import dal.sql.AbstractGetter;
import dal.sql.Connections;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.request.RequestFully;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 20, 2021 2:03:41 AM
 *
 */
class FullyGetter extends AbstractGetter<RequestFully> implements RequestFullyGettable {

    public FullyGetter(Connections connectioner, Convertible<RequestFully> converter) {
        super(connectioner, converter);
    }

    @Override
    public RequestFully get(int id) {
        String query = "SELECT * FROM Applications app JOIN ApplicationDetails de ON app.AppId = de.Id\n"
                + "WHERE AppId = ?";
        try(Connection connection = connectioner.getConnection()){
            try(PreparedStatement statement = connection.prepareStatement(query)){
                statement.setInt(1, id);
                try(ResultSet result = statement.executeQuery()){
                    if(result.next()){
                        return converter.convert(result);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(FullyGetter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<RequestFully> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
