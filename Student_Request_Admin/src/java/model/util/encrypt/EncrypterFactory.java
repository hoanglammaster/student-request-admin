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

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Created Jul 5, 2021 11:50:54 PM
 *
 */

public class EncrypterFactory {

    public static PasswordEncryptable getPasswordEncrypter() {
        return new PasswordEncrypter();
    }
    public static PasswordEncryptable getPasswordEncrypter(int cost) {
        return new PasswordEncrypter(cost);
    }
    public static PasswordAuthentication getPasswordAuthenticator(PasswordEncryptable passwordEncrypter) {
        return new PasswordAuthenticator(passwordEncrypter);
    }
}
