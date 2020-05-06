/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DBContext.DBContext;
import Model.Algorithm;
import Model.Algorithm;
import Model.Tracking;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Asus
 */
public class TrackingDAO {

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
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            statement
                    = connection.prepareStatement("SELECT [totalTime] FROM [AVS_Database_Final].[dbo].[History] where [IP] = ? and [algo_ID] = ? and dateAccess = ?");
            statement.setString(1, ipuser);
            statement.setInt(2, algoid);
            statement.setString(3, dateaccess);
            rs = statement.executeQuery();
            if (rs.next()) {
                Tracking tracking = new Tracking();
                tracking.setTotalTime(new BigInteger(rs.getString("totalTime")));
                return tracking;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }

        return null;
    }

    public void updateTracking(String ipuser, int algoid, String dateaccess, BigInteger timeCount) throws Exception {
        String query = "UPDATE [dbo].[History] SET [totalTime] = ? WHERE [IP] = ? and [algo_ID] = ? and dateAccess = ?";
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

    public ArrayList<Tracking> getPagingTrackingHistory(int start, int end, int daysago) throws Exception {
        ArrayList<Tracking> listTracking = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT tableSum.algo_ID,algo.algo_Name, tableSum.totalTime, tableSum.TotalPeople \n" +
"                    from (SELECT tabletime.algo_ID, Sum(tabletime.totalTime) as totalTime,Count(tabletime.IP) as TotalPeople,ROW_NUMBER() over(order by algo_ID asc) as rownumber \n" +
"                   FROM (select *, ROW_NUMBER() over(order by history_ID desc) as rownumber from History where dateAccess > CURRENT_TIMESTAMP-?) as tabletime\n" +
"                    GROUP BY algo_ID) as tableSum inner join Algorithm algo on tableSum.algo_ID= algo.algo_ID where tableSum.rownumber >= ? and tableSum.rownumber <= ?";

            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(2, start);
            statement.setInt(3, end);
            statement.setInt(1, daysago);
            rs = statement.executeQuery();
            while (rs.next()) {
                Tracking tracking = new Tracking();
                tracking.setAlgoID(rs.getInt("algo_ID"));
                tracking.setAlgoName(rs.getString("algo_Name"));
                tracking.setTotalTime(new BigInteger(rs.getString("totalTime")));
                tracking.setTotalPeople(rs.getInt("TotalPeople"));
                listTracking.add(tracking);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listTracking;
    }

    public int getTotalTrackingHistory(int daysago) throws Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT count(*) as totalpage from(select count(algo_ID) as totalPage from  History where dateAccess > CURRENT_TIMESTAMP-? group by algo_ID) as a";

            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(1, daysago);
            rs = statement.executeQuery();
            if (rs.next()) {
                return (rs.getInt("totalpage"));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }

        return 0;
    }
}
