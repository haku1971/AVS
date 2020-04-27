/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Model.User;
import java.util.Base64;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author BinhNT
 */
public class AuthenticateManagement {

    public enum CheckResult {
        SUCCESS,
        NO_USERNAME,
        PASSWORD_SHORT,
        USERNAME_LENGTH,
        WRONG_PASSWORD,
        EMPTY,
        EXIST_USERNAME,
        NOT_MATCH,
        INVALID_CHARACTER,
        NOT_NUMBER,
        WRONG_FORMAT,
        EXIST_MAIL
    }

    public boolean checkInput(String regex, String input) {
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(input);
        return matcher.matches();
    }

    public CheckResult checkUserAccount(String username, String password) {
        String regex = "^[a-zA-Z0-9_-]{6,15}$";
        boolean check = checkInput(regex, username);
        try {
            UserModel userDao = new UserModel();
            username=username.toLowerCase();
            String BasicBase64format  = Base64.getEncoder().encodeToString(password.getBytes());
            User user = userDao.getUserByUsername(username);
            if (check != true) {
                if (username.length() < 6) {
                    return CheckResult.USERNAME_LENGTH;
                } else {
                    return CheckResult.INVALID_CHARACTER;
                }
            } else if (user == null) {
                return CheckResult.NO_USERNAME;
            } else if (password.length() < 6) {
                return CheckResult.PASSWORD_SHORT;
            } else if (!user.getPassword().equals(BasicBase64format)) {
                return CheckResult.WRONG_PASSWORD;
            }
            return CheckResult.SUCCESS;
        } catch (Exception ex) {
            return CheckResult.NO_USERNAME;
        }

    }

    public CheckResult checkUserSignUp(String username) {
        String nameregex = "^[a-zA-Z0-9_-]{6,15}$";
        username=username.toLowerCase();
        boolean check = checkInput(nameregex, username);
        try {
            UserModel userDao = new UserModel();
            User user = userDao.getUserByUsername(username);
            if (check != true) {
                if (username.length() < 6) {
                    return CheckResult.USERNAME_LENGTH;
                } else {
                    return CheckResult.INVALID_CHARACTER;
                }
            } else if (user != null) {
                return CheckResult.EXIST_USERNAME;
            }

            return CheckResult.SUCCESS;
        } catch (Exception ex) {
            return CheckResult.NO_USERNAME;
        }

    }

    public CheckResult checkPassword(String password, String repassword) {
        try {
            if (password.length() < 6) {
                return CheckResult.PASSWORD_SHORT;
            } else if (!password.equals(repassword)) {
                return CheckResult.NOT_MATCH;
            }
            return CheckResult.SUCCESS;
        } catch (Exception ex) {
            return CheckResult.NO_USERNAME;
        }

    }

    public CheckResult checkNumber(String number) {
        String numberregex = "^[0-9]+";
        boolean check = checkInput(numberregex, number);
        try {
            if (check != true) {
                return CheckResult.NOT_NUMBER;
            }
            return CheckResult.SUCCESS;
        } catch (Exception ex) {
            return CheckResult.NO_USERNAME;
        }

    }

    public CheckResult checkMail(String mail) {
        String mailregex = "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$";
        boolean check = checkInput(mailregex, mail);
        try {
            UserModel userDao = new UserModel();
            User user = userDao.getUserByMail(mail);
            if (check != true) {

                return CheckResult.WRONG_FORMAT;
            }else if (user!=null) {
                return CheckResult.EXIST_MAIL;
            }
            return CheckResult.SUCCESS;
        } catch (Exception ex) {
            return CheckResult.NO_USERNAME;
        }

    }
}
