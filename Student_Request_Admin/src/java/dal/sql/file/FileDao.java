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
package dal.sql.file;

import dal.sql.Connections;
import dal.sql.Gettable;
import java.io.File;
import model.util.convert.Convertible;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 9:20:33 AM
 *
 */
public class FileDao {

    public static Gettable<File> getFileGetter(Connections connection, Convertible<File> converter) {
        return new FileGetter(connection, converter);
    }
}
