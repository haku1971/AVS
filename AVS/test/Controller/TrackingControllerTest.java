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
public class TrackingControllerTest {
    
    public TrackingControllerTest() {
    }
    protected String ipuser;
    @Before
    public void setUp() {
        ipuser = "";
    }
    @Test
    public void testGetValueIpIsNull() {
        assertTrue("Fail to get userip", ipuser== null|| ipuser.isEmpty());
    }
    @Test
    public void testGetValueIpIsNotNull() {
        ipuser= "192.168.1.3";
        assertTrue("Success", ipuser!= null);
    }
    
}
