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
package model.util.encrypt;

import java.util.Arrays;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021 4:47:51 PM
 *
 */
class PasswordAuthenticator implements PasswordAuthentication {

    private  PasswordEncryptable passwordEncrypter;

    public PasswordAuthenticator(PasswordEncryptable passwordEncrypter) {
        this.passwordEncrypter = passwordEncrypter;
    }

    @Override
    public boolean authentic(String password, String token) {
        Matcher matcher = LAYOUT.matcher(token);
        if (!matcher.matches()) {
            throw new IllegalArgumentException("Token not correct : " + token);
        }
        try {
            int id = Integer.parseInt(matcher.group(1));
            int cost = Integer.parseInt(matcher.group(2));
            byte[] hashPassword = Base64.getUrlDecoder().decode(matcher.group(3));
            byte[] salt = Arrays.copyOfRange(hashPassword, 0, SIZE / 8);
            String encryptString = passwordEncrypter.encrypt(password, salt, cost, id);
            if (encryptString.equals(token)) {
                return true;
            }
        } catch (NumberFormatException ex) {
            Logger.getLogger(PasswordAuthenticator.class.getName()).log(Level.SEVERE, "authentic", ex);

        }
        return false;

    }

}
