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
import model.student.Student;
import model.student.StudentFactory;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 11:40:55 PM
 *
 */
class StudentConverter implements StudentConvertible {

    @Override
    public Student convert(ResultSet result) {
        try {
            int id = result.getInt("StudentId");
            String code = result.getString("StudentCode");
            String fullName = result.getString("FullName");
            return StudentFactory.getDefaultStudent(id, code, fullName);
        } catch (SQLException ex) {
            Logger.getLogger(StudentConverter.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
