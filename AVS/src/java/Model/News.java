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
public class News {

    private int newsID;
    private String newstittles;
    private String newscontent;
    private String newsdaterealease;
    private String newsresource;
    private String news_Imgs;
    private User user;
    private int deleted;
    
    public News() {
    }

    public News(int newsID, String newstittles, String newscontent, String newsdaterealease, String newsresource, String news_Imgs, User user,int deleted) {
        this.newsID = newsID;
        this.newstittles = newstittles;
        this.newscontent = newscontent;
        this.newsdaterealease = newsdaterealease;
        this.newsresource = newsresource;
        this.news_Imgs = news_Imgs;     
        this.user = user;
        this.deleted= deleted;
    }

    public int getDeleted() {
        return deleted;
    }
    
    public String getDeletedToString() {
        return deleted == 1 ? "Deleted" : "";
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }
    
    public String getNews_shortdescription() {
        int shortest = 10;
        if(getNewscontent().length()> shortest)
        {
            return getNewscontent().substring(0,shortest) + "...";
        }
        return getNewscontent();
        
    }

    public int getNewsID() {
        return newsID;
    }

    public void setNewsID(int newsID) {
        this.newsID = newsID;
    }

    public String getNewstittles() {
        return newstittles;
    }

    public void setNewstittles(String newstittles) {
        this.newstittles = newstittles;
    }

    public String getNewscontent() {
        return newscontent;
    }

    public void setNewscontent(String newscontent) {
        this.newscontent = newscontent;
    }

    public String getNewsdaterealease() {
        return newsdaterealease;
    }
    
    public String getNewsdaterealeaseToMinute() {
        return newsdaterealease.substring(0, newsdaterealease.lastIndexOf(":"));
    }

    public void setNewsdaterealease(String newsdaterealease) {
        this.newsdaterealease = newsdaterealease;
    }

    public String getNewsresource() {
        return newsresource;
    }

    public void setNewsresource(String newsresource) {
        this.newsresource = newsresource;
    }

    public String getNews_Imgs() {
        return news_Imgs.equals("null") ? "" : news_Imgs;
    }

    public void setNews_Imgs(String news_Imgs) {
        this.news_Imgs = news_Imgs;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
