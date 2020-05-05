
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.UserDAO;
import Model.User;
import java.util.Base64;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
import org.mockito.Mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.mockito.invocation.InvocationOnMock;
import org.mockito.stubbing.Answer;

/**
 *
 * @author quangnhse05858
 */
public class LoginControllerTest {

    public LoginControllerTest() {
    }
    private String username;
    private String password;
    private String expect_edencrypt_password;
    @Mock
    private UserDAO userdao;

    @Before
    public void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
        username = "duongph";
        password = "123456";

    }
     public void createMockUser() throws Exception {
        when(userdao.getUserByUsername(username)).thenAnswer(new Answer<User>() {
            public User answer(InvocationOnMock invocation)
                    throws Throwable {
                return getUser();
            }
        });
    }
    @Test
    public void testLoginCorrectUsernameAndWrongPassword() throws Exception {
        String actualusername = "duongph";
        String actualpassword = "125524";
        createMockUser();
        User user = userdao.getUserByUsername(actualusername);
        assertNotEquals("Wrong password.", user.getPassword(), encryptPass(actualpassword));
    }

    @Test
    public void testLoginWrongUsernameAndWrongPassword() throws Exception {
        String actualusername = "duongph";
        String actualpassword = "duongph";
        createMockUser();
        User user = userdao.getUserByUsername(actualusername);
        assertNotEquals("Wrong password.", user.getPassword(), encryptPass(actualpassword));
    }

    @Test
    public void testEncryptPassword() {
        password = "123456";
        expect_edencrypt_password = "MTIzNDU2";
        assertEquals("Two password is not equal.", expect_edencrypt_password, encryptPass(password));
    }

   
    @Test
    public void testLoginNotExistUsername() throws Exception {
        username = "binhthanh";
        createMockUser();
        User user = userdao.getUserByUsername(username);
        assertNotEquals("Wrong username.", username, user.getUsername());
    }

    @Test
    public void testLoginSuccess() throws Exception {
        createMockUser();
        User user = userdao.getUserByUsername(username);
        assertEquals("Wrong account", username, user.getUsername());
        assertEquals("Wrong account", encryptPass(password), user.getPassword());
    }

    private User getUser() {
        User user = new User(1, "duongph", encryptPass(password), 1, "22/12/1998", 2, "Ha Noi", 1, "duongph@fpt.edu.vn", "0936219916", "Phi Hoang Duong");
        return user;
    }

    public String encryptPass(String password) {
        return Base64.getEncoder().encodeToString(password.getBytes());
    }
}

