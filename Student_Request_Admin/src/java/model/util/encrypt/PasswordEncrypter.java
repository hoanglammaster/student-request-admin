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
package model.util.encrypt;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

/**
 *
 * @author Hoang Lam <hoanglammaster@gmail.com>
 *
 * @Since Jul 5, 2021 2:54:13 PM
 *
 */
class PasswordEncrypter implements PasswordEncryptable {

    private final SecureRandom secureRandom;
    private final int cost;
    public PasswordEncrypter() {
        secureRandom = new SecureRandom();
        cost = DEFAULT_COST + secureRandom.nextInt(4);
    }
    public PasswordEncrypter(int cost) {
        secureRandom = new SecureRandom();
        if(cost<0||cost>27){
            this.cost = 27;
        }else{
            this.cost = cost;
        }
    }

    @Override
    public String encrypt(String password) {
        byte[] salt = new byte[SIZE / 8];
        secureRandom.nextBytes(salt);
        int id = 20 - secureRandom.nextInt(4);
        try {
            KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 1 << cost, SIZE);
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] secretKey = keyFactory.generateSecret(spec).getEncoded();
            byte[] hashPassword = new byte[salt.length + secretKey.length];
            System.arraycopy(salt, 0, hashPassword, 0, salt.length);
            System.arraycopy(secretKey, 0, hashPassword, salt.length, secretKey.length);
            Base64.Encoder encoder = Base64.getUrlEncoder().withoutPadding();
            return "$" + id + "$" + cost + "$" + encoder.encodeToString(hashPassword);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            Logger.getLogger(PasswordEncrypter.class.getName()).log(Level.SEVERE, "encrypt(String password)", ex);
            return null;
        }
    }

    @Override
    public String encrypt(String password, byte[] salt, int cost, int id) {
        try {
            KeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 1 << cost, SIZE);
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(ALGORITHM);
            byte[] secretKey = keyFactory.generateSecret(spec).getEncoded();
            byte[] hashPassword = new byte[salt.length + secretKey.length];
            System.arraycopy(salt, 0, hashPassword, 0, salt.length);
            System.arraycopy(secretKey, 0, hashPassword, salt.length, secretKey.length);
            Base64.Encoder encoder = Base64.getUrlEncoder().withoutPadding();
            return "$" + id + "$" + cost + "$" + encoder.encodeToString(hashPassword);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            Logger.getLogger(PasswordEncrypter.class.getName()).log(Level.SEVERE, "encrypt(String password, byte[] salt, int cost, int id)", ex);
            return null;
        }
    }

}
