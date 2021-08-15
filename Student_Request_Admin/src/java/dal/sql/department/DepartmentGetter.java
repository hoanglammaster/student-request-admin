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
package dal.sql.department;

import dal.sql.AbstractGetter;
import dal.sql.Connections;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.department.Department;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 * @param <T>
 *
 * @Created Jul 19, 2021 1:49:33 PM
 *
 */
class DepartmentGetter extends AbstractGetter<Department> implements DepartmentGettable {
    
    public DepartmentGetter(Connections connectioner, Convertible<Department> converter) {
        super(connectioner,converter);
    }

    @Override
    public Department get(int id) {
        String query = "SELECT * FROM Departments WHERE DepartmentId = ?";
        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, id);
                try (ResultSet result = statement.executeQuery()) {
                    if (result.next()) {
                        return converter.convert(result);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DepartmentGetter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    
    @Override
    public List<Department> getAll() {

        List<Department> listDeparment = new ArrayList<>();
        String query = "SELECT * FROM Departments";
        try (Connection connection = connectioner.getConnection()) {
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet result = statement.executeQuery()) {
                    while (result.next()) {
                        listDeparment.add(converter.convert(result));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DepartmentGetter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listDeparment;
    }

}
