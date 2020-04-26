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
    private int modid;
    private User user;
    private Algorithm algo;
    private User admin;
    private News news;
    private String modtime;
    private int banStatus;
    private String action;

    public History() {
    }
   
    public int getModID() {
        return modid;
    }

    public void setModID(int modid) {
        this.modid = modid;
    }

    public String getModTime() {
        return modtime;
    }
    
    public String getModTimeToMinute() {
        return modtime.substring(0, modtime.lastIndexOf(":"));
    }

    public void setModTime(String modtime) {
        this.modtime = modtime;
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

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
    
}
