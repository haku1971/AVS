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
public class News {

    private int newID;
    private String newtittles;
    private String newcontent;
    private String newdaterealease;
    private String newresource;
    private String new_Imgs;
    private User user;
    
    public News() {
    }

    public News(int newID, String newtittles, String newcontent, String newdaterealease, String newresource, String new_Imgs, User user) {
        this.newID = newID;
        this.newtittles = newtittles;
        this.newcontent = newcontent;
        this.newdaterealease = newdaterealease;
        this.newresource = newresource;
        this.new_Imgs = new_Imgs;     
        this.user = user;
    }

    public String getNews_shortdescription() {
        if(getNewcontent().length()<0)
        {
            return "Title is updating";
        }
        return getNewcontent().substring(0, 8)+"...........";
        
    }
   

    public int getNewID() {
        return newID;
    }

    public void setNewID(int newID) {
        this.newID = newID;
    }

    public String getNewtittles() {
        return newtittles;
    }

    public void setNewtittles(String newtittles) {
        this.newtittles = newtittles;
    }

    public String getNewcontent() {
        return newcontent;
    }

    public void setNewcontent(String newcontent) {
        this.newcontent = newcontent;
    }

    public String getNewdaterealease() {
        return newdaterealease;
    }

    public void setNewdaterealease(String newdaterealease) {
        this.newdaterealease = newdaterealease;
    }

    public String getNewresource() {
        return newresource;
    }

    public void setNewresource(String newresource) {
        this.newresource = newresource;
    }

    public String getNew_Imgs() {
        return new_Imgs;
    }

    public void setNew_Imgs(String new_Imgs) {
        this.new_Imgs = new_Imgs;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
