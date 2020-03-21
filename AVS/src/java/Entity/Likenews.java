/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author quang
 */
public class Likenews {
    private int userid;
    private int newsid;
    private int status;
    private String username;
    private String fullname;

    public Likenews(int userid, int newsid, int status, String username, String fullname) {
        this.userid = userid;
        this.newsid = newsid;
        this.status = status;
        this.username = username;
        this.fullname = fullname;
    }

    
    public Likenews() {
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getNewsid() {
        return newsid;
    }

    public void setNewsid(int newsid) {
        this.newsid = newsid;
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
