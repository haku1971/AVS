/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Algorithm;
import Entity.History;
import Entity.News;
import Entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Ukah
 */
public class HistoryModel {

    private final DBContext db;
    private UserModel userdao;
    private AlgorithmModel algodao;
    private NewsModel newsdao;

    public HistoryModel() throws Exception {
        db = new DBContext();
    }

    public ArrayList<History> getUserHistory() throws SQLException, Exception {
        ArrayList<History> listalgohistory = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT m.moduser_ID, m.user_ID, m.admin_id, m.moduser_Time, m.ban_Status, u.user_Name, a.user_Name as admin_name\n"
                    + "FROM Modify_Users m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join Users a on m.admin_id = a.user_ID";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                History history = new History();
                history.setModID(rs.getInt("moduser_ID"));
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_name"));
                history.setUser(user);
                User admin = new User();
                admin.setId(rs.getInt("admin_ID"));
                admin.setUsername(rs.getString("admin_name"));
                history.setAdmin(admin);
                history.setModTime(rs.getString("moduser_time"));
                history.setBanStatus(rs.getInt("ban_status"));
                listalgohistory.add(history);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listalgohistory;
    }

    public ArrayList<History> getAlgoHistory() throws SQLException, Exception {
        ArrayList<History> listalgohistory = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT m.modalgo_ID, m.user_ID, m.algo_ID, m.modalgo_Time, m.action , u.user_Name, a.algo_Name\n"
                    + "FROM ModifyAlgorithm m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join [Algorithm] a on m.algo_ID = a.algo_ID";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                History history = new History();
                history.setModID(rs.getInt("modalgo_ID"));
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_name"));
                history.setUser(user);
                Algorithm algo = new Algorithm();
                algo.setAlgoID(rs.getInt("algo_ID"));
                algo.setAlgoName(rs.getString("algo_name"));
                history.setAlgo(algo);
                history.setModTime(rs.getString("modalgo_time"));
                history.setAction(rs.getString("action"));
                listalgohistory.add(history);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listalgohistory;
    }

    public ArrayList<History> getNewsHistory() throws SQLException, Exception {
        ArrayList<History> listalgohistory = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String sql = "SELECT m.modnews_ID, m.user_ID, m.news_ID, m.modnews_Time, m.action , u.user_Name, n.news_Tittles\n"
                    + "FROM ModifyNews m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join News n on m.news_ID = n.news_ID";
            statement = connection.prepareStatement(sql);
            rs = statement.executeQuery();
            while (rs.next()) {
                History history = new History();
                history.setModID(rs.getInt("modnews_ID"));
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_name"));
                history.setUser(user);
                News news = new News();
                news.setNewsID(rs.getInt("news_ID"));
                news.setNewstittles(rs.getString("news_tittles"));
                history.setNews(news);
                history.setModTime(rs.getString("modnews_time"));
                history.setAction(rs.getString("Action"));
                listalgohistory.add(history);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listalgohistory;
    }

    public void insertUserHistory(int userid, int adminid, String currenttime, int banstatus) throws Exception {
        String query = "Insert into Modify_Users(user_ID,admin_id,moduser_Time,ban_Status)\n"
                + "values (?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userid);
            ps.setInt(2, adminid);
            ps.setString(3, currenttime);
            ps.setInt(4, banstatus);
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertAlgoHistory(int userid, int algoid, String currenttime, String action) throws Exception {
        String query = "Insert into ModifyAlgorithm (user_ID, algo_ID, modalgo_Time, action)\n"
                + "values (?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userid);
            ps.setInt(2, algoid);
            ps.setString(3, currenttime);
            ps.setString(4, action);
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertNewsHistory(int userid, int newsid, String currenttime, String action) throws Exception {
        String query = "Insert into ModifyNews(user_ID,news_id,modnews_Time,action)\n"
                + "values (?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userid);
            ps.setInt(2, newsid);
            ps.setString(3, currenttime);
            ps.setString(4, action);
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
