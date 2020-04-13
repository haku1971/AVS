/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author BinhNT
 */
public class User {

    private int id;
    private String username;
    private String password;
    private int rolenum;
    private String dob;
    private int job;
    private String workplace;
    private int gender;
    private String mail;
    private String phone;
    private String fullname;
    private int banstatus;

    public User() {
    }

    public User(int id, String username, String password, int rolenum, String dob, int job, String workplace, int gender, String mail, String phone, String fullname) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.rolenum = rolenum;
        this.dob = dob;
        this.job = job;
        this.workplace = workplace;
        this.gender = gender;
        this.mail = mail;
        this.phone = phone;
        this.fullname = fullname;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRolenum() {
        return rolenum;
    }
    
    public String getRolenumString() {
        if(rolenum==1) {
            return "Admin";
        }
        return "User";
    }

    public void setRolenum(int rolenum) {
        this.rolenum = rolenum;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    

    public int getJob() {
        return job;
    }

    public void setJob(int job) {
        this.job = job;
    }


    public String getWorkplace() {
        return workplace;
    }

    public void setWorkplace(String workplace) {
        this.workplace = workplace;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getBanstatus() {
        return banstatus;
    }
    
    public String getBanstatusString() {
        if(banstatus==1) {
            return "Banned";
        }
        return "Active";
    }

    public void setBanstatus(int banstatus) {
        this.banstatus = banstatus;
    }
    
    
}
