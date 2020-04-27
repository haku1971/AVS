/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author quang
 */
public class Likecomment {
    private int userid;
    private int commentid;
    private int status;
    private String username;
    private String fullname;
    
    public Likecomment() {
    }

    public Likecomment(int userid, int commentid, int status, String username, String fullname) {
        this.userid = userid;
        this.commentid = commentid;
        this.status = status;
        this.username = username;
        this.fullname = fullname;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getCommentid() {
        return commentid;
    }

    public void setCommentid(int commentid) {
        this.commentid = commentid;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }
    
  
    
    
    
}
