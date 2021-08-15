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
package model.util.convert;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.teacher.Teacher;
import model.teacher.TeacherFactory;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 11:42:49 PM
 *
 */
class TeacherConverter implements TeacherConvertible {

    @Override
    public Teacher convert(ResultSet result) {
        try {
            int teacherId = result.getInt("TeacherId");
            String teacherName = result.getString("TeacherName");
            return TeacherFactory.getDefaultTeacher(teacherId, teacherName);
        } catch (SQLException ex) {
            Logger.getLogger(TeacherConverter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
