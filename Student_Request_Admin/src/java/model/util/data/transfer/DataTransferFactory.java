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
package model.util.data.transfer;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 5, 2021 11:47:16 PM
 *
 */

public class DataTransferFactory {

    public static FileDownloadable getFileDowload(){
        return new FileDownloader();
    }
    
}
