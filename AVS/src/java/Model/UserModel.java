/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Algorithm;
import Entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author BinhNT
 */
public class UserModel {

    private final DBContext db;

    public UserModel() throws Exception {
        db = new DBContext();
    }

    public User getUserByUsername(String username) throws Exception {
        String query = "select * from Users where user_Name=?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_Name"));
                user.setPassword(rs.getString("user_Password"));
                user.setRolenum(rs.getInt("user_RoleNum"));
                user.setDob(rs.getString("user_DOB"));
                user.setJob(rs.getInt("job_ID"));
                user.setWorkplace(rs.getString("user_Workplaces"));
                user.setGender(rs.getInt("user_Gender"));
                user.setMail(rs.getString("user_Mail"));
                user.setPhone(rs.getString("user_Phone"));
                user.setFullname(rs.getString("user_Fullname"));
                user.setBanstatus(rs.getInt("ban_status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public User getUserByMail(String mail) throws Exception {
        String query = "select * from Users where user_Mail=?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, mail);
            rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_Name"));
                user.setPassword(rs.getString("user_Password"));
                user.setRolenum(rs.getInt("user_RoleNum"));
                user.setDob(rs.getString("user_DOB"));
                user.setJob(rs.getInt("job_ID"));
                user.setWorkplace(rs.getString("user_Workplaces"));
                user.setGender(rs.getInt("user_Gender"));
                user.setMail(rs.getString("user_Mail"));
                user.setPhone(rs.getString("user_Phone"));
                user.setFullname(rs.getString("user_Fullname"));
                user.setBanstatus(rs.getInt("ban_status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public User getUserByUserID(String userid) throws Exception {
        String query = "select * from Users where user_ID=?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, userid);
            rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_Name"));
                user.setPassword(rs.getString("user_Password"));
                user.setRolenum(rs.getInt("user_RoleNum"));
                user.setDob(rs.getString("user_DOB"));
                user.setJob(rs.getInt("job_ID"));
                user.setWorkplace(rs.getString("user_Workplaces"));
                user.setGender(rs.getInt("user_Gender"));
                user.setMail(rs.getString("user_Mail"));
                user.setPhone(rs.getString("user_Phone"));
                user.setFullname(rs.getString("user_Fullname"));
                user.setBanstatus(rs.getInt("ban_status"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public void insertUser(String username,
            String password, String fullname, String dob, int job,
            String workplace, int gender, String mail, String phone) throws Exception {
        String query1 = "insert into Users(user_Name,user_Password,user_RoleNum,"
                + "user_Fullname,user_DOB,user_Workplaces,user_Gender,user_Mail,"
                + "user_Phone,job_ID,ban_Status)\n"
                + "values (?,?,2,?,?,?,?,?,?,?,0)";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query1);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullname);
            ps.setString(4, dob);
            ps.setString(5, workplace);
            ps.setInt(6, gender);
            ps.setString(7, mail);
            ps.setString(8, phone);
            ps.setInt(9, job);
            ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void UpdateUser(int id, String fullname, String dob, int job,
            String workplace, int gender, String phone) throws Exception {
        String query1 = "UPDATE Users\n"
                + "SET user_FullName=?,user_DOB=?,user_Workplaces=?,user_gender=?,user_Phone=?,job_ID=? \n"
                + "WHERE user_ID = ?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query1);
            ps.setString(1, fullname);
            ps.setString(2, dob);
            ps.setString(3, workplace);
            ps.setInt(4, gender);
            ps.setString(5, phone);
            ps.setInt(6, job);
            ps.setInt(7, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void UpdatePassword(int id, String password) throws Exception {
        String query1 = "UPDATE Users\n"
                + "SET user_Password=? WHERE user_ID = ?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query1);
            ps.setString(1, password);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<User> getAllUser() throws Exception {
        ArrayList<User> userlist = new ArrayList();
        String query = "select * from Users ";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_Name"));
                user.setPassword(rs.getString("user_Password"));
                user.setRolenum(rs.getInt("user_RoleNum"));
                user.setDob(rs.getString("user_DOB"));
                user.setJob(rs.getInt("job_ID"));
                user.setWorkplace(rs.getString("user_Workplaces"));
                user.setGender(rs.getInt("user_Gender"));
                user.setMail(rs.getString("user_Mail"));
                user.setPhone(rs.getString("user_Phone"));
                user.setFullname(rs.getString("user_Fullname"));
                user.setBanstatus(rs.getInt("ban_status"));
                userlist.add(user);
            }
        } catch (SQLException e) {
            User user = new User();
            user.setId(rs.getInt("user_ID"));
            user.setUsername(rs.getString("user_Name"));
            user.setPassword(rs.getString("user_Password"));
            user.setRolenum(rs.getInt("user_RoleNum"));
            user.setDob(rs.getString("user_DOB"));
            user.setJob(rs.getInt("job_ID"));
            user.setWorkplace(rs.getString("user_Workplaces"));
            user.setGender(rs.getInt("user_Gender"));
            user.setMail(rs.getString("user_Mail"));
            user.setPhone(rs.getString("user_Phone"));
            user.setFullname(rs.getString("user_Fullname"));
            user.setBanstatus(rs.getInt("ban_status"));
            userlist.add(user);
            e.printStackTrace();
        }

        return userlist;
    }

    public void banUserID(int id) throws Exception {
        String query = "Update Users\n"
                + "Set ban_Status = 1\n"
                + "where user_ID = ?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "" + id);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unbanUserID(int id) throws Exception {
        String query = "Update Users\n"
                + "Set ban_Status = 0\n"
                + "where user_ID = ?";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "" + id);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getAllSearchUser(String searchstring) throws SQLException, Exception {
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT COUNT(*) as totalpage\n"
                    + "FROM (select *, ROW_NUMBER() over(order by user_id) as rownumber from Users) as n\n"
                    + "WHERE  user_Name like ?";

            statement
                    = connection.prepareStatement(statementstring);
            statement.setString(1, '%' + searchstring + '%');
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

    public ArrayList<User> getPagingSearchUser(String searchstring, String columnname, String sortorder, int start, int end) throws SQLException, Exception {
        ArrayList<User> userlist = new ArrayList();
        DBContext dbManager = new DBContext();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = dbManager.getConnection();
            String statementstring = "SELECT *\n"
                    + "FROM (select *, ROW_NUMBER() over(order by user_id) as rownumber from Users) as n\n"
                    + "WHERE  n.rownumber >= ? and n.rownumber <= ? and user_Name like ? ";
            statementstring += "ORDER BY " + columnname + " " + sortorder;
            statement
                    = connection.prepareStatement(statementstring);
            statement.setInt(1, start);
            statement.setInt(2, end);
            statement.setString(3, '%' + searchstring + '%');
            rs = statement.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_Name"));
                user.setPassword(rs.getString("user_Password"));
                user.setRolenum(rs.getInt("user_RoleNum"));
                user.setDob(rs.getString("user_DOB"));
                user.setJob(rs.getInt("job_ID"));
                user.setWorkplace(rs.getString("user_Workplaces"));
                user.setGender(rs.getInt("user_Gender"));
                user.setMail(rs.getString("user_Mail"));
                user.setPhone(rs.getString("user_Phone"));
                user.setFullname(rs.getString("user_Fullname"));
                user.setBanstatus(rs.getInt("ban_status"));
                userlist.add(user);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(connection, statement, rs);
        }
        return userlist;
    }
}
