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
public class CommentModel {

    private final DBContext db;

    public CommentModel() throws Exception {
        db = new DBContext();
    }

    public void editCommentById(String commentcontent, int commentid) {
        try {
            String query = "UPDATE [Comments] SET [comment_Content] = ? WHERE comment_ID= ?";
            DBContext dbManager = new DBContext();
            Connection conn = null;
            PreparedStatement ps = null; //de nhan paramenter
            try {
                conn = dbManager.getConnection();
                ps = conn.prepareStatement(query);
                ps.setString(1, commentcontent);
                ps.setInt(2, commentid);
                int executeUpdate;
                executeUpdate = ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (Exception ex) {
            Logger.getLogger(CommentModel.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void deleteCommentById(int commentid) throws Exception {
        //excute update
        String query = "DELETE FROM [Comments] WHERE comment_ID= ?";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, commentid);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void saveCommenttoDB(String content, String date, int userid, int newsid) throws Exception {
        //excute update
        String query = "INSERT INTO [AVS_Database_Final].[dbo].[Comments] VALUES(?,?,?,?)";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, content);
            ps.setString(2, date);
            ps.setInt(3, userid);
            ps.setInt(4, newsid);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Comment> getAllCommentByNewsID(int newid) throws Exception {
        String query = "select u.user_Name,u.user_FullName, cm.comment_Content,cm.comment_ID,cm.comment_Datetime,cm.user_ID, n.news_ID from Comments cm\n" +
"inner join News n on cm.news_ID= n.news_ID inner join Users u on u.user_ID= cm.user_ID where cm.news_ID =?";
        ArrayList<Comment> listallcommentbynewid = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newid);
            rs = ps.executeQuery();

            while (rs.next()) {
                News news = new News();
                news.setNewID(rs.getInt("news_ID"));
                User user = new User();           
                user.setId(rs.getInt("user_ID"));
                user.setUsername(rs.getString("user_Name"));
                user.setFullname(rs.getString("user_FullName"));
                Comment comment = new Comment();
                comment.setCommentid(rs.getInt("comment_ID"));
                comment.setContent(rs.getString("comment_Content"));
                comment.setDatetime(rs.getString("comment_Datetime"));
                comment.setNews(news);
                comment.setUser(user);
                listallcommentbynewid.add(comment);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listallcommentbynewid;
    }
}
