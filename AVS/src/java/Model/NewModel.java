/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Comment;
import Entity.News;
import Entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author quang
 */
public class NewModel {

    public ArrayList<News> getAllNews() throws Exception {
        String query = "SELECT [new_ID],[new_Tittles],[new_Content],[new_DateRealease],[new_Resource],[new_Imgs],[user_ID] FROM [News]";
        ArrayList<News> listallnews = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);         
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                News news = new News();
                news.setNewID(rs.getInt("new_ID"));
                news.setNewtittles(rs.getString("new_Tittles"));
                news.setNewcontent(rs.getString("new_Content"));
                news.setNewdaterealease(rs.getString("new_DateRealease"));
                news.setNewresource(rs.getString("new_Resource"));
                news.setNew_Imgs(rs.getString("new_Imgs"));
                news.setUser(user);
                listallnews.add(news);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listallnews;
    }
public News getNewByNewsID(int newsid) throws Exception {
        String query = "SELECT [new_ID],[new_Tittles],[new_Content],[new_DateRealease],[new_Resource],[new_Imgs],[user_ID] FROM [News] where new_ID=?";
       News news = new News();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newsid);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_ID"));
                news.setNewID(rs.getInt("new_ID"));
                news.setNewtittles(rs.getString("new_Tittles"));
                news.setNewcontent(rs.getString("new_Content"));
                news.setNewdaterealease(rs.getString("new_DateRealease"));
                news.setNewresource(rs.getString("new_Resource"));
                news.setNew_Imgs(rs.getString("new_Imgs"));
                news.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return news;
    }
    public void UpdateNewbyNewId(String title, String newcontent, String newdate, String newresource, String newimage, int newsid) {
        try {
            String query = "UPDATE [AVS_Database_Final].[dbo].[News]  SET [new_Tittles] = ?,[new_Content] =?,"
                    + "[new_DateRealease] =?,[new_Resource] = ?,[new_Imgs] =? WHERE new_ID= ?";
            DBContext dbManager = new DBContext();
            Connection conn = null;
            PreparedStatement ps = null; //de nhan paramenter
            try {
                conn = dbManager.getConnection();
                ps = conn.prepareStatement(query);
                ps.setString(1, title);
                ps.setString(2, newcontent);
                ps.setString(3, newdate);
                ps.setString(4, newresource);
                ps.setString(5, newimage);
                ps.setInt(6, newsid);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (Exception ex) {
            Logger.getLogger(CommentModel.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    /*
     public void deleteNewById(int newid) throws Exception {
     //excute update
     String query = "";
     DBContext dbManager = new DBContext();
     Connection conn = null;
     PreparedStatement ps = null; //de nhan paramenter
     try {
     conn = dbManager.getConnection();
     ps = conn.prepareStatement(query);
     ps.setInt(1, newid);
     int executeUpdate;
     executeUpdate = ps.executeUpdate();
     } catch (SQLException e) {
     e.printStackTrace();
     }
     }
     */

    public void createNews(String title, String newcontent, String newdate, String newresource, String newimage, int newsid) throws Exception {
        //excute insert
        String query = "INSERT INTO [AVS_Database_Final].[dbo].[News] VALUES  (?,?,?,?,?,?)";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, newcontent);
            ps.setString(3, newdate);
            ps.setString(4, newresource);
            ps.setString(5, newimage);
            ps.setInt(6, newsid);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
