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
package dal.sql.student;

import dal.sql.AbstractGetter;
import dal.sql.Connections;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.student.Student;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 8:21:41 AM
 *
 */
class Getter extends AbstractGetter<Student> implements StudentGettable {

    public Getter(Connections connectioner, Convertible<Student> converter) {
        super(connectioner, converter);
    }

    @Override
    public Student get(int id) {
        String query = "SELECT StudentId,StudentCode,CONCAT(FirstName,' ',MidleName,' ',LastName) AS FullName FROM Students std "
                + "JOIN UserInformations inf "
                + "ON std.UserId = inf.UserId "
                + "WHERE StudentId = ?";
        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, id);
                ResultSet result = statement.executeQuery();
                if (result.next()) {
                    return converter.convert(result);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Getter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<Student> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
