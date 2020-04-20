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
public class Comment {
   private int commentid; 
   private String content;
   private String datetime;
   private User user;
   private News news;

    public Comment() {
    }

    public Comment(int commentid, String content, String datetime, User user, News news) {
        this.commentid = commentid;
        this.content = content;
        this.datetime = datetime;
        this.user = user;
        this.news = news;
    }

    public int getCommentid() {
        return commentid;
    }

    public void setCommentid(int commentid) {
        this.commentid = commentid;
    }

    public String getContent() {
        return content.replaceAll("\\s+"," ");
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public News getNews() {
        return news;
    }

    public void setNews(News news) {
        this.news = news;
    }
   
}
