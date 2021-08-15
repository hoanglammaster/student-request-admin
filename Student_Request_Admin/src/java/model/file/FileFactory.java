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
package model.file;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 19, 2021 8:55:20 AM
 *
 */
public class FileFactory {

    public static File getFile(String fileName, byte[] byteArrays) {
        File file = new File(fileName);
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(byteArrays);
        } catch (IOException ex) {
            Logger.getLogger(FileFactory.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return file;
    }
}
