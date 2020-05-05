/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DBContext.DBContext;
import Model.Algorithm;
import Model.History;
import Model.News;
import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Ukah
 */
public class HistoryDAO {

    private final DBContext db;
    private UserDAO userdao;
    private AlgorithmDAO algodao;
    private NewsDAO newsdao;

    public HistoryDAO() throws Exception {
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
                    + "FROM ModifyUser m\n"
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
        String query = "Insert into ModifyUser(user_ID,admin_id,moduser_Time,ban_Status)\n"
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
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<History> getPagingUserHistory(int start, int end) throws SQLException, Exception {
        ArrayList<History> listhistory = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT m.moduser_ID, m.user_ID, m.admin_id, m.moduser_Time, m.ban_Status, u.user_Name, a.user_Name as adminname\n"
                    + "FROM (select *, ROW_NUMBER() over(order by moduser_id desc) as rownumber from ModifyUser) as m\n"
                    + "inner join Users u on u.user_ID = m.user_ID\n"
                    + "inner join Users a on a.user_ID = m.admin_id\n"
                    + "WHERE  m.rownumber >= ? and m.rownumber <= ?";

            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(1, start);
            statement.setInt(2, end);
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
                admin.setUsername(rs.getString("adminname"));
                history.setAdmin(admin);
                history.setModTime(rs.getString("moduser_time"));
                history.setBanStatus(rs.getInt("ban_status"));
                listhistory.add(history);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listhistory;
    }

    public int getTotalUsersHistory() throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT count(*) as totalpage\n"
                    + "FROM (select *, ROW_NUMBER() over(order by moduser_id desc) as rownumber from ModifyUser) as m\n"
                    + "inner join Users u on u.user_ID = m.user_ID\n"
                    + "inner join Users a on a.user_ID = m.admin_id";

            statement
                    = connection.prepareStatement(statementstring);
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

    public ArrayList<History> getPagingAlgoHistory(int start, int end) throws SQLException, Exception {
        ArrayList<History> listhistory = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT m.modalgo_ID, m.user_ID, m.algo_ID, m.modalgo_Time, m.action , u.user_Name, a.algo_Name\n"
                    + "FROM (select *, ROW_NUMBER() over(order by modalgo_ID desc) as rownumber from ModifyAlgorithm) as m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join [Algorithm] a on m.algo_ID = a.algo_ID\n"
                    + "WHERE  m.rownumber >= ? and m.rownumber <= ?";

            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(1, start);
            statement.setInt(2, end);
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
                listhistory.add(history);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listhistory;
    }

    public int getTotalAlgoHistory() throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT count(*) as totalpage\n"
                    + "FROM (select *, ROW_NUMBER() over(order by modalgo_ID desc) as rownumber from ModifyAlgorithm) as m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join [Algorithm] a on m.algo_ID = a.algo_ID";

            statement
                    = connection.prepareStatement(statementstring);
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

    public ArrayList<History> getPagingNewsHistory(int start, int end) throws SQLException, Exception {
        ArrayList<History> listhistory = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT m.modnews_ID, m.user_ID, m.news_ID, m.modnews_Time, m.action , u.user_Name, n.news_Tittles\n"
                    + "FROM (select *, ROW_NUMBER() over(order by modnews_ID desc) as rownumber from ModifyNews) as m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join News n on m.news_ID = n.news_ID\n"
                    + "WHERE  m.rownumber >= ? and m.rownumber <= ?";

            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(1, start);
            statement.setInt(2, end);
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
                listhistory.add(history);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return listhistory;
    }

    public int getTotalNewsHistory() throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT count(*) as totalpage\n"
                    + "FROM (select *, ROW_NUMBER() over(order by modnews_ID desc) as rownumber from ModifyNews) as m\n"
                    + "inner join Users u on m.user_ID = u.user_ID\n"
                    + "inner join News n on m.news_ID = n.news_ID";

            statement
                    = connection.prepareStatement(statementstring);
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
