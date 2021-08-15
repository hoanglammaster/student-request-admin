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
package dal.sql.teacher;

import dal.sql.Connections;
import dal.sql.Gettable;
import model.teacher.Teacher;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 9:21:56 AM
 *
 */
public class TeacherDao {

    public static Gettable<Teacher> getTeacherGetter(Connections connection, Convertible<Teacher> converter) {
        return new Getter(connection, converter);
    }
}
