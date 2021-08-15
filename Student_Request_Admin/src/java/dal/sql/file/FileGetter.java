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
package dal.sql.file;

import dal.sql.Connections;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import dal.sql.AbstractGetter;
import java.util.List;
import model.util.convert.Convertible;
import model.util.data.transfer.DataTransferFactory;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 8:21:41 AM
 *
 */
class FileGetter extends AbstractGetter<File> implements FileGettable {

    public FileGetter(Connections connectioner, Convertible<File> converter) {
        super(connectioner, converter);
    }

    @Override
    public File get(int id) {
        String query = "SELECT * FROM Files WHERE FileId = ?";
        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, id);
                ResultSet result = statement.executeQuery();
                if (result.next()) {
                    return converter.convert(result);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(FileGetter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<File> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
