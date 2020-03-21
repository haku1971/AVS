/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.sql.Date;

/**
 *
 * @author Ukah
 */
public class History {
    private int modID;
    private User user;
    private Algorithm algo;
    private User admin;
    private News news;
    private String modTime;
    private int banStatus;

    public History() {
    }
   
    public int getModID() {
        return modID;
    }

    public void setModID(int modID) {
        this.modID = modID;
    }

    public String getModTime() {
        return modTime;
    }

    public void setModTime(String modTime) {
        this.modTime = modTime;
    }

    public int getBanStatus() {
        return banStatus;
    }
    
    public String getBanStatustoString() {
        if(banStatus==1) {
            return "Ban";
        }
        return "Unban";
    }

    public void setBanStatus(int banStatus) {
        this.banStatus = banStatus;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Algorithm getAlgo() {
        return algo;
    }

    public void setAlgo(Algorithm algo) {
        this.algo = algo;
    }

    public User getAdmin() {
        return admin;
    }

    public void setAdmin(User admin) {
        this.admin = admin;
    }

    public News getNews() {
        return news;
    }

    public void setNews(News news) {
        this.news = news;
    }
    
    
    
    
}
