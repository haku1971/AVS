/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
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
                user.setAge(rs.getInt("user_Age"));
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
                user.setAge(rs.getInt("user_Age"));
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
            String password, String fullname, int age, int job,
            String workplace, int gender, String mail, String phone) throws Exception {
        String query1 = "insert into Users(user_Name,user_Password,user_RoleNum,"
                + "user_Fullname,user_Age,user_Workplaces,user_Gender,user_Mail,"
                + "user_Phone,job_ID)\n"
                + "values (?,?,2,?,?,?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = db.getConnection();
            ps = conn.prepareStatement(query1);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullname);
            ps.setInt(4, age);
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
                user.setAge(rs.getInt("user_Age"));
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
}
