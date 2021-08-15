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

import dal.sql.Connections;
import dal.sql.Gettable;
import model.student.Student;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 9:21:26 AM
 *
 */
public class StudentDao {

    public static Gettable<Student> getStudentGetter(Connections connection, Convertible<Student> converter) {
        return new Getter(connection, converter);
    }
}
