/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Algorithm;
import Entity.Algorithm;
import Entity.Tracking;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Asus
 */
public class TrackingModel {

    public void saveTracking(String ipuser, int algoid, String dateaccess, BigInteger totaltime) throws Exception {
        //excute update
        String query = "INSERT INTO [History](IP,algo_ID,dateAccess,totalTime) VALUES (?,?,?,?)";
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            connection = dbManager.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, ipuser);
            ps.setInt(2, algoid);
            ps.setString(3, dateaccess);
            ps.setString(4, totaltime.toString());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Tracking getUserAccess(String ipuser, int algoid, String dateaccess) throws Exception {
        String query = "SELECT [totalTime] FROM [AVS_Database_Final].[dbo].[History] where [IP] = ? and [algo_ID] = ? and dateAccess = ?";
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement ps = null; //de nhan paramenter
        ps = connection.prepareStatement(query);
        ps.setString(1, ipuser);
        ps.setInt(2, algoid);
        ps.setString(3, dateaccess);
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            while(rs.next()) {
                Tracking tracking = new Tracking();
                tracking.setTotalTime(new BigInteger(rs.getString("totalTime")));
                return tracking;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, ps, rs);
        }

        return null;
    }

    public void updateTracking(String ipuser, int algoid, String dateaccess, BigInteger timeCount) throws Exception {
        String query = "UPDATE [dbo].[History] SET [totalTime] = ? WHERE [IP] = '?' and [algo_ID] = ? and dateAccess = ?";
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            connection = dbManager.getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, timeCount.toString());
            ps.setString(2, ipuser);
            ps.setInt(3, algoid);
            ps.setString(4, dateaccess);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
