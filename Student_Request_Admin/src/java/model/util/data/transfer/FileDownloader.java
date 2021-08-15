/****************************************************************
* Copyright [2021] [FPT University]          
*                                                             
* This file create by [Hoang Lam]                                 
* If you want to use this file in your project,                
* please contact to <https://www.facebook.com/hoanglammaster> 
* or <hoanglammaster@gmail.com>          
* Do not use without permission                                
*                                                             
* “All I know is that I do not know anything”― Socrates      
*****************************************************************/

package model.util.data.transfer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 11, 2021  2:49:17 PM
 * 
 */

class FileDownloader implements FileDownloadable{

    @Override
    public void download(File file, HttpServletResponse response) {
        try{
        File newFile = new File(file.getName());
        OutputStream outStream;
        try (FileInputStream inStream = new FileInputStream(file)) {
            
            // gets MIME type of the file
            String mimeType = Files.probeContentType(file.toPath());
            
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }  
            // modifies response
            response.setContentType(mimeType);
            response.setContentLength((int) newFile.length());
            // forces download
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", newFile.getName());
            response.setHeader(headerKey, headerValue);
            //obtains response's output stream
            outStream = response.getOutputStream();
            byte[] buffer = new byte[2048];
            int bytesRead = 0;
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }
        outStream.close();
        }catch(IOException ex){
            Logger.getLogger(FileDownloader.class.getName()).log(Level.SEVERE, "saveFile", ex);
        }
    }
    
}
