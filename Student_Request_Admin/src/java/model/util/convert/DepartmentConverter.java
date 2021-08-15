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
package model.util.convert;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.department.Department;
import model.department.DepartmentFactory;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 1:20:11 PM
 *
 */
class DepartmentConverter implements DepartmentConvertible {

    @Override
    public Department convert(ResultSet result) {
        try {
            int id = result.getInt("DepartmentId");
            String name = result.getString("DepartmentName");
            return DepartmentFactory.getDefaultDepartment(id, name);
        } catch (SQLException ex) {
            Logger.getLogger(DepartmentConverter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
