/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import DBContext.DBContext;
import Model.Comment;
import Model.News;
import Model.User;
import Model.Likecomment;
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
public class CommentDAO {

    private final DBContext db;

    public CommentDAO() throws Exception {
        db = new DBContext();
    }

    //Like comment
    public ArrayList<Likecomment> getTotalLikecommentByCommentId(int commentid) throws Exception {
        String query = "SELECT  u.user_FullName fullname,u.user_Name username, lc.[user_ID] userid,lc.[comment_ID] commentid FROM LikeComment lc \n"
                + "               inner join Comments c on lc.comment_ID=c.comment_ID inner join Users u on u.user_ID= lc.user_ID\n"
                + "                 where lc.comment_ID= ? order by lc.comment_ID asc";
        ArrayList<Likecomment> listalllikebycommentid = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, commentid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Likecomment votecomment = new Likecomment();
                votecomment.setUserid(rs.getInt("userid"));
                votecomment.setFullname(rs.getString("fullname"));
                votecomment.setUsername(rs.getString("username"));
                votecomment.setCommentid(rs.getInt("commentid"));
                listalllikebycommentid.add(votecomment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listalllikebycommentid;
    }

    //Like comment
    public ArrayList<Likecomment> getAllLikeComment() throws Exception {
        String query = "SELECT  u.user_FullName fullname,u.user_Name username, lc.[user_ID] userid,lc.[comment_ID] commentid "
                + "FROM LikeComment lc \n"
                + "inner join Comments c on lc.comment_ID=c.comment_ID inner join Users u on u.user_ID= lc.user_ID"
                + " order by lc.comment_ID asc";
        ArrayList<Likecomment> listalllike = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {
                Likecomment votecomment = new Likecomment();
                votecomment.setUserid(rs.getInt("userid"));
                votecomment.setFullname(rs.getString("fullname"));
                votecomment.setUsername(rs.getString("username"));
                votecomment.setCommentid(rs.getInt("commentid"));
                listalllike.add(votecomment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listalllike;
    }

    //like comment
    public void saveLikeComment(int userid, int commentid) throws Exception {
        //excute update
        String query = "INSERT INTO [LikeComment] ([user_ID],[comment_ID])VALUES( ? ,?)";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userid);
            ps.setInt(2, commentid);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //delete cua like comment by comment id
    public void deleteLikeComment(int commentid,int userid) throws Exception {
        //excute update
        String query = "DELETE FROM LikeComment WHERE comment_ID = ? and user_ID= ?";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, commentid);
            ps.setInt(2, userid);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //use when ad delete a comment
    //delete all likecomment in that comment id
    public void adDeleteLikeCommentBycommentId(int commentid) throws Exception {
        //excute update
        String query = "DELETE FROM LikeComment WHERE comment_ID = ?";
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
            Logger.getLogger(CommentDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        String query = "select u.user_Name,u.user_FullName, cm.comment_Content,cm.comment_ID,cm.comment_Datetime,cm.user_ID, n.news_ID from Comments cm\n"
                + "inner join News n on cm.news_ID= n.news_ID inner join Users u on u.user_ID= cm.user_ID where cm.news_ID =?";
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
                news.setNewsID(rs.getInt("news_ID"));
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
