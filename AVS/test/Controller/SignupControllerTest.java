/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author quang
 */
public class SignupControllerTest {

    public SignupControllerTest() {
    }
    protected int success;

    @Before
    public void setUp() {
        success = 0;
    }

    @Test
    public void testSuccessIsFail() {
        assertEquals("Fail", success, 0);
    }

    @Test
    public void testSuccessIsSuccess() {
        success = 1;
        assertEquals("Success", success, 1);
    }
}
