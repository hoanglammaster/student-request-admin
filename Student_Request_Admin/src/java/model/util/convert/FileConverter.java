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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 20, 2021 12:30:35 AM
 *
 */
class FileConverter implements FileConvertible {

    @Override
    public File convert(ResultSet result) {
        try {
            String fileName = result.getString("FilesName");
            byte[] byteArrays = result.getBytes("ByteArrays");
            File file = new File(fileName);
            try (FileOutputStream fos = new FileOutputStream(file)) {
                fos.write(byteArrays);
                return file;
            } catch (IOException ex) {
                Logger.getLogger(FileConverter.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FileConverter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

}
