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
package controller.servlet;

import dal.sql.SqlServerFactory;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.swing.JFileChooser;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 11, 2021 3:12:47 PM
 *
 */
public class Main {

    public static void main(String[] args) throws IOException, SQLException {
        JFileChooser chooser = new JFileChooser();
        int var = chooser.showOpenDialog(null);
        if(var == JFileChooser.APPROVE_OPTION){
            File file = chooser.getSelectedFile();
            String fileName = file.getName();
            byte[] bytes = Files.readAllBytes(file.toPath());
            
            String query = "INSERT INTO Files VALUES(?,?)";
            try(Connection connection = SqlServerFactory.getConnectioner().getConnection()){
                try(PreparedStatement statement = connection.prepareStatement(query)){
                    statement.setString(1, fileName);
                    statement.setBytes(2,bytes);
                    statement.executeUpdate();
                }
            }
        }
    }

}
